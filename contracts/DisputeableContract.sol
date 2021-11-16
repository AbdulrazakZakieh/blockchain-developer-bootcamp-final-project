// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

contract Owned { 
  constructor() {
    owner = msg.sender;
  }
  /// @notice the address of the owner of the contract
  address public owner ;
}

/// @title Disputeable Contract
/// @author Abdul razak Zakieh 
/// @custom:experimental This is an experimental contract
contract DisputeableContract is Owned{

  bool isStopped = false;

  struct DisputeableContractStruct{
    uint256 id;
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
    uint256 guaranteeValue;
    uint256 judgesEarnings;
  }

  mapping(uint256 => address) judges;

  mapping (uint256 => DisputeableContractStruct) disputeableContracts;

  uint256 disputeableContractId;
  uint256 judgeId;
  uint256 judgesCount;

  modifier isOwner() { 
    require(owner == msg.sender); 
    _;
  }

  modifier signed(uint256 id) {
    require(disputeableContracts[id].signedBySecondParty == true);
    _;
  }

  modifier notSigned(uint256 id) {
    require(disputeableContracts[id].signedBySecondParty == false);
    _;
  }

  modifier judge(uint256 _id) { 
    require((disputeableContracts[_id].judge1 == msg.sender) ||
     (disputeableContracts[_id].judge2 == msg.sender) || (disputeableContracts[_id].judge3 == msg.sender)); 
    _;
  }

  modifier firstParty(uint256 _id){
    require(disputeableContracts[_id].first_party == msg.sender); 
    _;
  }

  modifier secondParty(uint256 _id){
    require(disputeableContracts[_id].second_party == msg.sender); 
    _;
  }

  // modifier firstPartyOrJudge(uint256 _id){
  //   require((disputeableContracts[_id].first_party == msg.sender) || (disputeableContracts[_id].judge1 == msg.sender) ||
  //    (disputeableContracts[_id].judge2 == msg.sender) || (disputeableContracts[_id].judge3 == msg.sender)); 
  //   _;
  // }

  // modifier secondPartyOrJudge(uint256 _id){
  //   require((disputeableContracts[_id].second_party == msg.sender) || (disputeableContracts[_id].judge1 == msg.sender) ||
  //    (disputeableContracts[_id].judge2 == msg.sender) || (disputeableContracts[_id].judge3 == msg.sender)); 
  //   _;
  // }

  modifier hasValue(uint256 _id){
    require(disputeableContracts[_id].guaranteeValue > 0);
    _;
  }

  modifier hasThreeJudges(){
    require(judgesCount >= 3);
    _;
  }

  modifier disputeable(uint256 id){
    require(disputeableContracts[id].disputeRequestByParty1 == true || disputeableContracts[id].disputeRequestByParty2 == true);
    _;
  }

  modifier notStopped { 
    require(!isStopped, 'Contract is stopped'); _;
  }


  // Logs
  /// <LogDisputableContractCreated event: _id arg>
  event LogDisputableContractCreated(uint256 _id, address secondParty, uint256 value, address judge1, address judge2, address judge3);
  // <LogDisputableContractSignedBySecondParty event: _id arg>
  event LogDisputableContractSignedBySecondParty(uint256 _id);
  // <LogGuaranteeValueReleasedToFirstPart event: _id arg>
  event LogGuaranteeValueReleasedToFirstPart(uint256 _id);
  // <LogGuaranteeValueReleasedToSecondPart event: _id arg>
  event LogGuaranteeValuePaidToSecondPart(uint256 _id);
  // <LogFirstPartyFilledDisputeResolution event: _id arg>
  event LogFirstPartyFilledDisputeResolution(uint256 _id);
  // <LogSecondPartyFilledDisputeResolution event: _id arg>
  event LogSecondPartyFilledDisputeResolution(uint256 _id);
  // <LogJudgeMadeDecision event: _id arg>
  event LogJudgeMadeDecision(uint256 _id);
  /// <LogFinalDecisionMade event: _id arg>
  event LogFinalDecisionMade(uint256 _id);
  /// <LogGuaranteeGotBack event: _id arg>
  event LogGuaranteeGotBack(uint256 _id);
  /// <LogGuaranteeReleasedBySecondParty event: _id arg>
  event LogGuaranteeReleasedBySecondParty(uint256 _id);
  /// <LogGuaranteeReleasedByJudgesDecision event: _id arg>
  event LogGuaranteeReleasedByJudgesDecision(uint256 _id);
  /// <LogGuaranteePaidByFirstParty event: _id arg>
  event LogGuaranteePaidByFirstParty(uint256 _id);
  /// <LogGuaranteePaidByJudgesDecision event: _id arg>
  event LogGuaranteePaidByJudgesDecision(uint256 _id);
  /// <LogJudgeAdded event: _address arg>
  event LogJudgeAdded(address _address);
  /// <LogJudgeDeleted event: _id arg>
  event LogJudgeDeleted(uint256 _id);

  constructor(){
  }

  function stopContract()  public isOwner{
    isStopped = true;
  }

  function resumeContract() public isOwner{
    isStopped = false;
  }

  /// @notice Give a psuedo random number
  /// @param _address An address to avoid repeation in pseudo numbers as possible
  /// @return A pseudo random number between 0 and the count of judges, based on the block timestamp, the disputeableContractId, and the passed address
  function random(address _address) private view returns (uint256) {
    return uint256(keccak256(abi.encodePacked(block.timestamp + disputeableContractId, _address))) % judgesCount;
  }
  /// @notice Adding a judge to the pool of judges by the owner only
  /// @param _judgeAddress The judge address
  /// @return The judge's id in the pool
  function addJudge(address _judgeAddress) public isOwner() returns(uint256){
    judges[judgeId] = _judgeAddress;
    judgesCount = judgesCount + 1;
    emit LogJudgeAdded(_judgeAddress);
    return judgeId++;
  }
  /// @notice Removing a judge from the pool of judges by the owner only
  /// @param _judgeId The judge id that we want to remove
  function removeJudge(uint256 _judgeId) isOwner() public{
    require(judges[_judgeId] != address(0));
    delete judges[_judgeId];
    emit LogJudgeDeleted(_judgeId);
    judgesCount--;
  }
  /// @notice Creating a disputeable contract and add it to the disputeable contract mapping. 
  /// @notice The judges will be selected randomly. However, no checkings are made to insure no repeatition
  /// @notice The smart contract has to have at least three judges to allow creating disputeable contracts
  /// @param _secondParty The Second Party Address
  /// @param realContractIPFS The hash of the real contract image in IPFS
  /// @return The created disputeable contract's id
  function createDisputableContract(address  _secondParty, string memory realContractIPFS) public payable notStopped() hasThreeJudges()  returns(uint256){
    address judge1 = judges[random(_secondParty)];
    address judge2 = judges[random(judge1)];
    address judge3 = judges[random(judge2)];
    
    uint256 judgesEarnings = msg.value / 100; // change to shifting instead of division
    
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
    emit LogDisputableContractCreated(disputeableContractId, _secondParty, msg.value, judge1, judge2, judge3);
    return disputeableContractId++;
  }
  /// @notice Sign the contract by second party to make it valid
  /// @param id The contract id to be signed
  /// @return True after signing
  function signContract(uint256 id) public hasValue(id) returns(bool) {
    require(disputeableContracts[id].second_party == msg.sender);    
    disputeableContracts[id].signedBySecondParty = true;
    emit LogDisputableContractSignedBySecondParty(id);
    return true;
  }
  /// @notice File a dispute by either the first part or second party.
  /// @param id The contract id to file a dispute for
  /// @return True after filling the dispute
  function fileDispute(uint256 id) public hasValue(id) returns(bool){
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
  
  /// @notice File a dispute by the first part.
  /// @param id The contract id to file a dispute for
  /// @return True after filling the dispute
  function fileDisputeByFirstParty(uint256 id) public hasValue(id) returns(bool){
    require(disputeableContracts[id].first_party == msg.sender);
    disputeableContracts[id].disputeRequestByParty1 = true;
    emit LogFirstPartyFilledDisputeResolution(id);
    return true;
  }

  /// @notice File a dispute by either the second party.
  /// @param id The contract id to file a dispute for
  /// @return True after filling the dispute
  function fileDisputeBySecondParty(uint256 id) public hasValue(id) returns(bool){
    require(disputeableContracts[id].second_party == msg.sender);
    disputeableContracts[id].disputeRequestByParty2 = true;
    emit LogSecondPartyFilledDisputeResolution(id);
    return true;
  }

  /// @notice Get the held Ether Guarantee by the first party in case the second party did not sign the contract
  /// @param id The contract id to get back its gurantee
  /// @return True after get back the guarantee
  function getGuaranteeBack(uint256 id) public notSigned(id) hasValue(id) returns(bool){
    uint256 value = disputeableContracts[id].guaranteeValue;
    disputeableContracts[id].guaranteeValue = 0;
    payable(msg.sender).transfer(value);
    emit LogGuaranteeGotBack(id);
    return true;
  }

  /// @notice Release the guarantee by the second party to the first party.
  /// @notice The contract should be signed and has a value
  /// @param id The contract id to release its guarantee 
  /// @return True after releasing the guarantee
  function releaseGuaranteeToFirstParty(uint256 id) public signed(id) hasValue(id) secondParty(id) returns(bool){
    uint256 value = disputeableContracts[id].guaranteeValue;
    disputeableContracts[id].guaranteeValue = 0;
    payable(disputeableContracts[id].first_party).transfer(value);
    emit LogGuaranteeReleasedBySecondParty(id);
    return true;
  }
  /// @notice Pay the guarantee to the second party by the first party
  /// @param id The contract id to pay its guarantee
  /// @return True after paying the guarantee
  function paySecondParty(uint256 id) public signed(id) hasValue(id) firstParty(id) returns(bool){
    uint256 value = disputeableContracts[id].guaranteeValue;
    disputeableContracts[id].guaranteeValue = 0;
    payable(disputeableContracts[id].second_party).transfer(value);
    emit LogGuaranteePaidByFirstParty(id);
    return true;
  }

  /// @notice Vote by one of the judges to make a decision for a disputed contract
  /// @notice One of the parties should have filled a dispute to be able to vote by the judges
  /// @notice Only one of the assigned judges can vote and for one time only. The judge will be paid after making his/her decision.
  /// @notice Once reaching three votes, the held guarantee will be released or paid according to the majority of the votes.
  /// @param id The contract id to get back its gurantee
  /// @param releaseDecision The judge's decision whether to release the held guarantee or not
  /// @return True after filling the dispute
  function vote(uint256 id, bool releaseDecision) hasValue(id) signed(id) disputeable(id) judge(id) public returns(bool)
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
        if(disputeableContracts[id].guaranteeValue != 0) // to delete
        {
          if((disputeableContracts[id].realeseDecisionByJudge1 && disputeableContracts[id].realeseDecisionByJudge2) ||
            (disputeableContracts[id].realeseDecisionByJudge1 && disputeableContracts[id].realeseDecisionByJudge3) ||
            (disputeableContracts[id].realeseDecisionByJudge2 && disputeableContracts[id].realeseDecisionByJudge3)) {
              // release money to the first party as decision made by majority of judges
              uint256 value = disputeableContracts[id].guaranteeValue;
              disputeableContracts[id].guaranteeValue = 0;
              payable(disputeableContracts[id].first_party).transfer(value);
              emit LogFinalDecisionMade(id);
              emit LogGuaranteeReleasedByJudgesDecision(id);
              return true;
            } 
            else {
              // pay money to the second party as decision made by majority of judges
              uint256 value = disputeableContracts[id].guaranteeValue;
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
              uint256 value = disputeableContracts[id].guaranteeValue;
              disputeableContracts[id].guaranteeValue = 0;
              payable(disputeableContracts[id].first_party).transfer(value);
              emit LogFinalDecisionMade(id);
              emit LogGuaranteeReleasedByJudgesDecision(id);
              return true;
            } 
            else {
              // pay money to the second party as decision made by majority of judges
              uint256 value = disputeableContracts[id].guaranteeValue;
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
              uint256 value = disputeableContracts[id].guaranteeValue;
              disputeableContracts[id].guaranteeValue = 0;
              payable(disputeableContracts[id].first_party).transfer(value);
              emit LogFinalDecisionMade(id);
              emit LogGuaranteeReleasedByJudgesDecision(id);
              return true;
            } 
            else {
              // pay money to the second party as decision made by majority of judges
              uint256 value = disputeableContracts[id].guaranteeValue;
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
  /// @notice Function to view the details of a disputeable contract
  /// @param id The contract id to see its details
  /// @return first_party The first party address
  /// @return second_party The first party address
  /// @return judge1 The first party address
  /// @return judge2 The first party address
  /// @return judge3 The first party address
  /// @return realContractIPFS The hash of the real contract image uploaded to IPFS
  /// @return signedBySecondParty Whether the disputeable contract got signed by the second party
  /// @return realeseDecisionByJudge1 The decision by judge 1, only valid if the judge made a decision
  /// @return realeseDecisionByJudge2 The decision by judge 2, only valid if the judge made a decision
  /// @return realeseDecisionByJudge3 The decision by judge 3, only valid if the judge made a decision
  /// @return guaranteeValue The guarantee value

  function showDisputeableContract(uint256 id) view public returns(
      address first_party, address second_party,
      address judge1, address judge2, address judge3,
      string memory realContractIPFS, bool signedBySecondParty,
      bool realeseDecisionByJudge1,
      bool realeseDecisionByJudge2,
      bool realeseDecisionByJudge3,
      uint256 guaranteeValue){
      
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
  
  function showJudge(uint256 _id) view public returns(address){
    return judges[_id];
  }
  
  function showJudgeId() view public returns(uint256){
      return judgeId;
  }

  function showOwner() view public returns(address){
    return owner;
  }
}
