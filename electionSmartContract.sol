
// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
contract Vote {
    struct Candidate{
        string name;
        uint votenum;
    }
    event voteNowAddress(address _address);
    mapping (address => bool) public voters;
    uint _candidateNum;
    Candidate[] candidate;
   constructor(string[] memory names) {
    for (uint i = 0; i < names.length; i++) {
        candidate.push(Candidate({name: names[i],votenum: 0}));
        }
    }
    function elect(uint num) public{
        require(!voters[msg.sender],"You have already voted!");
        candidate[num].votenum+=1; //투표 <-이전에 중복 투표인지 검출해야 됨
        voters[msg.sender]=true;
        emit voteNowAddress(msg.sender);
    }
    function currentElect()public view returns(Candidate [] memory ) {
        return candidate;
    }
}
