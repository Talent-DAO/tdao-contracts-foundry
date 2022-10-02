// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

// todo: setup remappings for these
// import "./interfaces/ITDAOToken.sol";
// import "./interfaces/IVETDAOToken.sol";

contract ContractTest is Test, Ownable, AccessControl {
    function setUp() public {}

    uint256 public TALENT_PER_BLOCK = 2 ether;
    uint256 public startBlock;
    uint256 public bonusEndBlock;

    bytes32 public constant DAO_ROLE = keccak256("DAO_ROLE");
    bytes32 public constant OPERATOR_ROLE = keccak256("OPERATOR_ROLE");

    event UpdateEmissionRate(address indexed sender, uint256 talentPerBlock);

    constructor (
        uint256 _startBlock,
        uint256 _bonusEndBlock,
        address _talentToken,
        address _veTalentToken
    )
    {
        startBlock = _startBlock;
        bonusEndBlock = _bonusEndBlock;
        // talentToken = ITDAOToken(_talentToken);
        // veTalentToken = IVETDAOToken(_veTalentToken);

        // ** add the talent/veTalent stake pool with 100 allocation,
        // this will be the only pool even though we have
        // the ability to add more. Who knows, the future is bright :)
        // addStakePool(10, _talentToken);

        _setupRole(OPERATOR_ROLE, msg.sender);
        _setupRole(DAO_ROLE, msg.sender);
        // transferOwnership(0x3f15B8c6F9939879Cb030D6dd935348E57109637);
    }

    function testExample() public {
        assertTrue(true);
    }

    function testUpdateEmissionRate(uint256 _talentPerBlock)
        public
        onlyOwner
    {
        require(hasRole(DAO_ROLE, msg.sender), "talentStakePool :: not in the DAO role, sorry...");
        TALENT_PER_BLOCK = _talentPerBlock;
        emit UpdateEmissionRate(msg.sender, _talentPerBlock);
    }
}
