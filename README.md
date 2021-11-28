# blockchain-developer-bootcamp-final-project
**Disputeable contract**
The purpose of this smart contract is to let two parties have an on-chain real contract where one of the parties will put Ether as a guarantee. The other party can release the held Ether whenever they want according to the agreement they have with the first party. In case of disagreement between the two parties, they can ask for dispute resolution. There will be three random judges that will go back to the on-chain real contract and make a decision based on that. The judges for any Disputeable Contract will be chosen randomly from a pool of judges. The dispute resolution will be according to the dominant decision by the three judges.
The process will be as follows:
1.	The owner of the contract can add new judges to the pool of judges or delete them.
2.	The entity who will be providing Ether as guarantee will create the Disputeable Contract where he will enter the address of the other party and send also the Ether value that will be held as a guarantee. In addition, he/she will upload the contract image to IPFS. After creating the Disputeable Contract, the user will get an id to refer to it.
3.	The judges will be chosen randomly from a pool of judges that can be controlled by the smart contract owner.
4.	The second party will have to sign the contract to make the Disputeable Contract valid.
5.	The first party can withdraw their Ether as long as the second party did not sign the Disputeable Contract.
6.	Once the second party signs the Disputeable Contract, they will be able to release the held Ether manually according to the agreement they have with the first party.
7.	At any time, if the Ether is not released, any party can ask for dispute resolution.
8.	When a dispute resolution is filled, the judges will have to refer to the on-chain real contract to make a judge whether to release the held Ether or pay it to the second party.
9.	Each judge receives a percentage of the held Ether to compensate them for the time spent on judging and the Gas used to send the final decision to the blockchain.
<p align="center">
  <img src="https://abdulrazakzakieh.com/contract/about.png" width="100%" alt="disputeable contract">
</p>

**Public Ethereum Account:**
0x0695939B01390aF18b6B4C3A520aC36129c79FF0

**For accessing the front end:**
https://abdulrazakzakieh.com/contract/

**Screen Cast walking through the project:**
https://youtu.be/abizFRhtE1I

**Prerequisites:**
- npm
- dotenv
- hdwallet
- truffle

**Running Tests:**
- Run truffle test

**Migrating the contracts to Rinkeby:**
- Put your infura project id in line 25 in truffle-config.js file.
- Put your secret recovery phrase in the .env file like this:
  - MNEMONIC="your secret recovery phrase"
- Run truffle migrate --network rinkeby

**Directory Structure:**
- frontend: The webpages used to interact with the smart contract (HTML/CSS/JS)
- contracts: The disputeable contract code in solidity
- migrations: Migration files to deploy the contracts
- test: The unit tests for Disputeable Contract (9 tests)

**TODO:**
- Make sure no judges has been selected twice for the same disputeable contract
- Make sure the selected judge is not one of the parties
