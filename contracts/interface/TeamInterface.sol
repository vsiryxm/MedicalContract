pragma solidity ^0.5.0;

/**
 * @title Medical
 * @dev 管理员团队合约接口
 * @author Simon<vsiryxm@163.com>
 */
interface TeamInterface {

    //添加、更新管理员成员
    function addAdmin(address _address, bool _isAdmin, bool _isDev, bytes32 _name) external;

    //删除管理员成员
    function removeAdmin(address _address) external;

    //是否为超管
    function isOwner() external view returns (bool);

    //是否为管理员
    function isAdmin(address _sender) external view returns (bool);

    //是否为开发者、合约地址
    function isDev(address _sender) external view returns (bool);

}

