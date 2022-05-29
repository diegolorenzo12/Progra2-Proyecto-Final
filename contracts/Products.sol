//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./Owners.sol";

contract Products {
    //referencia al contrato en Owner.sol
    Owners public owners_ref;

    //El address se le pasa al crear el contrato en scripts/deploy_with_web3.ts
    constructor(Owners _addrOwner) {
        owners_ref = _addrOwner;
        currentProductId = 0;
    }

    //--------------------------------------------------
    //linea de productos
    //--------------------------------------------------

    struct ProductLine {
        string productName;
        string productDescription;
        address owner;
    }

    //mapping de un uint UPC(universal product code) a un product line
    mapping(uint256 => ProductLine) productLines;

    //añade nuevo product line
    function addProductLine(
        uint256 _UPC,
        string memory _name,
        string memory _productDescription
    ) public ownerExists(msg.sender) {
        productLines[_UPC] = ProductLine(
            _name,
            _productDescription,
            msg.sender
        );
    }

    function getProductLineOwner(uint256 _UPC) public view returns (address) {
        return productLines[_UPC].owner;
    }

    event getProductLineOwnerEvent(address _ownerAddr);

    function emitProductLineOwner(uint256 _UPC) public {
        emit getProductLineOwnerEvent(productLines[_UPC].owner);
    }

    //--------------------------------------------------
    //productos solos
    //--------------------------------------------------

    uint256 currentProductId; //definido como 0 en el constructor

    //estados que puede tener un producto unico
    enum State {
        New, // 0
        Shipping, // 1
        Received, // 2
        Purchased // 3
    }
    State constant defaultState = State.New;

    //guarda toda la info relacionada con un producto unico
    struct Product {
        uint256 UPC; //universal product code, esto es el product Line Id
        address currentOwner;
        address[] pastOwnersId;
        State productState;
        //uint idLote;
        //uint CreationDate;
    }

    //mapping productId -> Product struct
    mapping(uint256 => Product) products;

    //crea una nueva entrada en el mapping de IdProduct a un struct de producto
    function addProduct(uint256 _UPC) public isProductLineOwner(_UPC) {
        address[] memory emptyPastOwners;
        products[currentProductId] = Product(
            _UPC,
            msg.sender,
            emptyPastOwners,
            State.New
        );
        currentProductId++;
    }

    function changeState(uint256 _idProduct, uint256 _newOwnerRole) private {
        if (_newOwnerRole == 0) {
            //manufacter
            products[_idProduct].productState = State.New;
        } else if (_newOwnerRole == 1) {
            //distributor
            products[_idProduct].productState = State.Shipping;
        } else if (_newOwnerRole == 2) {
            //retail
            products[_idProduct].productState = State.Received;
        } else {
            //consumer
            products[_idProduct].productState = State.Purchased;
        }
    }

    //solo el owner puede llamar esta funcion
    function transferOwwnership(uint256 _idProduct, address _newOwner)
        public
        isProductOwner(_idProduct)
        ownerExists(_newOwner)
    {
        products[_idProduct].pastOwnersId.push(msg.sender);
        products[_idProduct].currentOwner = _newOwner;

        //agarro el rol del nuevo owner
        uint256 role = owners_ref.getOwnerRole(_newOwner);

        //cambio el estado del producto segun el nuevo dueño
        changeState(_idProduct, role);
    }

    function getPastOwners(uint256 _idProduct)
        public
        view
        returns (address[] memory)
    {
        return products[_idProduct].pastOwnersId;
    }

    function getProductState(uint256 _idProduct) public view returns (State) {
        return products[_idProduct].productState;
    }

    event getPastOwnersEvent(address[] _pastOwners);

    function emitPastOwners(uint256 _idProduct) public {
        emit getPastOwnersEvent(products[_idProduct].pastOwnersId);
    }

    event getProductStateEvent(State _productState);

    function emitProductState(uint256 _idProduct) public {
        emit getProductStateEvent(products[_idProduct].productState);
    }

    //--------------------------------------------------
    //Modifiers
    //--------------------------------------------------

    modifier ownerExists(address _owner) {
        require(owners_ref.ownerExists(_owner), "El owner no existe");
        _;
    }

    modifier isProductLineOwner(uint256 _UCP) {
        require(
            productLines[_UCP].owner == msg.sender,
            "necesitar ser owner del product line para hacer eso"
        );
        _;
    }

    modifier isProductOwner(uint256 _idProduct) {
        require(
            products[_idProduct].currentOwner == msg.sender,
            "necesitar ser owner del producto para hacer eso"
        );
        _;
    }
}
