// const receipt = await contractInstance.someFunction()

// const contract = new web3.eth.Contract(contractInstance.abi, contractInstance.address)

// //Now get evens depending on what you need
// contract.getPastEvents("allEvents", {fromBlock: 0, toBlock: "latest"})
// .then(console.log)  

// The includeds tests do the followings:
// 1. Check if we have owner
// 2. Allow owner to add a judge
// 3. Prevent non-owner from adding a judge
// 4. Allow users to create a disputeable contract
// 5. Allow second party to sign the disputeable contract
// 6. Prevent others from signing a disputeable contract
// 7. Allow first party to withdraw the guarantee when the contract is not signed yet
// 8. Prevent first party from withdrawing the guarantee when the contract is signed
// 9. Prevent others from withdrawing the guarantee when the contract is not signed

const DisputeableContract = artifacts.require("DisputeableContract");
let BN = web3.utils.BN;
const truffleAssert = require('truffle-assertions');

contract("DisputeableContract", function (accounts) {
  const [_owner, alice, bob, judge1, judge2, judge3, judge4, badUser] = accounts;
  const emptyAddress = "0x0000000000000000000000000000000000000000";

  const price = "1000";
  const excessAmount = "2000";
  const name = "book";

  let instance;

  beforeEach(async () => {
    instance = await DisputeableContract.new();
  });

  it("should has owner", async function(){
    const o = await instance.showOwner.call();
    assert.equal(o, _owner, "the contract has no owner");
  });

  it("should be able to add a judge by owner", async function(){
    const _id = await instance.addJudge(alice, {from: _owner});
    const judgesCount = await instance.showJudgeId.call(); 
    console.log(_id);
    assert.equal(judgesCount, 1, "judge not added");
  });

  it("should not allow others to add a judge", async function(){
  
    try{
      await instance.addJudge(alice, {from: badUser});
    } catch {

    }
    const judgesCount = await instance.showJudgeId.call();    
    assert.equal(judgesCount, 0, "others can add judges");
  });

  it("it should create a new disputeable contract", async function(){
    // adding at least three judges first
    await instance.addJudge(judge1, {from: _owner});
    await instance.addJudge(judge2, {from: _owner});
    await instance.addJudge(judge3, {from: _owner});
    await instance.addJudge(judge4, {from: _owner});

    await instance.createDisputableContract(bob, 'asdasdsadasdasdsadasds', {from: alice, value: excessAmount});

    const _disputeableContract = await instance.showDisputeableContract.call(0);
    assert.equal(_disputeableContract[0], alice, 'First Party not set correctly');
    assert.equal(_disputeableContract[1], bob, 'Second Party not set correctly');
    assert.notEqual(_disputeableContract[2], emptyAddress, 'Judge1 not set correctly');
    assert.notEqual(_disputeableContract[3], emptyAddress, 'Judge2 not set correctly');
    assert.notEqual(_disputeableContract[4], emptyAddress, 'Judge3 not set correctly');
    assert.equal(_disputeableContract[5], 'asdasdsadasdasdsadasds', 'Image IPFS string not set correctly');
    assert.equal(_disputeableContract[10], excessAmount, 'Guarantee amount not set correctly');
  });

  it("it should allow signing contract by second party", async function(){
    // adding at least three judges first
    await instance.addJudge(judge1, {from: _owner});
    await instance.addJudge(judge2, {from: _owner});
    await instance.addJudge(judge3, {from: _owner});
    await instance.addJudge(judge4, {from: _owner});

    await instance.createDisputableContract(bob, 'asdasdsadasdasdsadasds',
     {from: alice, value: excessAmount});

    await instance.signContract(0, {from: bob});
    const _disputeableContract = await instance.showDisputeableContract.call(0);
    assert.equal(_disputeableContract[6], true, 'Could not sign the contract');
  });

  it("it should not allow signing contract by others", async function(){
    // adding at least three judges first
    await instance.addJudge(judge1, {from: _owner});
    await instance.addJudge(judge2, {from: _owner});
    await instance.addJudge(judge3, {from: _owner});
    await instance.addJudge(judge4, {from: _owner});

    await instance.createDisputableContract(bob, 'asdasdsadasdasdsadasds',
     {from: alice, value: excessAmount});
    try{
    await instance.signContract(0, {from: badUser});
    } catch{

    }
    const _disputeableContract = await instance.showDisputeableContract.call(0);
    assert.equal(_disputeableContract[6], false, 'the contract signed by others');
  });

  it("it should let first party get their guarantee if the contract is not signed by the second party", async function(){
    // adding at least three judges first
    await instance.addJudge(judge1, {from: _owner});
    await instance.addJudge(judge2, {from: _owner});
    await instance.addJudge(judge3, {from: _owner});
    await instance.addJudge(judge4, {from: _owner});

    await instance.createDisputableContract(bob, 'asdasdsadasdasdsadasds',
     {from: alice, value: excessAmount});
    await instance.getGuaranteeBack(0, {from: alice});

    const _disputeableContract = await instance.showDisputeableContract.call(0);
    assert.equal(_disputeableContract[10], 0, 'the guarantee not returned');
  });

  it("it should not let first party get their guarantee if the contract is signed by the second party", async function(){
    // adding at least three judges first
    await instance.addJudge(judge1, {from: _owner});
    await instance.addJudge(judge2, {from: _owner});
    await instance.addJudge(judge3, {from: _owner});
    await instance.addJudge(judge4, {from: _owner});

    await instance.createDisputableContract(bob, 'asdasdsadasdasdsadasds',
     {from: alice, value: excessAmount});
    await instance.signContract(0, {from: bob});
    try{
      await instance.getGuaranteeBack(0, {from: alice});
    } catch {

    }
    const _disputeableContract = await instance.showDisputeableContract(0);
    assert.notEqual(_disputeableContract[10], 0, 'the guarantee returned');
  });

  it("it should not let others get the guarantee", async function(){
    // adding at least three judges first
    await instance.addJudge(judge1, {from: _owner});
    await instance.addJudge(judge2, {from: _owner});
    await instance.addJudge(judge3, {from: _owner});
    await instance.addJudge(judge4, {from: _owner});

    await instance.createDisputableContract(bob, 'asdasdsadasdasdsadasds',
     {from: alice, value: excessAmount});
    await instance.signContract(0, {from: bob});
    try{
      await instance.getGuaranteeBack(0, {from: badUser});
    } catch {

    }
    const _disputeableContract = await instance.showDisputeableContract.call(0);
    assert.notEqual(_disputeableContract[10], 0, 'the guarantee returned');
  });

});
