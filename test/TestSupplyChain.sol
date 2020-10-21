pragma solidity  >=0.4.21 <0.6.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/SupplyChain.sol";


contract TestSupplyChain {

    // Test for failing conditions in this contracts:
    // https://truffleframework.com/tutorials/testing-for-throws-in-solidity-tests
    SupplyChain public supplyChain;
    uint public initialBalance = 1 ether;
    
    // Run before every test function
    function beforeEach() public {
        supplyChain = new SupplyChain();
        initialBalance = 1 ether;
    }
    // buyItem
      // test1 for failure if user does not send enough funds
    function test1BuyItem() public returns (bool) {

        supplyChain.addItem("Car",900);        

        bool r;

        (r, ) = address(supplyChain).call.value(500)(abi.encodeWithSignature("buyItem(uint256)",0));
        Assert.isFalse(r, "If this is true, something is broken!");
    }
      // test2 for purchasing an item that is not for Sale
     function () external payable {} 

     function test2BuyItem() public returns (bool) {
        bool r;

        supplyChain.addItem("Car",900);        

        // Buy item, should pass
        (r, ) = address(supplyChain).call.value(1000)(abi.encodeWithSignature("buyItem(uint256)",0));
        Assert.isTrue(r, "If this is false, something is broken!");

        // Try to buy same item again, should fail
        (r, ) = address(supplyChain).call.value(1000)(abi.encodeWithSignature("buyItem(uint256)",0));
        Assert.isFalse(r, "If this is true, something is broken!");

        return true;
    }

    // shipItem

    // test for calls that are made by not the seller
    // test for trying to ship an item that is not marked Sold

    // receiveItem

    // test calling the function from an address that is not the buyer
    // test calling the function on an item not marked Shipped

}
