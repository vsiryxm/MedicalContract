pragma solidity ^0.5.0;

/**
 * @title Medical 
 * @dev 医院或第三方医疗机构合约
 * @author Simon<vsiryxm@163.com>
 */
interface OrganizationInterface {

    //根据医院或第三方医疗机构ID获取钱包地址
    function getAddress(bytes32 _identity) external view returns (address payable);

    //添加医院或第三方医疗机构
    function add(bytes32 _identity, address _address) external;

    //是否存在医院或第三方医疗机构 true为存在
    function hasOrganization(bytes32 _identity) external view returns (bool);

    //更新医院或第三方医疗机构address
    function updateAddress(bytes32 _identity, address _address) external;

}