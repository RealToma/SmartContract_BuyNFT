pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor() ERC20("THOMAS_TOKEN", "TKT") {
        _mint(msg.sender, 1000 * 10**18);
    }
}
