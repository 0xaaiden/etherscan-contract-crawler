/**
 *Submitted for verification at Etherscan.io on 2018-02-24
*/

pragma solidity ^0.4.18;

library SafeMath {

  /**
  * @dev Multiplies two numbers, throws on overflow.
  */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }

  /**
  * @dev Integer division of two numbers, truncating the quotient.
  */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

  /**
  * @dev Substracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
  */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  /**
  * @dev Adds two numbers, throws on overflow.
  */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}

contract ERC721 {
  // Required methods
  function approve(address _to, uint256 _tokenId) public;
  function balanceOf(address _owner) public view returns (uint256 balance);
  function implementsERC721() public pure returns (bool);
  function ownerOf(uint256 _tokenId) public view returns (address addr);
  function takeOwnership(uint256 _tokenId) public;
  function totalSupply() public view returns (uint256 total);
  function transferFrom(address _from, address _to, uint256 _tokenId) public;
  function transfer(address _to, uint256 _tokenId) public;

  event Transfer(address indexed from, address indexed to, uint256 tokenId);
  event Approval(address indexed owner, address indexed approved, uint256 tokenId);

  // Optional
  // function name() public view returns (string name);
  // function symbol() public view returns (string symbol);
  // function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256 tokenId);
  // function tokenMetadata(uint256 _tokenId) public view returns (string infoUrl);
}

