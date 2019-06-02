pragma solidity ^0.5.0;

import "./interface/TeamInterface.sol"; //导入管理员团队合约接口

/**
 * @title Medical 
 * @dev 家庭医生合约
 * @author Simon<vsiryxm@163.com>
 */
contract Doctor {

    TeamInterface private team; //实例化管理员合约，正式发布时可定义成常量
    mapping(bytes32 => address payable) private doctors; //家庭医生列表 (identity => address)

    constructor(address _teamAddress) public {
        team = TeamInterface(_teamAddress);
    }

    //不接收ETH
    function() external payable {
        revert();
    }

    //事件
    event OnAdd(bytes32 _identity, address indexed _address);
    event OnUpdateAddress(bytes32 _identity, address indexed _address);

    //仅管理员可操作
    modifier onlyAdmin() {
        require(team.isAdmin(msg.sender));
        _;
    }

    //根据家庭医生ID获取钱包地址
    function getAddress(bytes32 _identity) external view returns (address payable) {
        return doctors[_identity];
    }

    //添加家庭医生
    function add(bytes32 _identity, address payable _address) external onlyAdmin() {
        require(this.hasArtist(_identity) == false);
        doctors[_identity] = _address;
        emit OnAdd(_identity, _address);
    }

    //是否存在家庭医生 true为存在
    function hasDoctor(bytes32 _identity) external view returns (bool) {
        return doctors[_artistID] != address(0);
    }

    //更新家庭医生address
    function updateAddress(bytes32 _identity, address payable _address) external onlyAdmin() {
        require(doctors[_identity] != address(0) && _address != address(0));
        doctors[_identity] = _address;
        emit OnUpdateAddress(_identity, _address);
    }

}