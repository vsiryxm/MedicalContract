pragma solidity ^0.5.0;

/**
 * @title Medical Contract
 * @dev 公共结构库
 * @author Simon<vsiryxm@163.com>
 */
library Datasets {

    //供方：患者结构
    struct Patient {
        bytes32 SID; //与链下数据关联ID
        bytes32 identity; //患者唯一ID sha256后的哈希值 按系统文档中约定事先申请好的账号
        uint256 balance; //每一次数据被采用分得的积分余额，用户可以自行提取，提取后合约自行扣除
        bool isHuman; //是否活体 true为活体
        bool isActive; //账号是否激活
        bytes32 signature; //用患者的私钥对SID、identity进行签名（或另定），证明是本人操作自己的数据
        bytes32 referrer; //注册来自哪一个APP客户端
        uint256 time; //创建时间
    }

    //供方：患者病历流水数据结构
    struct MedicalRecord {
        bytes32 SID; //与链下数据关联ID
        bytes32 identity; //所属患者
        string illness; //所患疾病，如“高血压”，或疾病编号都可以
        bytes64 params; //患者的病情数据（如血压、血糖等关键数据），哈希后并用患者私钥加密存储，链上不关心数据细节（仅证伪），留给链下系统
        bytes32 doctorSign; //家庭医生签名数据，用医生的私钥将患者的病情数据做一个签名并存储
        uint256 usedTimes; //数据被使用次数
        uint256 totalValue; //总价值，即数据被多次使用后的总积分，分成业务在链下系统中实现，链上不关心分成细节
        uint8 dataWeight; //数据权重，0~100%表示
        uint256 time; //创建时间
    }

    //供方：医院、第三方医疗机构结构
    struct Organization { 
        bytes32 SID; //与链下数据关联ID
        bytes32 identity; //医院唯一ID
        string name; //机构名称
        uint256 balance; //每一次数据被采用分得的积分余额，用户可以自行提取，提取后合约自行扣除
        bytes32 signature; //用医院账号的私钥对SID、identity进行签名，证明是账号管理人
        uint256 time; //创建时间
    }

    //供方：家庭医生结构
    struct Doctor {
        bytes32 identity; //买家唯一ID
        string name; //机构名称
        uint256 balance; //每一次数据被采用分得的积分余额，用户可以自行提取，提取后合约自行扣除
        bytes32 signature; //用买家的私钥对SID、identity进行签名，证明是账号管理人
        uint256 time; //创建时间
    }

    //消费者（如各药厂）设想：通过充值积分来购买数据，买家获取有用数据后，积分扣留在平台，通过链下系统中转到各利益人
    struct Buyer {
        bytes32 identity; //买家唯一ID
        string name; //机构名称
        uint256 balance; //购买所得余额
        bytes32 signature; //用买家的私钥对SID、identity进行签名，证明是账号管理人
        uint256 time; //创建时间
    }

}