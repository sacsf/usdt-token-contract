// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title USDT
 * @dev This contract implements an ERC20 token resembling Tether (USDT) with additional functionality.
 */
contract USDT is ERC20, Ownable {
    /**
     * @dev Constructor that initializes the contract with the initial owner and mints initial supply.
     * @param initialOwner Address of the initial owner of the contract.
     */
    constructor(address initialOwner) ERC20("Tether USD", "USDT") Ownable(initialOwner) {
        // Mint initial supply to the owner (1,000,000 tokens with decimals)
        _mint(initialOwner, 1000000 * 10 ** decimals());
    }

    /**
     * @dev Function to mint new tokens. Only the owner can call this.
     * @param to Address to receive the minted tokens.
     * @param amount Amount of tokens to mint.
     */
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    /**
     * @dev Function to burn tokens from an address. Only the owner can call this.
     * @param from Address from which tokens will be burned.
     * @param amount Amount of tokens to burn.
     */
    function burn(address from, uint256 amount) external onlyOwner {
        _burn(from, amount);
    }

    /**
     * @dev Implements a basic hook for flash transactions (e.g., flash loans).
     * @param account The account performing the flash transaction.
     * @param amount The amount involved in the transaction.
     */
    function flashTransaction(address account, uint256 amount) external onlyOwner {
        require(balanceOf(account) >= amount, "Insufficient balance for flash transaction");

        // Temporarily reduce balance
        _burn(account, amount);

        // Simulate external operations (business logic)
        // Add your logic here if needed

        // Reissue the tokens back to the account
        _mint(account, amount);
    }
} 
