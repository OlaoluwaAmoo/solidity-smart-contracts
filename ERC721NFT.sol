// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import OpenZeppelin's ERC721 implementation
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title SkutiiNFT
 * @dev Basic ERC721 NFT contract for learning purposes
 * @author skutii
 */
contract SkutiiNFT is ERC721, Ownable {
    uint256 public nextTokenId; // Keeps track of minted token IDs
    string private baseTokenURI; // Base URI for metadata

    // Constructor sets the name and symbol of the NFT
    constructor(string memory baseURI) ERC721("SkutiiNFT", "SKT") {
        baseTokenURI = baseURI;
        nextTokenId = 1; // Start minting from tokenId 1
    }

    /**
     * @notice Mint a new NFT to a specified address
     * @dev Only the contract owner (skutii) can call this
     * @param to The address that will own the minted NFT
     */
    function mint(address to) external onlyOwner {
        _safeMint(to, nextTokenId);
        nextTokenId++;
    }

    /**
     * @notice Returns the base URI for all token metadata
     * @dev Example: if baseURI = "ipfs://Qm123/", tokenId 1 = "ipfs://Qm123/1"
     */
    function _baseURI() internal view override returns (string memory) {
        return baseTokenURI;
    }

    /**
     * @notice Update the base URI (e.g., point to a new IPFS folder)
     * @param newBaseURI The new metadata base URI
     */
    function setBaseURI(string memory newBaseURI) external onlyOwner {
        baseTokenURI = newBaseURI;
    }
}
