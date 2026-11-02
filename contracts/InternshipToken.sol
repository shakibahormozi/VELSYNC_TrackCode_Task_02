// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20Capped} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract InternshipToken is ERC20, ERC20Burnable, ERC20Capped, Ownable {

    uint256 public constant INITIAL_SUPPLY = 500_000 * 10 ** 18;
    uint256 public constant MAX_SUPPLY = 1_000_000 * 10 ** 18;

    constructor()
        ERC20("Internship Practice Token", "IPT")
        ERC20Capped(MAX_SUPPLY)
        Ownable(msg.sender)
    {
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    // Mint new tokens (Owner only)
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    // Resolve the ERC20 and ERC20Capped inheritance conflict
    function _update(
        address from,
        address to,
        uint256 value
    )
        internal
        override(ERC20, ERC20Capped)
    {
        super._update(from, to, value);
    }
}
