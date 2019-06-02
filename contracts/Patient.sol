pragma solidity ^0.5.0;

import "./library/SafeMath.sol"; 
import "./library/Datasets.sol"; 
import "./interface/TeamInterface.sol"; 

/**
 * @title Medical
 * @dev 患者合约
 * @author Simon<vsiryxm@163.com>
 */
contract Patient {

    using SafeMath for *;

    TeamInterface private team; //实例化管理员团队合约，正式发布时可定义成常量
    
    constructor(address _teamAddress) public {
        team = TeamInterface(_teamAddress);
    }

    //不接收ETH
    function() external payable {
        revert();
    }

    //事件
    event OnRegister(
        address indexed _address, 
        bytes32 _unionID, 
        bytes32 _referrer, 
        uint256 time
    );

    //仅开发者、合约地址可操作
    modifier onlyDev() {
        require(team.isDev(msg.sender));
        _;
    }

    mapping(bytes32 => Datasets.Player) private patientsByUnionId; //玩家信息 (unionID => Datasets.Player)
    mapping(address => bytes32) private patientsByAddress; //根据address查询玩家unionID (address => unionID)
    address[] private playerAddressSets; //检索辅助 玩家address集 查询address是否已存在
    bytes32[] private patientsUnionIdSets; //检索辅助 玩家unionID集 查询unionID是否已存在

    mapping(bytes32 => mapping(bytes32 => Datasets.PlayerCount)) playerCount; //玩家购买统计 (unionID => (worksID => Datasets.PlayerCount))
    
    mapping(bytes32 => mapping(bytes32 => Datasets.mydata)) mydata; //我的藏品 (unionID => (worksID => Datasets.mydata))

    //是否存在这个address   address存在则被认为是老用户
    function hasAddress(address _address) external view returns (bool) {
        bool has = false;
        for(uint256 i=0; i<playerAddressSets.length; i++) {
            if(playerAddressSets[i] == _address) {
                has = true;
                break;
            }
        }
        return has;
    }

    //是否存在这个unionID unionID存在则被认为是老用户
    function hasUnionId(bytes32 _unionID) external view returns (bool) {
        bool has = false;
        for(uint256 i=0; i<patientsUnionIdSets.length; i++) {
            if(patientsUnionIdSets[i] == _unionID) {
                has = true;
                break;
            }
        }
        return has;
    }

    //根据unionID查询玩家信息
    function getInfoByUnionId(bytes32 _unionID) external view returns (address payable, bytes32, uint256) {
        return (
            patientsByUnionId[_unionID].lastAddress,
            patientsByUnionId[_unionID].referrer, 
            patientsByUnionId[_unionID].time
        );
    }

    //根据玩家address查询unionID
    function getUnionIdByAddress(address _address) external view returns (bytes32) {
        return patientsByAddress[_address];
    }

    //获取我的医疗数据列表
    function getMyData(bytes32 _unionID, bytes32 _worksID) external view returns (address, bytes32, uint256, uint256, uint256) {
        return (
            mydata[_unionID][_worksID].ethAddress,
            mydata[_unionID][_worksID].worksID,
            mydata[_unionID][_worksID].totalInput,
            mydata[_unionID][_worksID].totalOutput,
            mydata[_unionID][_worksID].time
        );
    }

    //是否为合法绑定关系的患者 避免address被多个unionID绑定 true为合法
    function isLegalPatient(bytes32 _unionID, address _address) external view returns (bool) {
        return (this.hasUnionId(_unionID) || this.hasAddress(_address)) && patientsByAddress[_address] == _unionID;
    }

    //注册患者
    function register(bytes32 _unionID, address payable _address, bytes32 _worksID, bytes32 _referrer) external onlyDev() returns (bool) {
        require(_unionID != bytes32(0) && _address != address(0) && _worksID != bytes32(0));

        //检查address和unionID是否为合法绑定关系 避免address被多个unionID绑定
        if(this.hasAddress(_address)) {
            if(patientsByAddress[_address] != _unionID) {
                revert();
            } else {
                return true;
            }
        }
         
        patientsByUnionId[_unionID].ethAddress.push(_address);
        if(_referrer != bytes32(0)) {
            patientsByUnionId[_unionID].referrer = _referrer;
        }
        patientsByUnionId[_unionID].lastAddress = _address;
        patientsByUnionId[_unionID].time = now;

        patientsByAddress[_address] = _unionID;

        playerAddressSets.push(_address);
        
        if(this.hasUnionId(_unionID) == false) {
            patientsUnionIdSets.push(_unionID);
            playerCount[_unionID][_worksID] = Datasets.PlayerCount(0, 0, 0, 0, 0); //初始化玩家单元统计数据
        }
        
        emit OnRegister(_address, _unionID, _referrer, now);

        return true;
    }

    
}