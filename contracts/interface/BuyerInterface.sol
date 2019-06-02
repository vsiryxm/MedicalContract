pragma solidity ^0.5.0;

/**
 * @title Medical 
 * @dev 买家合约
 * @author Simon<vsiryxm@163.com>
 */
interface BuyerInterface {

    //根据买家ID获取钱包地址
    function getAddress(bytes32 _identity) external view returns (address payable);

    //添加买家
    function add(bytes32 _identity, address _address) external;

    //是否存在买家 true为存在
    function hasBuyer(bytes32 _identity) external view returns (bool);

    //更新买家address
    function updateAddress(bytes32 _identity, address _address) external;

}