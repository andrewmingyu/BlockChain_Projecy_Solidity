// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFT is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds; 
    mapping (address=> uint) mintingCount;
    mapping (uint=>string)tokenURIs;
    constructor() ERC721("BroskiNFT", "BNFT") Ownable(msg.sender) {}

    uint constant MintSupply=1000;
    
    function mint(string memory tokenURI) public payable onlyOwner  {
        require(mintingCount[msg.sender]==0,"You already Minted!");
        require(_tokenIds.current()<MintSupply,"Inflation" );
        _safeMint(msg.sender, _tokenIds.current());
        _tokenIds.increment();
        mintingCount[msg.sender]++;
        tokenURIs[_tokenIds.current()]=tokenURI;
    }
    string private baseTokenURI;

    function _baseURI() internal view override returns (string memory) {
        return baseTokenURI;
    }

    function setBaseURI(string memory _baseTokenURI) public onlyOwner {
        baseTokenURI = _baseTokenURI;
    }

    function Withdraw()public payable onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }
    function AirDrop(address _address)public  onlyOwner{
        _safeMint(_address, _tokenIds.current());
    }
}
