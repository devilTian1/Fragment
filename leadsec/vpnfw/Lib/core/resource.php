<?php
    /**
     *
     */
    abstract class RESOURCE {
        
        abstract public function isRestartVPN($name);             //VPN是否启用，接口有无被网关隧道、客户端隧道引用
        abstract public function isHaIfEnabled();                 //可绑定设备列表，查询ha_heartbeat中haif_enable的状态
        abstract public function dyProtocol($ptype,$port);        //动态服务显示信息
        abstract public function getName($addrorserv,$stype,$sid);//根据id及type得到资源名称（地址&服务）
        abstract public function openInfoDialog();                //超级链接打开显示引用资源内容
        abstract public function getServList();                   //服务资源列表
        abstract public function getAddrList();                   //地址资源列表（不包含地址池）
        abstract public function getTimeList();                   //时间资源列表
        abstract public function getIfList();                     //流入流出接口资源列表
        abstract public function checkObjectIsUsed($checkArray);  //检查对象是否被引用
        abstract public function getLimitNum($limitname);        //获取模块的规则数限制值
        abstract public function getExistNum($db,$table,$whereinfo);   //获取模块的现有规则数
        abstract public function getAutoSpeedByCli($name);          // 获取网卡类型和speed值
        abstract public function getBandWidth();                   // 带宽检测，返回检测结果和带宽值
        abstract public function getValidMutiroutDevice();       //获取可以配置路由的设备列表
        abstract public function getNetMaskList();               //获取掩码列表
    }
?>
