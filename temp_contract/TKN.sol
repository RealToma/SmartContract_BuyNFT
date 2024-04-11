pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract TKN is ERC20 {
  constructor() ERC20('Thomas NFT', 'TKN') {}
  function mint(address to, uint amount) external {
    _mint(to, amount);
  }
}
