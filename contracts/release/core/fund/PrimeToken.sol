
// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "openzeppelin-solc-0.6/token/ERC20/ERC20Burnable.sol";
import "openzeppelin-solc-0.6/math/SafeMath.sol";

contract PrimeToken is ERC20Burnable {
    using SafeMath for uint;

    uint public constant BASE_UNITS = 10 ** 18;
    uint public constant INFLATION_ENABLE_DATE = 1551398400;
    uint public INITIAL_TOTAL_SUPPLY = uint(932613).mul(BASE_UNITS);
    uint public YEARLY_MINTABLE_AMOUNT = uint(300600).mul(BASE_UNITS);
    uint public constant MINTING_INTERVAL = 365 days;

    address public council;
    address public deployer;
    bool public initialSupplyMinted;
    uint public nextMinting = INFLATION_ENABLE_DATE;

    modifier onlyDeployer {
        require(msg.sender == deployer, "Only deployer can call this");
        _;
    }

    modifier onlyCouncil {
        require(msg.sender == council, "Only council can call this");
        _;
    }

    modifier anIntervalHasPassed {
        require(
            block.timestamp >= uint(nextMinting),
            "Please wait until an interval has passed"
        );
        _;
    }

    modifier inflationEnabled {
        require(
            block.timestamp >= INFLATION_ENABLE_DATE,
            "Inflation is not enabled yet"
        );
        _;
    }

    constructor(
        string memory _name,
        string memory _symbol,
        address _council
    ) public ERC20(_name, _symbol) {
        deployer = msg.sender;
        council = _council;
    }

    function changeCouncil(address _newCouncil) public onlyCouncil {
        council = _newCouncil;
    }

    function mintInitialSupply(address _initialReceiver) public onlyDeployer {
        require(!initialSupplyMinted, "Initial minting already complete");
        initialSupplyMinted = true;
        _mint(_initialReceiver, INITIAL_TOTAL_SUPPLY);
    }

    function mintInflation() public anIntervalHasPassed inflationEnabled {
        require(initialSupplyMinted, "Initial minting not complete");
        nextMinting = uint(nextMinting).add(MINTING_INTERVAL);
        _mint(council, YEARLY_MINTABLE_AMOUNT);
    }
}