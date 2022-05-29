//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface OwnersInterface {
    function ownerExists(address _owner) external view returns (bool);

    function getOwnerRole(address _owner) external view returns (uint256);
}

contract Owners {
    enum OwnerRole {
        Manufacter, // 0
        Distributor, // 1
        Retail, // 2
        Consumer // 3
    }

    OwnerRole constant defaultState = OwnerRole.Manufacter;

    struct Owner {
        string name;
        string description;
        OwnerRole role;
        bool exist; //para revisar si existe, porque el mappping siempre arroja 0 y no null
    }

    mapping(address => Owner) owners;

    function addOwner(
        string memory _name,
        string memory _description,
        OwnerRole _role
    ) public {
        owners[msg.sender] = Owner(_name, _description, _role, true);
    }

    function getOwner(address _ownerAddr)
        public
        view
        returns (
            string memory,
            string memory,
            OwnerRole
        )
    {
        return (
            owners[_ownerAddr].name,
            owners[_ownerAddr].description,
            owners[_ownerAddr].role
        );
    }

    event getOwnerEvent(string _name, string _descritpion, OwnerRole role);

    function emitOwner(address _ownerAddr) public {
        emit getOwnerEvent(
            owners[_ownerAddr].name,
            owners[_ownerAddr].description,
            owners[_ownerAddr].role
        );
    }

    function ownerExists(address _owner) external view returns (bool) {
        if (owners[_owner].exist == true) {
            return true;
        }
        return false;
    }

    function getOwnerRole(address _owner) external view returns (uint256) {
        OwnerRole role = owners[_owner].role;
        if (role == OwnerRole.Manufacter) {
            return 0;
        } else if (role == OwnerRole.Distributor) {
            return 1;
        } else if (role == OwnerRole.Retail) {
            return 2;
        }
        return 3;
    }
}
