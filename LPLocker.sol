pragma solidity ^0.4.13;

contract _ERC20Basic {
  function balanceOf(address _owner) public returns (uint256 balance);
  function transfer(address to, uint256 value) public returns (bool);
}


contract OXBULL_LP_Locker  {
    address owner;

    address tokenPairAddress = 0x14f3578283A3717BAa169CE230a5B085D0c9AD2C; 
    uint256 unlockLPTime = now + 30 days;

    _ERC20Basic token = _ERC20Basic(tokenPairAddress);

    constructor() public {
        owner = msg.sender;
    }

    function unlockLPTokens() public {
        require(owner == msg.sender, "Only owner is allowed");
        require( now > unlockLPTime, "Sorry tokens are still locked.");
        token.transfer(owner, token.balanceOf(address(this)));
    }

    function getLockAmount() public view returns (uint256) {
        return token.balanceOf(address(this));
    }

    function getTokenAddress()  public view returns (address) {
        return tokenPairAddress;
    }

    function getUnlockTimeLeft() public view returns (uint) {
        return unlockLPTime - now;
    }
}