contract CryptoNFT is ERC721 {

  /*** EVENTS ***/

  /// @dev The Birth event is fired whenever a new person comes into existence.
  event Birth(uint256 tokenId, string name, address owner);

  /// @dev The TokenSold event is fired whenever a token is sold.
  event TokenSold(uint256 tokenId, uint256 oldPrice, uint256 newPrice, address prevOwner, address winner, string name);

  /// @dev Transfer event as defined in current draft of ERC721. 
  ///  ownership is assigned, including births.
  event Transfer(address from, address to, uint256 tokenId);

  /*** CONSTANTS ***/
  uint256 internal startingPrice = 0.01 ether;

  // uint256 internal toPlayerMultiplier = uint256(0.94);
  /*** STORAGE ***/

  /// @dev A mapping from person IDs to the address that owns them. All persons have
  ///  some valid owner address.
  mapping (uint256 => address) public personIndexToOwner;

  // @dev A mapping from owner address to count of tokens that address owns.
  //  Used internally inside balanceOf() to resolve ownership count.
  mapping (address => uint256) private ownershipTokenCount;

  /// @dev A mapping from PersonIDs to an address that has been approved to call
  ///  transferFrom(). Each Person can only have one approved address for transfer
  ///  at any time. A zero value means no approval is outstanding.
  mapping (uint256 => address) public personIndexToApproved;

  // @dev A mapping from PersonIDs to the price of the token.
  mapping (uint256 => uint256) internal personIndexToPrice;

  // The addresses of the accounts (or contracts) that can execute actions within each roles.
  address public ceoAddress;
  address public cooAddress;

  /*** DATATYPES ***/
  struct Person {
    string name;
  }

  Person[] private persons;

  /*** ACCESS MODIFIERS ***/
  /// @dev Access modifier for CEO-only functionality
  modifier onlyCEO() {
    require(msg.sender == ceoAddress);
    _;
  }

  /// @dev Access modifier for COO-only functionality
  modifier onlyCOO() {
    require(msg.sender == cooAddress);
    _;
  }

  /// Access modifier for contract owner only functionality
  modifier onlyCLevel() {
    require(
      msg.sender == ceoAddress ||
      msg.sender == cooAddress
    );
    _;
  }

  /*** CONSTRUCTOR ***/
  function CryptoNFT() public {
    ceoAddress = msg.sender;
    cooAddress = msg.sender;
  }

  /*** PUBLIC FUNCTIONS ***/
  /// @notice Grant another address the right to transfer token via takeOwnership() and transferFrom().
  /// @param _to The address to be granted transfer approval. Pass address(0) to
  ///  clear all approvals.
  /// @param _tokenId The ID of the Token that can be transferred if this call succeeds.
  /// @dev Required for ERC-721 compliance.
  function approve(
    address _to,
    uint256 _tokenId
  ) public {
    // Caller must own token.
    require(_owns(msg.sender, _tokenId));

    personIndexToApproved[_tokenId] = _to;

    Approval(msg.sender, _to, _tokenId);
  }

  /// For querying balance of a particular account
  /// @param _owner The address for balance query
  /// @dev Required for ERC-721 compliance.
  function balanceOf(address _owner) public view returns (uint256 balance) {
    return ownershipTokenCount[_owner];
  }

  

  /// @dev Creates a new Person with the given name.
  function createContractPerson(string _name) public onlyCOO {
    _createPerson(_name, address(this), startingPrice);
  }

  /// @notice Returns all the relevant information about a specific person.
  /// @param _tokenId The tokenId of the person of interest.
  function getPerson(uint256 _tokenId) public view returns (
    string personName,
    uint256 sellingPrice,
    address owner
  ) {
    Person storage person = persons[_tokenId];
    personName = person.name;
    sellingPrice = personIndexToPrice[_tokenId];
    owner = personIndexToOwner[_tokenId];
  }

  function implementsERC721() public pure returns (bool) {
    return true;
  }


  /// For querying owner of token
  /// @param _tokenId The tokenID for owner inquiry
  /// @dev Required for ERC-721 compliance.
  function ownerOf(uint256 _tokenId)
    public
    view
    returns (address owner)
  {
    owner = personIndexToOwner[_tokenId];
    require(owner != address(0));
  }

  function payout(address _to) public onlyCEO {
    _payout(_to, this.balance);
  }

  // Allows someone to send ether and obtain the token
  function purchase(uint256 _tokenId) public payable {
    address oldOwner = personIndexToOwner[_tokenId];
    address newOwner = msg.sender;

    uint256 sellingPrice = personIndexToPrice[_tokenId];

    // Making sure token owner is not sending to self
    require(oldOwner != newOwner);

    // Safety check to prevent against an unexpected 0x0 default.
    require(_addressNotNull(newOwner));

    // Making sure sent amount is greater than or equal to the sellingPrice
    require(msg.value >= sellingPrice);

    uint256 payment = calcPaymentToOldOwner(sellingPrice);
    uint256 purchaseExcess = SafeMath.sub(msg.value, sellingPrice);

    // Update prices
    personIndexToPrice[_tokenId] = calcNextSellingPrice(sellingPrice);

    _transfer(oldOwner, newOwner, _tokenId);

    // Pay previous tokenOwner if owner is not contract
    if (oldOwner != address(this)) {
      oldOwner.transfer(payment); //(1-0.06)
    }

    TokenSold(_tokenId, sellingPrice, personIndexToPrice[_tokenId], oldOwner, newOwner, persons[_tokenId].name);

    msg.sender.transfer(purchaseExcess);
  }

  function calcPaymentToOldOwner(uint256 sellingPrice) internal returns (uint256 payToOldOwner);
  function calcNextSellingPrice(uint256 currentSellingPrice) internal returns (uint256 newSellingPrice);

  function priceOf(uint256 _tokenId) public view returns (uint256 price) {
    return personIndexToPrice[_tokenId];
  }

  /// @dev Assigns a new address to act as the CEO. Only available to the current CEO.
  /// @param _newCEO The address of the new CEO
  function setCEO(address _newCEO) public onlyCEO {
    require(_newCEO != address(0));

    ceoAddress = _newCEO;
  }

  /// @dev Assigns a new address to act as the COO. Only available to the current COO.
  /// @param _newCOO The address of the new COO
  function setCOO(address _newCOO) public onlyCEO {
    require(_newCOO != address(0));

    cooAddress = _newCOO;
  }

  /// @notice Allow pre-approved user to take ownership of a token
  /// @param _tokenId The ID of the Token that can be transferred if this call succeeds.
  /// @dev Required for ERC-721 compliance.
  function takeOwnership(uint256 _tokenId) public {
    address newOwner = msg.sender;
    address oldOwner = personIndexToOwner[_tokenId];

    // Safety check to prevent against an unexpected 0x0 default.
    require(_addressNotNull(newOwner));

    // Making sure transfer is approved
    require(_approved(newOwner, _tokenId));

    _transfer(oldOwner, newOwner, _tokenId);
  }

  /// @param _owner The owner whose celebrity tokens we are interested in.
  /// @dev This method MUST NEVER be called by smart contract code. First, it's fairly
  ///  expensive (it walks the entire Persons array looking for persons belonging to owner),
  ///  but it also returns a dynamic array, which is only supported for web3 calls, and
  ///  not contract-to-contract calls.
  function tokensOfOwner(address _owner) public view returns(uint256[] ownerTokens) {
    uint256 tokenCount = balanceOf(_owner);
    if (tokenCount == 0) {
        // Return an empty array
      return new uint256[](0);
    } else {
      uint256[] memory result = new uint256[](tokenCount);
      uint256 totalPersons = totalSupply();
      uint256 resultIndex = 0;

      uint256 personId;
      for (personId = 0; personId <= totalPersons; personId++) {
        if (personIndexToOwner[personId] == _owner) {
          result[resultIndex] = personId;
          resultIndex++;
        }
      }
      return result;
    }
  }

  /// For querying totalSupply of token
  /// @dev Required for ERC-721 compliance.
  function totalSupply() public view returns (uint256 total) {
    return persons.length;
  }

  /// Owner initates the transfer of the token to another account
  /// @param _to The address for the token to be transferred to.
  /// @param _tokenId The ID of the Token that can be transferred if this call succeeds.
  /// @dev Required for ERC-721 compliance.
  function transfer(
    address _to,
    uint256 _tokenId
  ) public {
    require(_owns(msg.sender, _tokenId));
    require(_addressNotNull(_to));

    _transfer(msg.sender, _to, _tokenId);
  }

  /// Third-party initiates transfer of token from address _from to address _to
  /// @param _from The address for the token to be transferred from.
  /// @param _to The address for the token to be transferred to.
  /// @param _tokenId The ID of the Token that can be transferred if this call succeeds.
  /// @dev Required for ERC-721 compliance.
  function transferFrom(
    address _from,
    address _to,
    uint256 _tokenId
  ) public {
    require(_owns(_from, _tokenId));
    require(_approved(_to, _tokenId));
    require(_addressNotNull(_to));

    _transfer(_from, _to, _tokenId);
  }

  /*** PRIVATE FUNCTIONS ***/
  /// Safety check on _to address to prevent against an unexpected 0x0 default.
  function _addressNotNull(address _to) private pure returns (bool) {
    return _to != address(0);
  }

  /// For checking approval of transfer for address _to
  function _approved(address _to, uint256 _tokenId) private view returns (bool) {
    return personIndexToApproved[_tokenId] == _to;
  }

  /// For creating Person
  function _createPerson(string _name, address _owner, uint256 _price) internal {
    Person memory _person = Person({
      name: _name
    });
    uint256 newPersonId = persons.push(_person) - 1;

    // It's probably never going to happen, 4 billion tokens are A LOT, but
    // let's just be 100% sure we never let this happen.
    require(newPersonId == uint256(uint32(newPersonId)));

    Birth(newPersonId, _name, _owner);

    personIndexToPrice[newPersonId] = _price;

    // This will assign ownership, and also emit the Transfer event as
    // per ERC721 draft
    _transfer(address(0), _owner, newPersonId);
  }

  /// Check for token ownership
  function _owns(address claimant, uint256 _tokenId) internal view returns (bool) {
    return claimant == personIndexToOwner[_tokenId];
  }

  /// For paying out balance on contract
  function _payout(address _to, uint256 amount) internal {
    require(amount<=this.balance);
    if (_to == address(0)) {
      ceoAddress.transfer(amount);
    } else {
      _to.transfer(amount);
    }
  }

  /// @dev Assigns ownership of a specific Person to an address.
  function _transfer(address _from, address _to, uint256 _tokenId) private {
    // Since the number of persons is capped to 2^32 we can't overflow this
    ownershipTokenCount[_to]++;
    //transfer ownership
    personIndexToOwner[_tokenId] = _to;

    // When creating new persons _from is 0x0, but we can't account that address.
    if (_from != address(0)) {
      ownershipTokenCount[_from]--;
      // clear any previously approved ownership exchange
      delete personIndexToApproved[_tokenId];
    }

    // Emit the transfer event.
    Transfer(_from, _to, _tokenId);
  }
}

