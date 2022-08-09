// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";

error Raffle_NotEnoughETHEntered();

contract Raffle is VRFConsumerBaseV2 {

    uint256 private immutable i_entranceFee;
    address payable[] private s_players;
    VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
    bytes32 private immutable i_keyHash;
    uint64 private immutable i_subscriptionId;
    uint32 private immutable i_callbackGasLimit;
    uint16 private constant REQUEST_CONFIRMATIONS = 3;
    uint32 private constant NUM_WORDS = 1;

    event LogPlayerEntered(address indexed player, uint256 amount);

    constructor(uint256 entranceFee, address vrfCoordinatorv2, bytes32 keyHash, uint64 subscriptionId, uint32 callbackGasLimit ) VRFConsumerBaseV2(vrfCoordinatorv2) {
        i_entranceFee = entranceFee;
        i_keyHash = keyHash;
        i_subscriptionId = subscriptionId;
        i_callbackGasLimit = callbackGasLimit;
        i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinatorv2);
    }

    function getEntranceFee() public view returns (uint256) {
        return i_entranceFee;
        
    }

   function enterRaffle() public payable {
    if (msg.value < i_entranceFee) {
        revert Raffle_NotEnoughETHEntered();
    }
    s_players.push(payable(msg.sender));
    emit LogPlayerEntered(msg.sender, msg.value);
    
   }

   function pickRandomWinner() external {
    i_vrfCoordinator.requestRandomWords(
      i_keyHash,
      i_subscriptionId,
      REQUEST_CONFIRMATIONS,
      i_callbackGasLimit,
      NUM_WORDS
    );
   
   }

   function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords) internal override {

   }

   function getPlayer(uint256 playerIndex) public view returns (address) {
       return s_players[playerIndex];
   }
    
   } 

