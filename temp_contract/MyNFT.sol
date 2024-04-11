pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol"; // for fungible token to manipulate DAI token
import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; // for fungible token to manipulate DAI token


contract MyNFT is
    ERC20 // inherit from ERC20
{
    uint256 public icoSharePrice; // total supply for all of this share
    uint256 public icoShareSupply; // price for each share
    uint256 public icoEnd; // limited in time

    uint256 public nftId; // specify its id in the smart contract of the nft
    IERC721 public nft; // pointer to NFT token
    IERC20 public dai;

    address public admin; // person that buy the nft token and send it to the fungible nft

    constructor(
        // a function which is called when we deploy the smart contract we're gonna pass a couple of argumetns
        string memory _name,
        string memory _symbol,
        address _nftAddress,
        uint256 _nftId,
        uint256 _icoSharePrice,
        uint256 _icoShareSupply,
        address _daiAddress
    ) ERC20(_name, _symbol) {
        nftId = _nftId;
        nft = IERC721(_nftAddress);
        icoSharePrice = _icoSharePrice;
        icoShareSupply = _icoShareSupply;
        dai = IERC20(_daiAddress);
        admin = msg.sender;
    }

    // function to start the ICO
    function startIco() external {
        require(msg.sender == admin, "only admin");
        nft.transferFrom(msg.sender, address(this), nftId); // center of transaction
        icoEnd = block.timestamp + 7 * 86400;
    }

    // buy a share of this contract
    function buyShare(uint256 shareAmount) external {
        require(icoEnd > 0, "ICO not started yet");
        require(block.timestamp <= icoEnd, "ICO is finished");
        require(
            totalSupply() + shareAmount <= icoShareSupply,
            "not enough shares left"
        );
        uint256 daiAmount = shareAmount * icoSharePrice;
        dai.transferFrom(msg.sender, address(this), daiAmount);
        _mint(msg.sender, shareAmount);
    }

    function withdrawIcoProfits() external {
        require(msg.sender == admin, "only admin");
        require(block.timestamp > icoEnd, "ICO not finished yet");
        uint256 daiBalance = dai.balanceOf(address(this));
        if (daiBalance > 0) {
            dai.transfer(admin, daiBalance);
        }
        uint256 unsoldShareBalance = icoShareSupply - totalSupply();
        if (unsoldShareBalance > 0) {
            _mint(admin, unsoldShareBalance);
        }
    }
}
