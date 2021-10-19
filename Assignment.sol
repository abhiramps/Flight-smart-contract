pragma solidity >=0.7.0 <0.9.0;

contract Flight{
    
    uint256 id = 0;
    struct Person{
        string name;
        string airline;
        uint256 totalMileage;
        uint256 totalAmount;
    }
    
    address public owner;
    bool eligible;
    
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }
    
    constructor() public{
        owner = msg.sender;
    }
    
    mapping (address => Person) public people;
    
    event Discount(address _user, uint256 _ethi, uint256 _emr);
    
    function newId(string memory _name) public onlyOwner{
        people[msg.sender].name = _name;
    }
    
    function getId() public view returns(string memory){
        return people[msg.sender].name;
    }
    
    function putValues(uint256 _mileage, string memory _airline, uint256 _amount) public onlyOwner{
        /**
         @note
         
        here the mileage is the mileage for a single travel not the total
        here the amount put is the ticket amount
        airline is only ethihad and emrites, test purpose only 
        
        **/
        
        people[msg.sender].totalMileage = people[msg.sender].totalMileage + _mileage;
        
        people[msg.sender].airline = _airline;
        
        people[msg.sender].totalAmount = people[msg.sender].totalAmount + (_mileage + (10 * _amount));
        
        if (people[msg.sender].totalMileage > 1000 &&  people[msg.sender].totalAmount > 20000){
            
            //emiting event for nect time user can get a discount from frontend side(using web3 or js)
            emit Discount(msg.sender, 40, 30);
            eligible = true;
            
            
        }
        
    }    
       
    //just for remix purpose 
    function eligibleforDiscount() public view returns(bool){
        if (eligible == true){
            return true;
        }
    }
    
    
    
}
