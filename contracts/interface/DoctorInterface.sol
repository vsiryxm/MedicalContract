pragma solidity ^0.5.0;

/**
 * @title Medical 
 * @dev 家庭医生合约
 * @author Simon<vsiryxm@163.com>
 */
interface DoctorInterface {

    //根据家庭医生ID获取钱包地址
    function getAddress(bytes32 _identity) external view returns (address payable);

    //添加家庭医生
    function add(bytes32 _identity, address _address) external;

    //是否存在家庭医生 true为存在
    function hasDoctor(bytes32 _identity) external view returns (bool);

    //更新家庭医生address
    function updateAddress(bytes32 _identity, address _address) external;

}