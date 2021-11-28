'use strict'

// contract address on Ropsten:
const ssAddress = '0x3a54b0bE9E3F05f448f68B44367A15d0d596d636'

// add contract ABI from Remix:

const ssABI =
[
  {
    "inputs": [],
    "stateMutability": "nonpayable",
    "type": "constructor"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_id",
        "type": "uint256"
      },
      {
        "indexed": false,
        "internalType": "address",
        "name": "firstParty",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "address",
        "name": "secondParty",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "value",
        "type": "uint256"
      },
      {
        "indexed": false,
        "internalType": "address",
        "name": "judge1",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "address",
        "name": "judge2",
        "type": "address"
      },
      {
        "indexed": false,
        "internalType": "address",
        "name": "judge3",
        "type": "address"
      }
    ],
    "name": "LogDisputableContractCreated",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_id",
        "type": "uint256"
      }
    ],
    "name": "LogDisputableContractSignedBySecondParty",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_id",
        "type": "uint256"
      }
    ],
    "name": "LogFinalDecisionMade",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_id",
        "type": "uint256"
      }
    ],
    "name": "LogFirstPartyFilledDisputeResolution",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_id",
        "type": "uint256"
      }
    ],
    "name": "LogGuaranteeGotBack",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_id",
        "type": "uint256"
      }
    ],
    "name": "LogGuaranteePaidByFirstParty",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_id",
        "type": "uint256"
      }
    ],
    "name": "LogGuaranteePaidByJudgesDecision",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_id",
        "type": "uint256"
      }
    ],
    "name": "LogGuaranteeReleasedByJudgesDecision",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_id",
        "type": "uint256"
      }
    ],
    "name": "LogGuaranteeReleasedBySecondParty",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_id",
        "type": "uint256"
      }
    ],
    "name": "LogGuaranteeValuePaidToSecondPart",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_id",
        "type": "uint256"
      }
    ],
    "name": "LogGuaranteeValueReleasedToFirstPart",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "address",
        "name": "_address",
        "type": "address"
      }
    ],
    "name": "LogJudgeAdded",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_id",
        "type": "uint256"
      }
    ],
    "name": "LogJudgeDeleted",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_id",
        "type": "uint256"
      }
    ],
    "name": "LogJudgeMadeDecision",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      {
        "indexed": false,
        "internalType": "uint256",
        "name": "_id",
        "type": "uint256"
      }
    ],
    "name": "LogSecondPartyFilledDisputeResolution",
    "type": "event"
  },
  {
    "inputs": [],
    "name": "owner",
    "outputs": [
      {
        "internalType": "address",
        "name": "",
        "type": "address"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [],
    "name": "stopContract",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "resumeContract",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "_judgeAddress",
        "type": "address"
      }
    ],
    "name": "addJudge",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_judgeId",
        "type": "uint256"
      }
    ],
    "name": "removeJudge",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "_secondParty",
        "type": "address"
      },
      {
        "internalType": "string",
        "name": "realContractIPFS",
        "type": "string"
      }
    ],
    "name": "createDisputableContract",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "payable",
    "type": "function",
    "payable": true
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "id",
        "type": "uint256"
      }
    ],
    "name": "signContract",
    "outputs": [
      {
        "internalType": "bool",
        "name": "",
        "type": "bool"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "id",
        "type": "uint256"
      }
    ],
    "name": "fileDispute",
    "outputs": [
      {
        "internalType": "bool",
        "name": "",
        "type": "bool"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "id",
        "type": "uint256"
      }
    ],
    "name": "fileDisputeByFirstParty",
    "outputs": [
      {
        "internalType": "bool",
        "name": "",
        "type": "bool"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "id",
        "type": "uint256"
      }
    ],
    "name": "fileDisputeBySecondParty",
    "outputs": [
      {
        "internalType": "bool",
        "name": "",
        "type": "bool"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "id",
        "type": "uint256"
      }
    ],
    "name": "getGuaranteeBack",
    "outputs": [
      {
        "internalType": "bool",
        "name": "",
        "type": "bool"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "id",
        "type": "uint256"
      }
    ],
    "name": "releaseGuaranteeToFirstParty",
    "outputs": [
      {
        "internalType": "bool",
        "name": "",
        "type": "bool"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "id",
        "type": "uint256"
      }
    ],
    "name": "paySecondParty",
    "outputs": [
      {
        "internalType": "bool",
        "name": "",
        "type": "bool"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "id",
        "type": "uint256"
      },
      {
        "internalType": "bool",
        "name": "releaseDecision",
        "type": "bool"
      }
    ],
    "name": "vote",
    "outputs": [
      {
        "internalType": "bool",
        "name": "",
        "type": "bool"
      }
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "id",
        "type": "uint256"
      }
    ],
    "name": "showDisputeableContract",
    "outputs": [
      {
        "internalType": "address",
        "name": "first_party",
        "type": "address"
      },
      {
        "internalType": "address",
        "name": "second_party",
        "type": "address"
      },
      {
        "internalType": "address",
        "name": "judge1",
        "type": "address"
      },
      {
        "internalType": "address",
        "name": "judge2",
        "type": "address"
      },
      {
        "internalType": "address",
        "name": "judge3",
        "type": "address"
      },
      {
        "internalType": "string",
        "name": "realContractIPFS",
        "type": "string"
      },
      {
        "internalType": "bool",
        "name": "signedBySecondParty",
        "type": "bool"
      },
      {
        "internalType": "bool",
        "name": "realeseDecisionByJudge1",
        "type": "bool"
      },
      {
        "internalType": "bool",
        "name": "realeseDecisionByJudge2",
        "type": "bool"
      },
      {
        "internalType": "bool",
        "name": "realeseDecisionByJudge3",
        "type": "bool"
      },
      {
        "internalType": "uint256",
        "name": "guaranteeValue",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [
      {
        "internalType": "uint256",
        "name": "_id",
        "type": "uint256"
      }
    ],
    "name": "showJudge",
    "outputs": [
      {
        "internalType": "address",
        "name": "",
        "type": "address"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [],
    "name": "showJudgeId",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  },
  {
    "inputs": [],
    "name": "showOwner",
    "outputs": [
      {
        "internalType": "address",
        "name": "",
        "type": "address"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  }
]

var web3 = false

// Using the 'load' event listener for Javascript to
// check if window.ethereum is available


window.addEventListener('load', async function()  {
  if (typeof window.ethereum !== 'undefined') {
    console.log('window.ethereum is enabled')
    if (window.ethereum.isMetaMask === true) {
      console.log('MetaMask is active')
      let mmDetected = document.getElementById('mm-detected')
      mmDetected.innerHTML += 'MetaMask Is <span style="color: green; font-weight: bold;">Available</span>!'
      // add in web3 here
      web3 = new Web3(window.ethereum)
      await ethereum.request({ method: 'eth_requestAccounts'})
      // grab mm-current-account
      // and populate it with the current address
      var mmCurrentAccount = document.getElementById('mm-current-account');
      mmCurrentAccount.innerHTML = 'Current Account: <b>' + ethereum.selectedAddress + '</b>'
      document.getElementById('content').style.display = 'block';
    } else {
      console.log('MetaMask is not available')
      let mmDetected = document.getElementById('mm-detected')
      mmDetected.innerHTML += 'MetaMask <span style="color: red;font-weight: bold;">Not Available!</span>'
      mmDetected.innerHTML += '<button onclick="location.reload();" class="btn btn-secondary mb-4">Try Again</button>'
      web3 = false
      document.getElementById('content').style.display = 'none';
      // let node = document.createTextNode('<p>MetaMask Not Available!<p>')
      // mmDetected.appendChild(node)
    }
  } else {
    web3 = false;
    console.log('window.ethereum is not found')
    let mmDetected = document.getElementById('mm-detected')
    mmDetected.innerHTML += '<p>MetaMask <span style="color: red;font-weight: bold;">Not Available!<span><p>'
    mmDetected.innerHTML += '<button onclick="location.reload();" class="btn btn-secondary mb-4">Try Again</button>'
    document.getElementById('content').style.display = 'none';
  }
});

// Grabbing the button object,  

// const mmEnable = document.getElementById('mm-connect');


// grab the button for input to a contract:

async function getDisputeableContractInfo(){
  const contract_id = document.getElementById('contract_id_info').value;
  console.log(contract_id)
  try{
    const disputeableContract = new web3.eth.Contract(ssABI, ssAddress)
    disputeableContract.setProvider(window.ethereum)

    const response = await disputeableContract.methods.showDisputeableContract(contract_id).call({from: ethereum.selectedAddress});
    console.log(response)
    document.getElementById('contract_information').innerHTML =
     '<tr><td>First Party</td><td>' + response.first_party + '</td></tr>' +
     '<tr><td>Second Party</td><td>' + response.second_party + '</td></tr>' +
     '<tr><td>Judge1</td><td>' + response.judge1 + '</td></tr>' +
     '<tr><td>Judge2</td><td>' + response.judge2 + '</td></tr>' +
     '<tr><td>Judge3</td><td>' + response.judge3 + '</td></tr>' +
     '<tr><td>Contract Image</td><td><a target="_blank" href="https://ipfs.io/ipfs/' + response.realContractIPFS + '">Image</td></tr>' +
     '<tr><td>Signed</td><td>' + response.signedBySecondParty + '</td></tr>' + 
     '<tr><td>Guarantee Value</td><td>' + response.guaranteeValue + '</td></tr>' + 
     '<tr><td>Release Decision (Judge1) </td><td>' + (response.realeseDecisionByJudge1 == true?"YES":"NO") + '</td></tr>' + 
     '<tr><td>Release Decision (Judge2) </td><td>' + (response.realeseDecisionByJudge2 == true?"YES":"NO") + '</td></tr>' + 
     '<tr><td>Release Decision (Judge3) </td><td>' + (response.realeseDecisionByJudge3 == true?"YES":"NO") + '</td></tr>';
  } catch(err){
    console.log(err)
    alert(err.message)
  } 
}

async function signContract(){
  const contract_id = document.getElementById('contract_id_sign').value;
  console.log(contract_id)
  try{
    const disputeableContract = new web3.eth.Contract(ssABI, ssAddress)
    disputeableContract.setProvider(window.ethereum)

    const response = await disputeableContract.methods.signContract(contract_id).send({from: ethereum.selectedAddress});
    console.log(response)
    alert('Disputeable Contract Signed')
  } catch(err){
    console.log(err)
    alert(err.message)
  } 
}

async function getGuaranteeBack(){
  const contract_id = document.getElementById('contract_id_get').value;
  console.log(contract_id)
  try{
    const disputeableContract = new web3.eth.Contract(ssABI, ssAddress)
    disputeableContract.setProvider(window.ethereum)

    const response = await disputeableContract.methods.getGuaranteeBack(contract_id).send({from: ethereum.selectedAddress});
    console.log(response)
    alert('Guarantee Restored')
  } catch(err){
    console.log(err)
    alert(err.message)
  } 
}

async function payGuarantee(){
  const contract_id = document.getElementById('contract_id_pay').value;
  console.log(contract_id)
  try{
    const disputeableContract = new web3.eth.Contract(ssABI, ssAddress)
    disputeableContract.setProvider(window.ethereum)

    const response = await disputeableContract.methods.paySecondParty(contract_id).send({from: ethereum.selectedAddress});
    console.log(response)
    alert('Guarantee Paid')
  } catch(err){
    console.log(err)
    alert(err.message)
  } 
}

async function releaseGuarantee(){
  const contract_id = document.getElementById('contract_id_release').value;
  console.log(contract_id)
  try{
    const disputeableContract = new web3.eth.Contract(ssABI, ssAddress)
    disputeableContract.setProvider(window.ethereum)

    const response = await disputeableContract.methods.releaseGuaranteeToFirstParty(contract_id).send({from: ethereum.selectedAddress});
    console.log(response)
    alert('Guarantee Released')
  } catch(err){
    console.log(err)
    alert(err.message)
  } 
}

async function dispute(){
  const contract_id = document.getElementById('contract_id_dispute').value;
  const party = document.getElementById('party').value;
  console.log(contract_id)
  console.log(party)
  try{
    const disputeableContract = new web3.eth.Contract(ssABI, ssAddress)
    disputeableContract.setProvider(window.ethereum)
    var response = false;
    if(party == 0 )
      response = await disputeableContract.methods.fileDisputeByFirstParty(contract_id).send({from: ethereum.selectedAddress});
    else if(party == 1)
      response = await disputeableContract.methods.fileDisputeBySecondParty(contract_id).send({from: ethereum.selectedAddress});
    else
      response = await disputeableContract.methods.fileDispute(contract_id).send({from: ethereum.selectedAddress});
    console.log(response)
    alert('Dispute Filled. The final decision will be based on the judges decisions and one of the parties will receive the guarantee value.')
  } catch(err){
    console.log(err)
    alert(err.message)
  } 
}

async function vote(){
  const contract_id = document.getElementById('contract_id_vote').value;
  const decision = document.getElementById('decision').value;
  console.log(contract_id)
  console.log(decision)
  try{
    const disputeableContract = new web3.eth.Contract(ssABI, ssAddress)
    disputeableContract.setProvider(window.ethereum)
    var response = false;
    if(decision == 0 )
      response = await disputeableContract.methods.vote(contract_id, true).send({from: ethereum.selectedAddress});
    else if(decision == 1)
      response = await disputeableContract.methods.vote(contract_id, false).send({from: ethereum.selectedAddress});
    else{
      alert("Please select a decision");
      return false; 
    }      
    console.log(response)
    alert('Your decision has been save and your compensation has been sent to you')
  } catch(err){
    console.log(err)
    alert(err.message)
  } 
}

async function addJudge() {
  const judge_address = document.getElementById('judge_address').value;
  console.log(judge_address)

  // var web3 = new Web3(window.ethereum)

  // instantiate smart contract instance
  
  try{
  const disputeableContract = new web3.eth.Contract(ssABI, ssAddress)
  disputeableContract.setProvider(window.ethereum)

  const response = await disputeableContract.methods.addJudge(judge_address).send({from: ethereum.selectedAddress});
  console.log(response)
  alert('Judge Added');
  document.getElementById('judge_address').value = '';
  } catch(err){
    console.log(err)
    alert(err.message)
  }
}
async function deleteJudge() {
  const judge_id = document.getElementById('judge_id').value;
  console.log(judge_id)

  var web3 = new Web3(window.ethereum)

  // instantiate smart contract instance
  
  try{
  const disputeableContract = new web3.eth.Contract(ssABI, ssAddress)
  disputeableContract.setProvider(window.ethereum)

  const response = await disputeableContract.methods.removeJudge(judge_id).send({from: ethereum.selectedAddress});
  console.log(response);
  alert('Judge Deleted');
  } catch(err){
    console.log(err)
    alert(err.message)
  }
}

async function stopContract(){
  var web3 = new Web3(window.ethereum)
  // instantiate smart contract instance 
  try{
  const disputeableContract = new web3.eth.Contract(ssABI, ssAddress)
  disputeableContract.setProvider(window.ethereum)
  const response = await disputeableContract.methods.stopContract().send({from: ethereum.selectedAddress});
  console.log(response)
  } catch(err){
    console.log(err)
    alert(err.message)
  }
}

async function resumeContract(){
  var web3 = new Web3(window.ethereum)
  // instantiate smart contract instance 
  try{
  const disputeableContract = new web3.eth.Contract(ssABI, ssAddress)
  disputeableContract.setProvider(window.ethereum)
  const response = await disputeableContract.methods.resumeContract().send({from: ethereum.selectedAddress});
  console.log(response)
  } catch(err){
    console.log(err)
    alert(err.message)
  }
}
var response = false;
async function createDisputableContract(){
  var web3 = new Web3(window.ethereum)
  let secondParty = document.getElementById('second_party_address').value;
  let guaranteeValue = document.getElementById('value').value;
  if(!secondParty){
    alert("Please enter the address of the second party");
    return false;
  } 
  if(!guaranteeValue || guaranteeValue < 2){
    alert("Please enter guarantee value more than or equals 2 Ethers");
    return false;
  }
  if(!contractImageHash){
    alert("Please upload the contract image");
    return false;
  }
  try{
  const disputeableContract = new web3.eth.Contract(ssABI, ssAddress)
  disputeableContract.setProvider(window.ethereum)
  response = await disputeableContract.methods.createDisputableContract(secondParty, contractImageHash).send(
    {from: ethereum.selectedAddress,value: web3.utils.toWei(guaranteeValue, "ether")});
  const output = response.events.LogDisputableContractCreated.returnValues;
  alert('Disputeable Contract Created.\nId: ' + output._id
  + "\nSecond Party: " + output.secondParty
  + "\nValue: " + output.value
  + '\nJudge1: ' + output.judge1
  + '\nJudge2: ' + output.judge2
  + '\nJudge3: ' + output.judge3
  )
  console.log(response)
  } catch(err){
    console.log(err)
    alert(err.message)
  }
}



/* global location */


const $logs = document.querySelector('#logs')

const $dragContainer = document.querySelector('#drag-container')
const $progressBar = document.querySelector('#progress-bar')

const $emptyRow = document.querySelector('.empty-row')

const $allDisabledButtons = document.querySelectorAll('button:disabled')
const $allDisabledInputs = document.querySelectorAll('input:disabled')
const $allDisabledElements = document.querySelectorAll('.disabled')

const FILES = []
const workspace = location.hash

let fileSize = 0
let contractImageHash = false;
let node
let info
const { Buffer } = Ipfs
console.log(Ipfs)
console.log(Buffer)
/* ===========================================================================
   Start the IPFS node
   =========================================================================== */

async function  start ()  {
  if (!node) {
    const options = {
      EXPERIMENTAL: {
        pubsub: true
      },
      repo: 'ipfs-' + Math.random(),
      config: {
        Addresses: {
          Swarm: ['/dns4/ws-star.discovery.libp2p.io/tcp/443/wss/p2p-websocket-star']
        }
      }
    }
    const nodeId = 'ipfs-' + Math.random()
    try {
      node = await Ipfs.create()
    } catch(err) {
      handleOnError(err);
    }
    console.log("Your node: " + nodeId)
    window.node = node
    const status = node.isOnline() ? 'online' : 'offline'

          info = await node.id();
          console.log(info)
          updateView('ready', node)
          onSuccess('Node is ready.')
          // setInterval(refreshPeerList, 1000)
          setInterval(sendFileList, 10000)


      subscribeToWorkpsace()
  }
}

/* ===========================================================================
   Pubsub
   =========================================================================== */

const messageHandler = (message) => {
  const myNode = info.id
  const hash = message.data.toString()
  const messageSender = message.from

  // append new files when someone uploads them
  if (myNode !== messageSender && !isFileInList(hash)) {
    // $multihashInput.value = hash
    getFile()
  }
}

const subscribeToWorkpsace = () => {
  node.pubsub.subscribe(workspace, messageHandler)
    .catch(() => onError('An error occurred when subscribing to the workspace.'))
}

const publishHash = (hash) => {
  const data = Buffer.from(hash)

  node.pubsub.publish(workspace, data)
    .catch(() => onError('An error occurred when publishing the message.'))
}

/* ===========================================================================
   Files handling
   =========================================================================== */

const isFileInList = (hash) => FILES.indexOf(hash) !== -1

const sendFileList = () => FILES.forEach((hash) => publishHash(hash))

const updateProgress = (bytesLoaded) => {
  let percent = 100 - ((bytesLoaded / fileSize) * 100)

  $progressBar.style.transform = `translateX(${-percent}%)`
}

const resetProgress = () => {
  $progressBar.style.transform = 'translateX(-100%)'
}

/* Drag & Drop
   =========================================================================== */

const onDragEnter = () => $dragContainer.classList.add('dragging')

const onDragLeave = () => $dragContainer.classList.remove('dragging')

async function onDrop (event) {
  onDragLeave()
  event.preventDefault()
  contractImageHash = false;
  document.getElementById('image-link').innerHTML = "<a class='btn btn-link btn-block'>Uploading Contract Image</a>"
  const dt = event.dataTransfer
  const filesDropped = dt.files

  function readFileContents (file) {
    // return fs.readFileSync(file);
    return new Promise((resolve) => {
      const reader = new window.FileReader()
      reader.onload = (event) => resolve(event.target.result)
      reader.readAsArrayBuffer(file)
    })
  }

  const files = []
  for (let i = 0; i < filesDropped.length; i++) {
    files.push(filesDropped[i])
  }

  const imgData = await readFileContents(files[0])
  console.log(imgData)
  try{
  let added = await node.add({
    path: files[0].name,
    content: imgData
  }, { wrap: true, progress: updateProgress }, (err, filesAdded) => {
    console.log(err)
    if (err) {
      return onError(err)
    }
    console.log(filesAdded)
    resetProgress()
  });
  contractImageHash = added.cid.toString();
  console.log(added);
  console.log(added.cid.toString());
  document.getElementById('image-link').innerHTML = "<a class='btn btn-link btn-block' href='https://ipfs.io/ipfs/" +  added.cid.toString() + "' target='_blank'>Contract Image</a>"
} catch(err){
  console.log('exception')
  onError(err);
}

  
}

const addText = async () => {
  const added = await ipfs.add('hello');
  var ipfsSave = await node.add({ 
                          content: added 
                    });
  console.log(ipfsSave)
}


/* ===========================================================================
   Peers handling
   =========================================================================== */


/* ===========================================================================
   Error handling
   =========================================================================== */

function onSuccess (msg) {
  $logs.classList.add('success')
  $logs.innerHTML = msg
}

function onError (err) {
  let msg = 'An error occured, check the dev console'

  if (err.stack !== undefined) {
    msg = err.stack
  } else if (typeof err === 'string') {
    msg = err
  }

  $logs.classList.remove('success')
  $logs.innerHTML = msg
}

window.onerror = onError

/* ===========================================================================
   App states
   =========================================================================== */

const states = {
  ready: () => {
    const addressesHtml = info.addresses.map((address) => {
      return `<li><pre>${address}</pre></li>`
    }).join('')
    $allDisabledButtons.forEach(b => { b.disabled = false })
    $allDisabledInputs.forEach(b => { b.disabled = false })
    $allDisabledElements.forEach(el => { el.classList.remove('disabled') })
  }
}

function updateView (state, ipfs) {
  if (states[state] !== undefined) {
    states[state]()
  } else {
    throw new Error('Could not find state "' + state + '"')
  }
}

/* ===========================================================================
   Boot the app
   =========================================================================== */

const startApplication = () => {
  // Setup event listeners
  $dragContainer.addEventListener('dragenter', onDragEnter)
  $dragContainer.addEventListener('dragover', onDragEnter)
  $dragContainer.addEventListener('drop', onDrop)
  $dragContainer.addEventListener('dragleave', onDragLeave)

  start()
}

function handleOnError(error) {
  console.error(error);
  
  var modalElement = document.getElementById('modal');
  modalElement.style.display = 'flex';
  
  const errorStr = String(error).toLowerCase();
  var spanElement = document.getElementById('errorText');

  spanElement.innerHTML = errorStr.includes('SecurityError'.toLowerCase()) 
    ? 'You must use Chrome or Firefox to test this embedded app!' 
    : 'Something went wrong. See the console to get further details.';
}

startApplication()



//const amount = 2; // Willing to send 2 ethers
//const amountToSend = web3.toWei(amount, "ether");