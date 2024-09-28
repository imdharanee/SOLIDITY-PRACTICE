// SPDX-License-Identifier: GPL-3.0


pragma solidity >=0.8.2 <0.9.0;

contract VoteManagement {
    address public VotingOrganizer;
    uint256 public candidateid;
    uint256 public voterid;
     struct Candidate {

         uint256 candidateId;
         uint256 age;
         string name;
         string image;
         uint256 votecount;
         address _address;

     }

     struct Voter {
        uint256 voterid;
        string voter_name;
        string voter_image;
        address voter_address;
        uint256 isallowed;
        bool wasvoted;
        


     }
     
     address[] public cand_address;
     mapping(address=>Candidate) public candidates;

     address[] public voteraddress;
     mapping(address=>Voter) public voters;

     event CreateCandidate(


        uint256  candidateid,
        uint256 age,
        string name,
        string image,
        uint256 votecount,
        address _address

     );
     event CreateVoter(
           uint256 voter_voterid,
        string voter_name,
        string voter_image,
        address voter_address,
        uint256 isallowed,
        bool wasvoted

     );

     constructor() {

        VotingOrganizer=msg.sender;
     }
     function setCandidate(address _address, uint256 _age,string memory _name,string memory _image)public  {
        require(VotingOrganizer==msg.sender,"Only Voting Authorizer can set candidate");
       candidateid++;

       Candidate storage candidate=candidates[_address];
       candidate.age=_age;
       candidate.name=_name;
       candidate.candidateId=candidateid ;
       candidate.image=_image;
       candidate.votecount=0;

       candidate._address=_address;

       cand_address.push(_address);

       emit CreateCandidate(candidateid, _age, _name, _image, candidate.votecount, _address);

     }

    

     function getCandidateData(address _address) public view returns (uint256, string memory, uint256, string memory, uint256, address) {
    
    

    
    return (
        candidates[_address].age,
        candidates[_address].name,  
        candidates[_address].candidateId,
        candidates[_address].image,  
        candidates[_address].votecount,
        candidates[_address]._address
    );
}
     function RighttoVote(address _address, string memory _name, string memory _image) public {
        require(VotingOrganizer==msg.sender,"Only Authorizer have to set the voterright");


     
     voterid++;
     Voter storage voter=voters[_address];
     require(voter.isallowed==0);
     voter.isallowed=1;
     voter.voter_name=_name;
     voter.voter_image=_image;
     voter.voter_address=_address;
     voter.voterid=voterid;
     voter.wasvoted=false;
     voteraddress.push(voter.voter_address);

     emit CreateVoter(voterid,_name,_image,_address,voter.isallowed,voter.wasvoted);
     }
     address[] votedVoters;
     
     function Vote(address _candidateaddress,uint256 _candidatevoteid) external {

        
        Voter storage voter=voters[msg.sender];

        require(!voter.wasvoted,"You have already voted");
        require(voter.isallowed!=0,"You have no right to vote");

        voter.wasvoted=true;
        voter.voterid=_candidatevoteid;
        votedVoters.push(msg.sender);
        candidates[_candidateaddress].votecount+=voter.isallowed;



     }
}