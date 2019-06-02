pragma solidity ^0.5.0;

/**
 * @title Medical 
 * @dev 患者合约
 * @author Simon<vsiryxm@163.com>
 */
interface PatientInterface {

    //根据患者ID获取钱包地址
    function getAddress(bytes32 _identity) external view returns (address payable);

    //添加患者
    function add(bytes32 _identity, address _address) external;

    //是否存在患者 true为存在
    function hasPatient(bytes32 _identity) external view returns (bool);

    //更新患者address
    function updateAddress(bytes32 _identity, address _address) external;

}