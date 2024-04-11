pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract NFTToken is ERC20, Ownable {
    string public nameNFT;
    string public nameSymbol;

    constructor() ERC20("THOMAS_NFT", "TFT") {
        nameNFT = "T_NFT";
        nameSymbol = "TFT";
    }

    event MintNFT(
        address indexed _to,
        uint256 indexed _tokenId,
        bytes32 _ipfsHash
    );

    event TransferNFT(
        address indexed _from,
        address indexed _to,
        uint256 indexed _tokenId
    );

    uint256 tokenCounter = 1;
    mapping(uint256 => address) internal idToOwner;
    mapping(uint256 => uint256) public tokenIdToValue;

    function mint(address _to, bytes32 _ipfsHash) public {
        uint256 _tokenId = tokenCounter;
        idToOwner[_tokenId] = _to;
        tokenCounter++;
        emit MintNFT(_to, _tokenId, _ipfsHash);
    }

    function tokenPrice(uint256 _tokenID)
        public
        view
        returns (uint256 nftPrice)
    {
        nftPrice = tokenIdToValue[_tokenID];
    }

    // function transfer(address _to, uint256 _tokenId) public {
    //     require(msg.sender == idToOwner[_tokenId]);
    //     idToOwner[_tokenId] = _to;
    //     emit TransferNFT(msg.sender, _to, _tokenId);
    // }
}
