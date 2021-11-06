// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract DisputeableContract {

  address public owner;

  struct DisputeableContractStruct{
    uint id;
    address payable first_party;
    address payable second_party;
    address  judge1;
    address  judge2;
    address  judge3;
    string realContractIPFS;
    bool signedBySecondParty;
    bool disputeRequestByParty1;
    bool disputeRequestByParty2;
    bool realeseDecisionByJudge1;
    bool realeseDecisionByJudge2;
    bool realeseDecisionByJudge3;
    bool judge1Decided;
    bool judge2Decided;
    bool judge3Decided;
    uint guaranteeValue;
    uint judgesEarnings;
  }

  mapping(uint => address) judges;

  mapping (uint => DisputeableContractStruct) disputeableContracts;

  uint disputeableContractId;
  uint judgeId;
  uint judgesCount;

  modifier isOwner() { 
    require(owner == msg.sender); 
    _;
  }

  modifier signed(uint id) {
    require(disputeableContracts[id].signedBySecondParty == true);
    _;
  }

  modifier notSigned(uint id) {
    require(disputeableContracts[id].signedBySecondParty == false);
    _;
  }

  modifier judge(uint _id) { 
    require((disputeableContracts[_id].judge1 == msg.sender) ||
     (disputeableContracts[_id].judge2 == msg.sender) || (disputeableContracts[_id].judge3 == msg.sender)); 
    _;
  }

  modifier firstParty(uint _id){
    require(disputeableContracts[_id].first_party == msg.sender); 
    _;
  }

  modifier secondParty(uint _id){
    require(disputeableContracts[_id].second_party == msg.sender); 
    _;
  }

  modifier firstPartyOrJudge(uint _id){
    require((disputeableContracts[_id].first_party == msg.sender) || (disputeableContracts[_id].judge1 == msg.sender) ||
     (disputeableContracts[_id].judge2 == msg.sender) || (disputeableContracts[_id].judge3 == msg.sender)); 
    _;
  }

  modifier secondPartyOrJudge(uint _id){
    require((disputeableContracts[_id].second_party == msg.sender) || (disputeableContracts[_id].judge1 == msg.sender) ||
     (disputeableContracts[_id].judge2 == msg.sender) || (disputeableContracts[_id].judge3 == msg.sender)); 
    _;
  }

  modifier hasValue(uint _id){
    require(disputeableContracts[_id].guaranteeValue > 0);
    _;
  }

  modifier hasThreeJudges(){
    require(judgesCount >= 3);
    _;
  }

  modifier disputeable(uint id){
    require(disputeableContracts[id].disputeRequestByParty1 == true || disputeableContracts[id].disputeRequestByParty2 == true);
    _;
  }

  // Logs
   // <LogDisputableContractCreated event: _id arg>
  event LogDisputableContractCreated(uint _id);
  // <LogDisputableContractSignedBySecondParty event: _id arg>
  event LogDisputableContractSignedBySecondParty(uint _id);
  // <LogGuaranteeValueReleasedToFirstPart event: _id arg>
  event LogGuaranteeValueReleasedToFirstPart(uint _id);
  // <LogGuaranteeValueReleasedToSecondPart event: _id arg>
  event LogGuaranteeValuePaidToSecondPart(uint _id);
  // <LogFirstPartyFilledDisputeResolution event: _id arg>
  event LogFirstPartyFilledDisputeResolution(uint _id);
  // <LogSecondPartyFilledDisputeResolution event: _id arg>
  event LogSecondPartyFilledDisputeResolution(uint _id);
  // <LogJudgeMadeDecision event: _id arg>
  event LogJudgeMadeDecision(uint _id);
  // LogFinalDecisionMade
  event LogFinalDecisionMade(uint _id);
  event LogGuaranteeGotBack(uint _id);
  event LogGuaranteeReleasedBySecondParty(uint _id);
  event LogGuaranteeReleasedByJudgesDecision(uint _id);
  event LogGuaranteePaidByFirstParty(uint _id);
  event LogGuaranteePaidByJudgesDecision(uint _id);

  constructor(){
    owner = msg.sender;
  }
  function random(address _address) private view returns (uint) {
    return uint(keccak256(abi.encodePacked(block.timestamp + disputeableContractId, _address))) % judgesCount;
  }
  function addJudge(address _judgeAddress) public isOwner() returns(uint){
    judges[judgeId] = _judgeAddress;
    judgesCount = judgesCount + 1;
    return judgeId++;
  }
  function removeJudge(uint _judgeId) isOwner() public{
    require(judges[_judgeId] != address(0));
    delete judges[_judgeId];
    judgesCount--;
  }
  function createDisputableContract(address  _secondParty, string memory realContractIPFS) public payable hasThreeJudges returns(uint){
    address judge1 = judges[random(_secondParty)];
    address judge2 = judges[random(judge1)];
    address judge3 = judges[random(judge2)];
    uint judgesEarnings = msg.value / 100;
    disputeableContracts[disputeableContractId] = DisputeableContractStruct({
      id: disputeableContractId,
      first_party: payable(msg.sender),
      second_party: payable(_secondParty),
      judge1: judge1,
      judge2: judge2,
      judge3: judge3,
      realContractIPFS: realContractIPFS,
      signedBySecondParty: false,
      disputeRequestByParty1: false,
      disputeRequestByParty2: false,
      realeseDecisionByJudge1: false,
      realeseDecisionByJudge2: false,
      realeseDecisionByJudge3: false,
      judge1Decided: false,
      judge2Decided: false,
      judge3Decided: false,
      guaranteeValue: msg.value,
      judgesEarnings: judgesEarnings
    });
    emit LogDisputableContractCreated(disputeableContractId);
    return disputeableContractId++;
  }
  function signContract(uint id) public hasValue(id) returns(bool) {
    require(disputeableContracts[id].second_party == msg.sender);    
    disputeableContracts[id].signedBySecondParty = true;
    emit LogDisputableContractSignedBySecondParty(id);
    return true;
  }
  function fileDispute(uint id) public hasValue(id) returns(bool){
    require(disputeableContracts[id].first_party == msg.sender || disputeableContracts[id].second_party == msg.sender);
    if(disputeableContracts[id].first_party == msg.sender){
      disputeableContracts[id].disputeRequestByParty1 = true;
      emit LogFirstPartyFilledDisputeResolution(id);
    }
    else{
      disputeableContracts[id].disputeRequestByParty2 = true;
      emit LogSecondPartyFilledDisputeResolution(id);
    }
    return true;
  }
  
  function fileDisputeByFirstParty(uint id) public hasValue(id) returns(bool){
    require(disputeableContracts[id].first_party == msg.sender);
    disputeableContracts[id].disputeRequestByParty1 = true;
    emit LogFirstPartyFilledDisputeResolution(id);
    return true;
  }
  function fileDisputeBySecondParty(uint id) public hasValue(id) returns(bool){
    require(disputeableContracts[id].second_party == msg.sender);
    disputeableContracts[id].disputeRequestByParty2 = true;
    emit LogSecondPartyFilledDisputeResolution(id);
    return true;
  }
  function getGuaranteeBack(uint id) public notSigned(id) hasValue(id) returns(bool){
    uint value = disputeableContracts[id].guaranteeValue;
    disputeableContracts[id].guaranteeValue = 0;
    payable(msg.sender).transfer(value);
    emit LogGuaranteeGotBack(id);
    return true;
  }
  function releaseGuaranteeToFirstParty(uint id) public signed(id) hasValue(id) secondParty(id) returns(bool){
    uint value = disputeableContracts[id].guaranteeValue;
    disputeableContracts[id].guaranteeValue = 0;
    payable(disputeableContracts[id].first_party).transfer(value);
    emit LogGuaranteeReleasedBySecondParty(id);
    return true;
  }
  function paySecondParty(uint id) public signed(id) hasValue(id) firstParty(id) returns(bool){
    uint value = disputeableContracts[id].guaranteeValue;
    disputeableContracts[id].guaranteeValue = 0;
    payable(disputeableContracts[id].second_party).transfer(value);
    emit LogGuaranteePaidByFirstParty(id);
    return true;
  }
  function vote(uint id, bool releaseDecision) hasValue(id) signed(id) disputeable(id) judge(id) public returns(bool)
  {
    if(disputeableContracts[id].judge1 == msg.sender && disputeableContracts[id].judge1Decided == false)
    {
      disputeableContracts[id].judge1Decided = true;
      disputeableContracts[id].realeseDecisionByJudge1 = releaseDecision;
      disputeableContracts[id].guaranteeValue -= disputeableContracts[id].judgesEarnings;
      payable(disputeableContracts[id].judge1).transfer(disputeableContracts[id].judgesEarnings);
      emit LogJudgeMadeDecision(id);  
      if(disputeableContracts[id].judge2Decided && disputeableContracts[id].judge3Decided)
      {
        if(disputeableContracts[id].guaranteeValue != 0)
        {
          if((disputeableContracts[id].realeseDecisionByJudge1 && disputeableContracts[id].realeseDecisionByJudge2) ||
            (disputeableContracts[id].realeseDecisionByJudge1 && disputeableContracts[id].realeseDecisionByJudge3) ||
            (disputeableContracts[id].realeseDecisionByJudge2 && disputeableContracts[id].realeseDecisionByJudge3)) {
              // release money to the first party as decision made by majority of judges
              uint value = disputeableContracts[id].guaranteeValue;
              disputeableContracts[id].guaranteeValue = 0;
              payable(disputeableContracts[id].first_party).transfer(value);
              emit LogFinalDecisionMade(id);
              emit LogGuaranteeReleasedByJudgesDecision(id);
              return true;
            } 
            else {
              // pay money to the second party as decision made by majority of judges
              uint value = disputeableContracts[id].guaranteeValue;
              disputeableContracts[id].guaranteeValue = 0;
              payable(disputeableContracts[id].second_party).transfer(value);
              emit LogFinalDecisionMade(id);
              emit  LogGuaranteePaidByJudgesDecision(id);
              return true;
            }
        }
      }
    }
    else if(disputeableContracts[id].judge2 == msg.sender && disputeableContracts[id].judge2Decided == false)
    {
      disputeableContracts[id].judge2Decided = true;
      disputeableContracts[id].realeseDecisionByJudge2 = releaseDecision;
      disputeableContracts[id].guaranteeValue -= disputeableContracts[id].judgesEarnings;
      payable(disputeableContracts[id].judge2).transfer(disputeableContracts[id].judgesEarnings);
      emit LogJudgeMadeDecision(id);
      if(disputeableContracts[id].judge1Decided && disputeableContracts[id].judge3Decided)
      {
        if(disputeableContracts[id].guaranteeValue != 0)
        {
          if((disputeableContracts[id].realeseDecisionByJudge1 && disputeableContracts[id].realeseDecisionByJudge2) ||
            (disputeableContracts[id].realeseDecisionByJudge1 && disputeableContracts[id].realeseDecisionByJudge3) ||
            (disputeableContracts[id].realeseDecisionByJudge2 && disputeableContracts[id].realeseDecisionByJudge3)) {
              // release money to the first party as decision made by majority of judges
              uint value = disputeableContracts[id].guaranteeValue;
              disputeableContracts[id].guaranteeValue = 0;
              payable(disputeableContracts[id].first_party).transfer(value);
              emit LogFinalDecisionMade(id);
              emit LogGuaranteeReleasedByJudgesDecision(id);
              return true;
            } 
            else {
              // pay money to the second party as decision made by majority of judges
              uint value = disputeableContracts[id].guaranteeValue;
              disputeableContracts[id].guaranteeValue = 0;
              payable(disputeableContracts[id].second_party).transfer(value);
              emit LogFinalDecisionMade(id);
              emit  LogGuaranteePaidByJudgesDecision(id);
              return true;
            }
        }
      }
    } 
    else if(disputeableContracts[id].judge3 == msg.sender && disputeableContracts[id].judge3Decided == false)
    {
      disputeableContracts[id].judge3Decided = true;
      disputeableContracts[id].realeseDecisionByJudge3 = releaseDecision;
      disputeableContracts[id].guaranteeValue -= disputeableContracts[id].judgesEarnings;
      payable(disputeableContracts[id].judge3).transfer(disputeableContracts[id].judgesEarnings);
      emit LogJudgeMadeDecision(id);
      if(disputeableContracts[id].judge1Decided && disputeableContracts[id].judge2Decided)
      {
        if(disputeableContracts[id].guaranteeValue != 0)
        {
          if((disputeableContracts[id].realeseDecisionByJudge1 && disputeableContracts[id].realeseDecisionByJudge2) ||
            (disputeableContracts[id].realeseDecisionByJudge1 && disputeableContracts[id].realeseDecisionByJudge3) ||
            (disputeableContracts[id].realeseDecisionByJudge2 && disputeableContracts[id].realeseDecisionByJudge3)) {
              // release money to the first party as decision made by majority of judges
              uint value = disputeableContracts[id].guaranteeValue;
              disputeableContracts[id].guaranteeValue = 0;
              payable(disputeableContracts[id].first_party).transfer(value);
              emit LogFinalDecisionMade(id);
              emit LogGuaranteeReleasedByJudgesDecision(id);
              return true;
            } 
            else {
              // pay money to the second party as decision made by majority of judges
              uint value = disputeableContracts[id].guaranteeValue;
              disputeableContracts[id].guaranteeValue = 0;
              payable(disputeableContracts[id].second_party).transfer(value);
              emit LogFinalDecisionMade(id);
              emit  LogGuaranteePaidByJudgesDecision(id);
              return true;
            }
        }
      }
    }
    return false;
  }
  function showDisputeableContract(uint id) view public returns(
      address first_party, address second_party,
      address judge1, address judge2, address judge3,
      string memory realContractIPFS, bool signedBySecondParty,
      bool realeseDecisionByJudge1,
      bool realeseDecisionByJudge2,
      bool realeseDecisionByJudge3,
      uint guaranteeValue){
      
      first_party = disputeableContracts[id].first_party;
      second_party = disputeableContracts[id].second_party;
      judge1 = disputeableContracts[id].judge1;
      judge2 = disputeableContracts[id].judge2;
      judge3 = disputeableContracts[id].judge3;
      realContractIPFS = disputeableContracts[id].realContractIPFS;
      signedBySecondParty = disputeableContracts[id].signedBySecondParty;
      
      realeseDecisionByJudge1 = disputeableContracts[id].realeseDecisionByJudge1;
      realeseDecisionByJudge2 = disputeableContracts[id].realeseDecisionByJudge2;
      realeseDecisionByJudge3 = disputeableContracts[id].realeseDecisionByJudge3;

      guaranteeValue = disputeableContracts[id].guaranteeValue;
  }
  function showJudge(uint _id) view public returns(address){
    return judges[_id];
  }
  function showJudgeId() view public returns(uint){
      return judgeId;
  }
}
