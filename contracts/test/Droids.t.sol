// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {Droids} from "../src/Droids.sol";

contract DroidsTest is Test {
    Droids public droids;
    address public owner = address(1);
    address public user1 = address(2);

    function setUp() public {
        vm.startPrank(owner);
        droids = new Droids(owner);
        vm.stopPrank();
    }

    function test_Deployment() public view {
        assertEq(droids.owner(), owner);
        assertEq(droids.name(), "Droids");
        assertEq(droids.symbol(), "DROID");
    }

    function test_Mint() public {
        vm.deal(user1, 1 ether);
        vm.startPrank(user1);
        
        uint256 mintPrice = droids.MINT_PRICE();
        string memory uri = "ipfs://QmTest";
        
        droids.safeMint{value: mintPrice}(user1, uri);
        
        assertEq(droids.balanceOf(user1), 1);
        assertEq(droids.ownerOf(0), user1);
        assertEq(droids.tokenURI(0), "https://api.droids.example.com/metadata/ipfs://QmTest"); // Note: URIStorage usually concatenates if baseURI is set? No, let's check.
        // Actually, ERC721URIStorage implementation: if baseURI is set, and tokenURI is set, it might just return tokenURI or baseURI + tokenURI.
        // OpenZeppelin ERC721URIStorage: if _tokenURIs[tokenId] is set, and baseURI is length > 0, it concatenates?
        // Let's check OZ implementation behavior. Usually it concatenates baseURI + _tokenURI.
        // My baseURI is "https://api.droids.example.com/metadata/".
        // My tokenURI is "ipfs://QmTest".
        // Result: "https://api.droids.example.com/metadata/ipfs://QmTest".
        
        vm.stopPrank();
    }

    function test_MintInsufficientFunds() public {
        vm.deal(user1, 0.0001 ether);
        vm.startPrank(user1);
        
        string memory uri = "test";
        vm.expectRevert(bytes("Insufficient funds"));
        droids.safeMint{value: 0.0001 ether}(user1, uri);
        
        vm.stopPrank();
    }

    function test_Withdraw() public {
        vm.deal(user1, 1 ether);
        vm.prank(user1);
        droids.safeMint{value: 0.001 ether}(user1, "uri");

        assertEq(address(droids).balance, 0.001 ether);

        uint256 ownerPreBalance = owner.balance;
        
        vm.prank(owner);
        droids.withdraw();

        assertEq(address(droids).balance, 0);
        assertEq(owner.balance, ownerPreBalance + 0.001 ether);
    }
}
