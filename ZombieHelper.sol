  pragma solidity >=0.5.0;
  import "./zombieFedding.sol"
 /**
    * The ZombieHelper contract does this and that...
    */
  contract ZombieHelper {
   
   /**  
   @dev cheak whather the user level is grater then or not
   */
   modifier aboveLevel(uint _level , uint _zombieId){
   	require(zombies[_zombieId].level > _level)
   	_;
   }

/**  
@dev will use for changing names
*/
uint leveUpFee =  0.001 ether;
  function changeName(uint _zombieId, string calldata _newName) external aboveLevel(2, _zombieId) ownerof(_zombieId){
    zombies[_zombieId].name = _newName;
  }

  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId)  ownerof(_zombieId){
   
    zombies[_zombieId].dna = _newDna;
  }
 
 function getZombiesByOwner( address _owner) external view returns(uint[] memory){
 uint memory result = new uint[](ownerZombieCount(_owner));
 
   for (uint i = 0; i < zombies.length; i++) {
      if (zombieToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
 return result;
 }
 function leveUp(uint _zombieId) external payable{
   require(msg.value == leveUpFee);
   zombies[_zombieId].level ++;
 }
 function withdraw() external onlyOwner {
    address payable _owner = address(uint160(owner()));
    _owner.transfer(address(this).balance);
  }

  function setLevelUpFee(uint _fee) external onlyOwner {
    levelUpFee = _fee;
  }

  function levelUp(uint _zombieId) external payable {
    require(msg.value == levelUpFee);
    zombies[_zombieId].level++;
  }

   }
  
  
     