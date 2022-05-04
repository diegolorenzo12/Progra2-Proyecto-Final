pragma solidity ^0.5.0;

interface EmpresaInterface{
    function getAdressEmpresaById(uint _idEmpresa) external view returns(address);
    function validateOwnership(uint _idEmpresa) external view returns (bool);
}

contract Empresas {
    
    uint currentId;

    struct Empresa{
        uint idEmpresa;
        string name;
        string description;
        address addressEmpresa;
    }
    Empresa[] empresas;

    function addEmpresa(string memory _name, string memory _description) public{
        for(uint i=0; i<empresas.length; i++){
            if(keccak256(abi.encodePacked(_name)) == keccak256(abi.encodePacked(empresas[i].name))){
                revert("that name already exists");
            }
        }
        empresas.push ( Empresa(currentId, _name, _description, msg.sender));
        currentId++;
    }

    function getEmpresa(uint _idEmpresa) public view returns (string memory, string memory){
        return (empresas[_idEmpresa].name, empresas[_idEmpresa].description);
    }

    function getAdressEmpresaById(uint _idEmpresa) public view returns (address){
        return empresas[_idEmpresa].addressEmpresa;
    }

    function validateOwnership(uint _idEmpresa) external view returns (bool){
        if(empresas[_idEmpresa].addressEmpresa == msg.sender){
            return true;
        }
        return false;
    }

}