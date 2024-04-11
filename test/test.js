const { expect } = require("chai");
const { ethers } = require("hardhat");

const DAI_AMOUNT = web3.utils.toWei('25000');
const SHARE_AMOUNT = web3.utils.toWei('25000');


describe("MyNFT", function async() {
  it("Should return the new greeting once it's changed", async function () {

    const [owner] = await ethers.getSigners();

    console.log("owner:", owner.address);
    const MyNFT = await ethers.getContractFactory("MyNFT");
    const mynft = await MyNFT.deploy("THOMAS_NFT", "TKN","0x7C7572a2227065321Ce01f444CB1A63A3caA8509",0,100,100,"0x7C7572a2227065321Ce01f444CB1A63A3caA8509");

    await mynft.tokenPrice(30);
    console.log("mynft:", mynft.nftSharePrice);


    await mynft.approve(rft.address, DAI_AMOUNT, {from: buyer1}); // {from: buyer}: buyer send this transaction
    // await rft.buyShare(SHARE_AMOUNT, {from:buyer1});
    // await dai.approve(rft.address, DAI_AMOUNT, {from: buyer2});
    // await rft.buyShare(SHARE_AMOUNT, {from:buyer2});
    // await dai.approve(rft.address, DAI_AMOUNT, {from: buyer3});
    // await rft.buyShare(SHARE_AMOUNT, {from:buyer3});
    // await dai.approve(rft.address, DAI_AMOUNT, {from: buyer4});
    // await rft.buyShare(SHARE_AMOUNT, {from:buyer4});
    // const balanceShareBuyer1 = await rft.balanceOf(buyer1);
    // const balanceShareBuyer2 = await rft.balanceOf(buyer2);
    // const balanceShareBuyer3 = await rft.balanceOf(buyer3);
    // const balanceShareBuyer4 = await rft.balanceOf(buyer4);
    // assert(balanceShareBuyer1.toString() === SHARE_AMOUNT);
    // assert(balanceShareBuyer2.toString() === SHARE_AMOUNT);
    // assert(balanceShareBuyer3.toString() === SHARE_AMOUNT);
    // assert(balanceShareBuyer4.toString() === SHARE_AMOUNT);
    // // check that admin has all the dai token
    // // admin is the one who spent money initally to buy the nft token
    // const balanceAdminDai = await dai.balanceOf(admin);
    // assert(balanceAdminDai.toString() === web3.utils.toWei('100000'))
    // await mynft.deployed();

    // expect(await mynft.greet()).to.equal("Hello, world!");

    // const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // // wait until the transaction is mined
    // await setGreetingTx.wait();

    // expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
});
