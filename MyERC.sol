// SPDX-License-Identifier: GPL-3.0


pragma solidity >=0.8.2 <0.9.0;


contract MyERC {
event Transfer(address indexed _from,address indexed _to,uint256 _value);
event Approval(address indexed _owner,address indexed _spender, uint256 _value);

string public name="Mytoken";
string public symbol="MTK";
uint8 public decimals=18;
uint256 public totalsupply;

mapping(address=>uint256) public balanceof;
mapping(address=>mapping(address=>uint256)) public allowance;


constructor(uint256 _initalsupply) {
     totalsupply=_initalsupply *(10 **uint256(decimals));
     balanceof[msg.sender]=totalsupply;
}
    
function Name() public view returns(string) {
   return name;
}
function Symbol() public view returns(string) {
    return symbol;
}
function Decimals() public view returns (uint8) {
    return decimals;
}
function TotalSupply() public view returns (uint256) {
    return totalsupply;
}
function BalanceOf(address _owner) public view returns (uint256 balance) {
    return balanceof[_owner];
}
function Transfer(address _to,uint256 _value) public returns (bool success) {
   require(balanceof[msg.sender]>=_value,"Insufficient Balance");
   balanceof[msg.sender]-=_value;
   balanceof[_to]+=_value;
   emit Transfer(msg.sender, _to, _value);
   return true;

}
function Transferfrom(address _from,address _to,uint256 _value) public returns(bool success) {
   require(balanceof[_from]>=value, "Insufficient Balance");
   require(allowance[_from][msg.sender]>=value,"Allowance Exceeded");
   balanceof[_from]-=-value;
   balanceof[_to]+=value;
   allowance[_from][msg.sender]-=value;
   emit Transfer(_from, _to, _value);
   return true;


}
function Approve(address _reciever,uint256 _value) public returns (bool success) {
   allowance[msg.sender][_reciever]=_value;
   emit Approval(msg.sender, _spender, _value);
   return true;


}


function Allowance(address _owner,address _spender) public view returns (uint256 rem) {
    return allowance[_owner][_spender];
}

}