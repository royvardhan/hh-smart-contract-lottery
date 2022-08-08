// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

error Raffle_NotEnoughETHEntered();

contract Raffle is VRFConsumerBaseV2 {

    uint256 private immutable i_entranceFee;
    address payable[] private s_players;

    event LogPlayerEntered(address indexed player, uint256 amount);

    constructor(uint256 entranceFee, address vrfCoordinatorv2) VRFConsumerBaseV2(vrfCoordinatorv2) {
        i_entranceFee = entranceFee;
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
   
   }

   function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords) internal override {

   }

   function getPlayer(uint256 playerIndex) public view returns (address) {
       return s_players[playerIndex];
   }
    
   } 

