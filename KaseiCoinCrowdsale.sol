pragma solidity ^0.5.0;

import "./KaseiCoin.sol";
import "http://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "http://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
//import "https://github.com/nitika-goel/openzeppelin-solidity/blob/master/contracts/crowdsale/validation/CappedCrowdsale.sol";
//import "https://github.com/nitika-goel/openzeppelin-solidity/blob/master/contracts/crowdsale/validation/TimedCrowdsale.sol";
//import "https://github.com/MerkleBlue/tokenmint/blob/master/contracts/open-zeppelin-contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";
//import "https://github.com/Qqwy/zeppelin-solidity/blob/master/contracts/crowdsale/RefundableCrowdsale.sol";


contract KaseiCoinCrowdsale is Crowdsale, MintedCrowdsale { // UPDATE THE CONTRACT SIGNATURE TO ADD INHERITANCE
    
    constructor(
        uint rate, // rate in KASEI bits
        address payable wallet, // sale beneficiary
        KaseiCoin token // the KaseiCoin itself that the crowdsale will work with
    ) public {
        // constructor can stay empty
    }
}

contract KaseiCoinCrowdsaleDeployer {
    
    address public kasei_token_address;
    address public kasei_crowdsale_address;
    
    // Add the constructor.
    constructor(
       string memory name,
       string memory symbol,
       address payable wallet
       
    ) public {
        // Create a new instance of the KaseiCoin contract.
        KaseiCoin token = new KaseiCoin(name, symbol, 0);
        
        // Assign the token contract’s address to the `kasei_token_address` variable.
        kasei_token_address = address(token);

        // Create a new instance of the `KaseiCoinCrowdsale` contract
        KaseiCoinCrowdsale kasei_crowdsale = new KaseiCoinCrowdsale(1, wallet, token);
            
        // Aassign the `KaseiCoinCrowdsale` contract’s address to the `kasei_crowdsale_address` variable.
        kasei_crowdsale_address = address(kasei_crowdsale);

        // Set the `KaseiCoinCrowdsale` contract as a minter
        token.addMinter(kasei_crowdsale_address);
        
        // Have the `KaseiCoinCrowdsaleDeployer` renounce its minter role.
        token.renounceMinter();
    }
}
