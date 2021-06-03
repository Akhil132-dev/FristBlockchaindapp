pragma solidity >=0.5.0 <0.6.0;

import "./feed.sol";


contract ZombieFeeding is ZombieFactory {

/**  
@dev this will trigger for cooldown
*/
 function  _triggerCooldown (Zombie Storage _zombie) internal{
_zombie.readyTime = uint(now+cooldownTime);
 }


modifier onlyOwnerOf(uint _zombId){
  require(msg.sender == zombieToOwner[_zombId]);
  _;
}
/**  
@dev it will cheak that we can feed zombie or not
*/
 function _isReady(Zombie Storage _zombie) internal view returns(bool){
 return (_zombie.readyTime <= now);
 }
 /**  
 @dev it will use to feed the zombies
 */
  function feedAndMultiply(uint _zombieId, uint _targetDna, string memory _species) internal onlyOwnerOf(_zombieId) {
   

    Zombie storage myZombie = zombies[_zombieId];
    require(_isReady(myZombie));
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
      newDna = newDna - newDna % 100 + 99;
    }
    _createZombie("NoName", newDna);
    _triggerCooldown(myZombie);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
 
    feedAndMultiply(_zombieId, _kittyId, "kitty");
  }

}
