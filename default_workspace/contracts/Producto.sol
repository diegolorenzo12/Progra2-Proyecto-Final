pragma solidity ^0.5.0;

import "./Empresa.sol";

contract Productos {

    Empresas public empresas_ref;

    constructor(Empresas _addrEmpresas) public{
        empresas_ref = _addrEmpresas;
    }


    //--------------------------------------------------
    //linea de productos
    //-------------------------------------------------
    uint currentIdProductLine;
    struct ProductLine{
        uint idProductLine;
        uint idEmpresa;
        string description;
    }
    ProductLine [] productLines;

    function addProductLine(uint _idEmpresa, string memory _description) public{
        require (empresas_ref.validateOwnership(_idEmpresa));
        productLines.push(  ProductLine(currentIdProductLine, _idEmpresa, _description));
        currentIdProductLine++;
    }

    function validateProductLineOwnership(uint _idProductLine) internal view returns (bool){
       return empresas_ref.validateOwnership(  productLines[_idProductLine].idEmpresa );
    }

    function getEmpresaIdByIdProductLine(uint _idProductLine) internal view returns (uint){
        return productLines[_idProductLine].idEmpresa;
    }






    //--------------------------------------------------
    //product solos
    //--------------------------------------------------

    uint currentIdProduct;
    struct Product{
        uint idProduct;
        uint idProductLine;
        //uint idLote;
        //uint CreationDate;
    }
    Product[] products;

    function addProduct(uint _idProductLine) public{
        require (validateProductLineOwnership(_idProductLine), "dont have permition to add a product");
        products.push( Product (currentIdProduct, _idProductLine));
    }

    function getIdEmpresaByProductId(uint _IdProduct) public view returns (uint){
        getEmpresaIdByIdProductLine(products[_IdProduct].idProductLine);
    }

    //function transfer product ownership
}