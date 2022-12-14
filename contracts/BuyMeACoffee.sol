//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

    // Deployed to Goerli at 0xe64Ae59a3c567860525f28b037B28e084C66d068

contract BuyMeACoffee {
    // Event to emit when a Memo is created
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
);
    // Memo struct

    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    //List of all memos received from frens
    Memo[] memos;

    // Address of contract deployer
    address payable owner;

    // Deploy logic d
    constructor(){
        owner = payable(msg.sender);

    }

    /**
     * @dev buy a coffee for contract owner
     * @param _name name of the coffee buyer
     * @param _message a nice message for the coffee buyer
     */

    function buyCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "can't buy a shid with 0 eth");

        // Add the memo to storage
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));
    }

      function buyLargeCoffee(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "can't buy a shid with 0 eth");

        // Add the memo to storage
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));   

        // Emit a log event when a new memo is created
        emit NewMemo(
               msg.sender,
            block.timestamp,
            _name,
            _message
        );


    }


    /**
     * @dev send the entire balance stored in this contract to the owner
     */
    function withdrawTips() public {
        require(owner.send(address(this).balance));

        
    }
    //change address for withdrawal
    function transferOwnership(address payable _newOwner) public{
      require(msg.sender == owner, "Only the owner can transfer the tips");
      require(_newOwner.send(address(this).balance));
    }
    /**
     * @dev retrieve all the memos received and stored on the blockchain
     */
    function getMemos() public view returns(Memo[] memory) {
        return memos;        
    }

}