pragma solidity ^0.5.0;

import "./interface/TeamInterface.sol"; //导入管理员团队合约接口

/**
 * @title Medical 
 * @dev 买家合约
 * @author Simon<vsiryxm@163.com>
 */
contract Buyer {

    TeamInterface private team; //实例化管理员合约，正式发布时可定义成常量
    mapping(bytes32 => address payable) private buyers; //患者列表 (identity => address)

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

    //根据买家ID获取钱包地址
    function getAddress(bytes32 _identity) external view returns (address payable) {
        return buyer[_identity];
    }

    //添加买家
    function add(bytes32 _identity, address payable _address) external onlyAdmin() {
        require(this.hasArtist(_identity) == false);
        buyers[_identity] = _address;
        emit OnAdd(_identity, _address);
    }

    //是否存在买家 true为存在
    function hasBuyer(bytes32 _identity) external view returns (bool) {
        return buyers[_artistID] != address(0);
    }

    //更新买家address
    function updateAddress(bytes32 _identity, address payable _address) external onlyAdmin() {
        require(buyers[_identity] != address(0) && _address != address(0));
        buyers[_identity] = _address;
        emit OnUpdateAddress(_identity, _address);
    }

}