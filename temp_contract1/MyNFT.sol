pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract MyNFT is ERC20, Ownable {
    uint256 public nftSharePrice;
    uint256 public nftShareSupply;
    uint256 public nftSaleEnd;

    uint256 public nftID;
    IERC721 public nft;
    IERC20 public dai;
    address public NFTadmin;

    mapping(uint256 => uint256) public tokenIdToValue;

    constructor(
        string memory _name,
        string memory _symbol,
        address _nftAddress,
        uint256 _nftID,
        uint256 _nftSharePrice,
        uint256 _nftShareSupply,
        address _daiAddress
    ) ERC20(_name, _symbol) {
        nftID = _nftID;
        nft = IERC721(_nftAddress);
        nftSharePrice = _nftSharePrice;
        nftShareSupply = _nftShareSupply;
        dai = IERC20(_daiAddress);
        NFTadmin = msg.sender;
    }

    function startSale() external {
        require(msg.sender == NFTadmin, "Only the admin can do this");
        nft.transferFrom(msg.sender, address(this), nftID);
        nftSaleEnd = block.timestamp + 7 * 86400;
    }

    function buyNFT(uint256 shareAmount) external {
        require(nftSaleEnd > 0, "The sale hasn't started yet");
        require(block.timestamp <= nftSaleEnd, "The sale has finished");

        require(
            totalSupply() + shareAmount <= nftShareSupply,
            "Not enough shares left to buy"
        );
        uint256 daiAmount = shareAmount * nftSharePrice;
        dai.transferFrom(msg.sender, address(this), daiAmount);
        tokenIdToValue[nftID] = nftSharePrice;
        _mint(msg.sender, shareAmount);
    }

    function tokenPrice(uint256 _tokenID)
        public
        view
        returns (uint256 nftPrice)
    {
        nftPrice = tokenIdToValue[_tokenID];
    }

    // function withdrawProfits() external {
    //     require(msg.sender == NFTadmin, "Only the admin can do this");
    //     require(block.timestamp > nftSaleEnd, "Sale is not done yet");

    //     uint256 daiBalance = dai.balanceOf(address(this));
    //     if (daiBalance > 0) {
    //         dai.transfer(NFTadmin, daiBalance);
    //     }

    //     uint256 unsoldShareBalance = nftShareSupply - totalSupply();
    //     if (unsoldShareBalance > 0) {
    //         _mint(NFTadmin, unsoldShareBalance);
    //     }
    // }
}
