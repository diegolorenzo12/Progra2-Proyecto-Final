pragma solidity ^0.5.0;

import "./Owner.sol";

contract Products {
    
    //referencia al contrato en Owner.sol
    Owners public owners_ref;

    //El address se le pasa al crear el contrato en scripts/deploy_with_web3.ts
    constructor(Owners _addrOwner) public{
        owners_ref = _addrOwner;
        currentProductId=0;
    }


    //--------------------------------------------------
    //linea de productos
    //--------------------------------------------------

    struct ProductLine{
        string productName;
        string productDescription;
        address owner;
    }

    //mapping de un uint UPC(universal product code) a un product line
    mapping (uint => ProductLine) productLines;

    
    //añade nuevo product line
    function addProductLine(uint _UPC, string memory _name, string memory _productDescription) ownerExists(msg.sender) public{
        productLines[_UPC] =  ProductLine( _name, _productDescription, msg.sender);
    }

    function getProductLineOwner(uint _UPC) public view returns (address){
        return productLines[_UPC].owner;
    }


    //--------------------------------------------------
    //productos solos
    //--------------------------------------------------

    uint currentProductId; //definido como 0 en el constructor
    
    //estados que puede tener un producto unico
    enum State { 
        New,        // 0
        Shipping,   // 1
        Received,   // 2
        Purchased   // 3
    }    
    State constant defaultState = State.New;
    
    //guarda toda la info relacionada con un producto unico
    struct Product{
        uint UPC;  //universal product code, esto es el product Line Id
        address currentOwner;
        address [] pastOwnersId;
        State productState;
        //uint idLote;
        //uint CreationDate;
    }

    //mapping productId -> Product struct
    mapping (uint => Product) products;

    //crea una nueva entrada en el mapping de IdProduct a un struct de producto
    function addProduct(uint _UPC) isProductLineOwner(_UPC) public{
        address[] memory emptyPastOwners;
        products[currentProductId] = Product (_UPC, msg.sender, emptyPastOwners, State.New);
        currentProductId++;
    }

    function changeState(uint _idProduct, uint _newOwnerRole) private{
        if(_newOwnerRole == 0){ //manufacter
            products[_idProduct].productState = State.New;
        }else if(_newOwnerRole == 1){ //distributor
            products[_idProduct].productState = State.Shipping;
        }else if(_newOwnerRole == 2){ //retail
            products[_idProduct].productState = State.Received;
        }else{//consumer
            products[_idProduct].productState = State.Purchased;
        }
    }

    //solo el owner puede llamar esta funcion
    function transferOwwnership(uint _idProduct, address _newOwner) isProductOwner(_idProduct) ownerExists(_newOwner) public {
        products[_idProduct].pastOwnersId.push(msg.sender);
        products[_idProduct].currentOwner = _newOwner;

        //agarro el rol del nuevo owner
        uint role = owners_ref.getOwnerRole(_newOwner);

        //cambio el estado del producto segun el nuevo dueño
        changeState(_idProduct, role);
    }


    //--------------------------------------------------
    //Modifiers
    //--------------------------------------------------
    
    modifier ownerExists(address _owner){
        require(owners_ref.ownerExists(_owner), "El owner no existe");
        _;
       
    }

    modifier isProductLineOwner(uint _UCP) {
        require(productLines[_UCP].owner == msg.sender, "necesitar ser owner del product line para hacer eso");
        _;
    }

    modifier isProductOwner(uint _idProduct){
        require(products[_idProduct].currentOwner == msg.sender, "necesitar ser owner del producto para hacer eso");
        _;
    }

}
