// https://github.com/iearn-finance/vaults/blob/master/contracts/vaults/yVault.sol

pragma solidity ^0.6.7;

interface SwapFlashLoan {
    event AddLiquidity(
        address indexed provider,
        uint256[] tokenAmounts,
        uint256[] fees,
        uint256 invariant,
        uint256 lpTokenSupply
    );
    event FlashLoan(address indexed receiver, uint8 tokenIndex, uint256 amount, uint256 amountFee, uint256 protocolFee);
    event NewAdminFee(uint256 newAdminFee);
    event NewSwapFee(uint256 newSwapFee);
    event NewWithdrawFee(uint256 newWithdrawFee);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event Paused(address account);
    event RampA(uint256 oldA, uint256 newA, uint256 initialTime, uint256 futureTime);
    event RemoveLiquidity(address indexed provider, uint256[] tokenAmounts, uint256 lpTokenSupply);
    event RemoveLiquidityImbalance(
        address indexed provider,
        uint256[] tokenAmounts,
        uint256[] fees,
        uint256 invariant,
        uint256 lpTokenSupply
    );
    event RemoveLiquidityOne(
        address indexed provider,
        uint256 lpTokenAmount,
        uint256 lpTokenSupply,
        uint256 boughtId,
        uint256 tokensBought
    );
    event StopRampA(uint256 currentA, uint256 time);
    event TokenSwap(address indexed buyer, uint256 tokensSold, uint256 tokensBought, uint128 soldId, uint128 boughtId);
    event Unpaused(address account);

    function MAX_BPS() external view returns (uint256);

    function addLiquidity(
        uint256[] calldata amounts,
        uint256 minToMint,
        uint256 deadline
    ) external returns (uint256);

    function calculateRemoveLiquidity(uint256 amount) external view returns (uint256[] memory);

    function calculateRemoveLiquidityOneToken(uint256 tokenAmount, uint8 tokenIndex)
        external
        view
        returns (uint256 availableTokenAmount);

    function calculateSwap(
        uint8 tokenIndexFrom,
        uint8 tokenIndexTo,
        uint256 dx
    ) external view returns (uint256);

    function calculateTokenAmount(uint256[] calldata amounts, bool deposit) external view returns (uint256);

    function flashLoan(
        address receiver,
        address token,
        uint256 amount,
        bytes calldata params
    ) external;

    function flashLoanFeeBPS() external view returns (uint256);

    function getA() external view returns (uint256);

    function getAPrecise() external view returns (uint256);

    function getAdminBalance(uint256 index) external view returns (uint256);

    function getToken(uint8 index) external view returns (address);

    function getTokenBalance(uint8 index) external view returns (uint256);

    function getTokenIndex(address tokenAddress) external view returns (uint8);

    function getVirtualPrice() external view returns (uint256);

    function initialize(
        address[] calldata _pooledTokens,
        uint8[] calldata decimals,
        string calldata lpTokenName,
        string calldata lpTokenSymbol,
        uint256 _a,
        uint256 _fee,
        uint256 _adminFee,
        address lpTokenTargetAddress
    ) external;

    function owner() external view returns (address);

    function pause() external;

    function paused() external view returns (bool);

    function protocolFeeShareBPS() external view returns (uint256);

    function rampA(uint256 futureA, uint256 futureTime) external;

    function removeLiquidity(
        uint256 amount,
        uint256[] calldata minAmounts,
        uint256 deadline
    ) external returns (uint256[] memory);

    function removeLiquidityImbalance(
        uint256[] calldata amounts,
        uint256 maxBurnAmount,
        uint256 deadline
    ) external returns (uint256);

    function removeLiquidityOneToken(
        uint256 tokenAmount,
        uint8 tokenIndex,
        uint256 minAmount,
        uint256 deadline
    ) external returns (uint256);

    function renounceOwnership() external;

    function setAdminFee(uint256 newAdminFee) external;

    function setFlashLoanFees(uint256 newFlashLoanFeeBPS, uint256 newProtocolFeeShareBPS) external;

    function setSwapFee(uint256 newSwapFee) external;

    function stopRampA() external;

    function swap(
        uint8 tokenIndexFrom,
        uint8 tokenIndexTo,
        uint256 dx,
        uint256 minDy,
        uint256 deadline
    ) external returns (uint256);

    function swapStorage()
        external
        view
        returns (
            uint256 initialA,
            uint256 futureA,
            uint256 initialATime,
            uint256 futureATime,
            uint256 swapFee,
            uint256 adminFee,
            address lpToken
        );

    function transferOwnership(address newOwner) external;

    function unpause() external;

    function withdrawAdminFees() external;
}