contract EtherAthlete is CryptoNFT {
    /// @notice Name and symbol of the non fungible token, as defined in ERC721.
    string public constant NAME = "EtherAthlete"; // solhint-disable-line
    string public constant SYMBOL = "EAT"; // solhint-disable-line

    uint256 private constant PROMO_CREATION_LIMIT = 5000;
    uint256 public promoCreatedCount;

    bool public allowPriceUpdate;

    /*** CONSTANTS ***/
    uint256 private firstStepLimit =  0.32 ether;
    uint256 private secondStepLimit = 2.8629151 ether;

    uint256 private defaultIncreasePercent = 200;
    uint256 private fsIncreasePercent = 155;
    uint256 private ssIncreasePercent = 130;

    uint256 private defaultPlayerPercent = 7500;
    uint256 private fsPlayerPercent = 8400;
    uint256 private ssPlayerPercent = 9077;

    // The addresses of the charity account.
    address public charityAddress;
    uint256 private charityPercent = 3;
    uint256 public charityBalance;


    /*** CONSTRUCTOR ***/
    function EtherAthlete() public {
        allowPriceUpdate = false;
        charityAddress = msg.sender;
        charityBalance = 0 ether;
    }
    
    /*** PUBLIC FUNCTIONS ***/

    /// @dev Required for ERC-721 compliance.
    function name() public pure returns (string) {
        return NAME;
    }
    /// @dev Required for ERC-721 compliance.
    function symbol() public pure returns (string) {
        return SYMBOL;
    }

    /// @dev Creates a new promo Person with the given name, with given _price and assignes it to an address.
    function createPromoPerson(address _owner, string _name, uint256 _price) public onlyCOO {
        require(promoCreatedCount < PROMO_CREATION_LIMIT);

        address personOwner = _owner;
        if (personOwner == address(0)) {
        personOwner = cooAddress;
        }

        if (_price <= 0) {
        _price = startingPrice;
        }

        promoCreatedCount++;
        _createPerson(_name, personOwner, _price);
    }

    function setAllowPriceUpdate(bool _bValue) public onlyCOO {
        allowPriceUpdate = _bValue;
    }

    /*** PRIVATE FUNCTIONS ***/
    /// Overrides Abstract internal method to calculate payment proportion for old owner
    /// out of selling price in current purchase
    function calcPaymentToOldOwner(uint256 sellingPrice) internal returns (uint256 payToOldOwner) {
        if (sellingPrice <= firstStepLimit) {
            // first stage
            payToOldOwner = uint256(SafeMath.div(SafeMath.mul(sellingPrice, defaultPlayerPercent),10000));
        } else if (sellingPrice <= secondStepLimit) {
            // second stage
            payToOldOwner = uint256(SafeMath.div(SafeMath.mul(sellingPrice, fsPlayerPercent),10000));
        } else {
            // third stage
            payToOldOwner = uint256(SafeMath.div(SafeMath.mul(sellingPrice, ssPlayerPercent),10000));
        }

        // Update the charity balance
        uint256 gainToHouse = SafeMath.sub(sellingPrice, payToOldOwner);
        charityBalance = SafeMath.add(charityBalance, SafeMath.div(SafeMath.mul(gainToHouse, charityPercent),100));
    }

    /// Overrides the abstract method to calculate the next selling price based on
    /// current selling prices of the asset.
    function calcNextSellingPrice(uint256 currentSellingPrice) internal returns (uint256 newSellingPrice) {
        if (currentSellingPrice < firstStepLimit) {
            // first stage
            newSellingPrice = SafeMath.div(SafeMath.mul(currentSellingPrice, defaultIncreasePercent), 100);
        } else if (currentSellingPrice < secondStepLimit) {
            // second stage
            newSellingPrice = SafeMath.div(SafeMath.mul(currentSellingPrice, fsIncreasePercent), 100);
        } else {
            // third stage
            newSellingPrice = SafeMath.div(SafeMath.mul(currentSellingPrice, ssIncreasePercent), 100);
        }
    }

    function setCharityAddress(address _charityAddress) public onlyCEO {
        charityAddress = _charityAddress;
    }

    function payout(address _to) public onlyCEO {
        uint256 amountToCharity = charityBalance;
        uint256 amount = SafeMath.sub(this.balance, charityBalance);
        charityBalance = 0;
        _payout(charityAddress, amountToCharity);
        _payout(_to, amount);
    }

    function updateTokenSellingPrice(uint256 _tokenId, uint256 sellingPrice) public {
        require(allowPriceUpdate);
        require(_owns(msg.sender, _tokenId));
        require(sellingPrice < personIndexToPrice[_tokenId]);
        require(sellingPrice >= startingPrice);
        personIndexToPrice[_tokenId] = sellingPrice;
    }
}