// Narahc Coinbs ICO

pragma solidity ^0.4.11; 

contract Narahccoins_ico {
    
    // Introducing the maximum number of Narahccoins for sale
    uint public max_narahccoins = 1000000;
    
    // Introducing USD to Narahccoins conversion rate
    uint public usd_to_narahccoins = 1000;

    // Introducing the total number of Narahccoins that have been bought by the investors
    uint public total_narahccoins_bought = 0;
    
    // Mapping from the investor to his equity in USD and Narahccoins
    mapping(address => uint) equity_narahccoins;
    mapping(address => uint) equity_usd;
    
    // Checking if an investor can buy Narahccoins
    modifier can_buy_narahccoins(uint usd_invested) {
        require (usd_invested * usd_to_narahccoins + total_narahccoins_bought <= max_narahccoins);
        _;
    }

    // Getting the equity in Narahccoins of an investor
    function equity_in_narahccoins(address investor) external constant returns (uint) {
        return equity_narahccoins[investor];
    }
    
    // Getting the equity in USD of an investor
    function equity_in_usd(address investor) external constant returns (uint) {
        return equity_usd[investor];
    }
    
    // Buying Narahccoins
    function buy_narahccoins(address investor, uint usd_invested) external 
    can_buy_narahccoins(usd_invested) {
        uint narahccoins_bought = usd_invested * usd_to_narahccoins;
        equity_narahccoins[investor] += narahccoins_bought;
        equity_usd[investor] = equity_narahccoins[investor] / usd_to_narahccoins;
        total_narahccoins_bought += narahccoins_bought;
    }
    
    //Selling Narahccoins
    function sell_narahccoins(address investor, uint narahccoins_sold) external {
        equity_narahccoins[investor] -= narahccoins_sold;
        equity_usd[investor] = equity_narahccoins[investor] / usd_to_narahccoins;
        total_narahccoins_bought -= narahccoins_sold;
    }
}





