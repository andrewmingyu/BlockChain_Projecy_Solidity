// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract MingyuToken is ERC20{
    address public Owner;
    uint _initialSupply;
    modifier OwnerCheck{
        require(msg.sender == Owner,"Invalid access");
        _;
    }
    constructor(uint256 initialSupply) ERC20("MingyuToken", "MTK"){
        Owner=msg.sender;
        _initialSupply=initialSupply;
    }

    function mint()public OwnerCheck{                 //발행자만 접근 가능.
        _mint(msg.sender, _initialSupply*10**uint(decimals()));
    }

    function InflationCheck()public  OwnerCheck returns(string memory){     //인플레이션 체크
        require(msg.sender == Owner,"Invalid access");
        uint _totalAmount=totalSupply();
        int amount=int(_totalAmount-_initialSupply);
        if (amount>0) {
            _burn(Owner,uint(amount));
            return "Bigger";
        }
        if(amount<0){
            amount=-amount;
            _mint(Owner, uint(amount));
            return "Smaller";
        }
        return "Same";
    }

}
