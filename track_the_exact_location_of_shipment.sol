// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract TrackingTheExactLocationOfShipment{

    struct packageDetails{
        uint packageId;
        address senderAddress;
        address receiverAddress;
        string locationOfSenderAddress;
        string locationOfReceiverAddress;
        uint amount;
        bool isDelivered;
    }

    mapping(uint => packageDetails) allPackages;

    packageDetails[] private allPackagesList;

    function shipAPackage(address receiverAddress, string memory locationOfSenderAddress, string memory locationOfReceiverAddress, uint amount) public returns(packageDetails memory){
        uint packageId = allPackagesList.length + 1;
        allPackagesList.push(packageDetails(packageId, msg.sender, receiverAddress, locationOfSenderAddress, locationOfReceiverAddress, amount, false));
        allPackages[packageId] = packageDetails(packageId, msg.sender, receiverAddress, locationOfSenderAddress, locationOfReceiverAddress, amount, false);
        return allPackages[packageId];
    }

    function getPackageByPackgeId(uint packageId) public view returns(packageDetails memory){
        require(allPackages[packageId].packageId != 0 ,"Package not exists against this pacakge ID");
        require(allPackages[packageId].senderAddress == msg.sender || allPackages[packageId].receiverAddress == msg.sender, "You don't have permision to access this package details");
        return allPackages[packageId];
    }

    function markPackageAsDelivered(uint packageId) public returns(string memory){
        require(allPackages[packageId].packageId != 0 ,"Package not exists against this pacakge ID");
        require(allPackages[packageId].senderAddress == msg.sender || allPackages[packageId].receiverAddress == msg.sender, "You don't have permision to update this package details"); 
        allPackages[packageId].isDelivered = true;
        return "Package successfully marked as delivered";
    }

    // function trackMyAllPackages() public returns(packageDetails[] memory){
    // }

}