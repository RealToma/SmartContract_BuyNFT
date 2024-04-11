pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./MyNFT.sol";
import "./MyToken.sol";

contract MyNFTMarketPlace {

    MyToken token;
    MyNFT NFT;

    mapping(uint256 => bool) public tokenIdForSale;
    mapping(uint256 => address) public nftBuyers;

    constructor(address tokenAddress, address NFTAddress) {
        token = MyToken(tokenAddress);
        NFT = MyNFT(NFTAddress);
    }

    function nftSale(uint256 _tokenId, bool forSale) external {
        require(
            msg.sender == NFT.ownerOf(_tokenId),
            "Only owners can change this status"
        );
        tokenIdForSale[_tokenId] = forSale;
    }

    function nftBuy(uint256 _tokenId) public payable {
        require(tokenIdForSale[_tokenId], "Token must be on sale first");
        uint256 nftPrice = NFT.tokenPrice(_tokenId);
        require(msg.value >= nftPrice, "Insufficient balance.");
        token.transfer(payable(NFT.ownerOf(_tokenId)), nftPrice);
        nftBuyers[_tokenId] = msg.sender;
    }
}
