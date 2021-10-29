// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract ZeroInterestLoan {

  address public owner;

  struct LoanContract{
    address payable loanee;
    address payable loaner;
    address judge;
    uint loanValue;
  }

  mapping (uint => LoanContract) loanContracts;
  uint contractId;

  modifier judge(uint id) { 
    require(loanContracts[id].judge == msg.sender); 
    _;
  }

  modifier loaner(uint id){
    require(loanContracts[id].loaner == msg.sender); 
    _;
  }

  modifier loanee(uint id){
    require(loanContracts[id].loanee == msg.sender); 
    _;
  }

  modifier loanerOrJudge(uint id){
    require(loanContracts[id].loaner == msg.sender || loanContracts[id].judge == msg.sender); 
    _;
  }

  modifier loaneeOrJudge(uint id){
    require(loanContracts[id].loanee == msg.sender || loanContracts[id].judge == msg.sender); 
    _;
  }

  modifier hasValue(uint id){
    require(loanContracts[id].loanValue > 0);
    _;
  }

  constructor()  {
    owner = msg.sender;
  }

  function createZeroInterestLoan(address payable _loaner, address _judge) payable public returns(uint){
    // the creater is the loanee, he/she will select  the loaner and the judge while sending the Ethers that will be
    // held in the contract till the loaner or the judge release it
  }

  function releaseLoan(uint id, uint amount) public loanerOrJudge(id) hasValue(id){
    // the judge or loaner can release part the held Ethers
    // Loaner does that when he gets payment in real world by the loanee
    // Judge can do so in conflictions
  }

  function releaseAllLoan(uint id) public loanerOrJudge(id) hasValue(id){
    // the judge or loaner can release all of the held Ethers 
    // Loaner does that when he gets payment in real world by the loanee
    // Judge can do so in conflictions
  }

  function payLoaner(uint id, uint amount) public loaneeOrJudge(id) hasValue(id){
    // the judge or loanee can pay part the held Ethers
    // Loanee does that when he pays the real loan to the loaner
    // Judge can do so in conflictions
  }

  function payLoanerReleaseResidual(uint id, uint amount) public judge(id) hasValue(id){
    // the judge can pay part the held Ethers to the loaner and release the rest of the held Ethers to the loanee
    // Judge can do so in conflictions
  }

  function payLoanerAll(uint id) public loaneeOrJudge(id) hasValue(id){
    // the judge or loanee can pay all of the held Ethers
    // Loanee does that when he pays the real loan to the loaner
    // Judge can do so in conflictions
  }

  function showLoanContract(uint id) view public returns(LoanContract memory){
    return loanContracts[id];
  }
}
