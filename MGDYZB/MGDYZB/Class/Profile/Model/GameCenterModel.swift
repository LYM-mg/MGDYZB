//
//  GameCenterModel.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/2/27.
//  Copyright © 2017年 ming. All rights reserved.
//

import UIKit

class GameCenterModel: NSObject {
    var allowIp : String!
    var callBackUrl : String!
    var clickType : String!
    var ctime : String!
    var depict : String!
    var down_ios_url : String!
    var endTime : String!
    var getDepict : String!
    var giftIcon : String!
    var gold : String!
    var icon : String!
    var iconSmall : String!
    var id : String!
    var iosId : String!
    var ruleType : String!
    var show_count : NSNumber! {
        didSet {
            show_count = Int(Int(show_count)/10000) as NSNumber!
        }
    }
    var silver : String!
    var sort : String!
    var startTime : String!
    var status : String!
    var taskDesc : String!
    var taskRuleModels : [TaskRuleModel]!
    var taskRule: [[String : NSObject]]? {
        didSet {
            guard let taskRule = taskRule else { return }
            for dict in taskRule {
                taskRuleModels.append(TaskRuleModel(dict: dict))
            }
        }
    }

    var title : String!
    var data : [Data]!
    var downList : [AnyObject]! // 这个是下载列表
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
    
//    "data": [
//    {
//    "id": "18",
//    "title": "全民神将",
//    "ios_id": "1007891923",
//    "allow_ip": "42.62.96.72",
//    "click_type": "0",
//    "down_ios_url": "https://itunes.apple.com/cn/app/chui-zi-san-guo-50ren-tong/id1007891923?l=zh&ls=1&mt=8",
//    "call_back_url": "http://v0.crab.xoyo.com/collector/work/v1/e96479dc/server",
//    "gift_icon": "585e89bbe15ab36454a0d18d14d2ebb6.png",
//    "icon": "68777219db88e8c132e7f51cf554184f.jpg",
//    "icon_small": "843759872552df94a533e65b29a7bc63.png",
//    "start_time": "1487088000",
//    "end_time": "1518624000",
//    "depict": "打造五星上将，领6千鱼丸送鱼翅",
//    "get_depict": "打造五星上将，领6千鱼丸送鱼翅",
//    "task_desc": "1、\t本次活动只针对2017年2月22日12：00-2017年2月28日23：59，从斗鱼iOS端的手游任务及游戏中心点击下载全民神将的新用户（以设备为新增判断依据，一台设备只能参与一次活动哦）\n2、\t打开最新斗鱼iOS app，从手游任务及游戏中心点击下载全民神将\n3、\t下载成功后，注册创角送500鱼丸，练至6级送1000鱼丸，练至10级送\n1500鱼丸，练至20级送3000鱼丸，首充6元送6鱼翅。\n4、\t鱼丸鱼翅赠送为厂家直送，任务完成后鱼丸鱼翅奖励会直接发送到用户参与任务时登录的斗鱼账号中，如无收到奖励请通过以下方式联系客服。客服联系方式：QQ：3560314594\n5、\t如果开启隐私-广告中限制广告跟踪，将无法参与此次活动，请您在参与活动之前务必检查手机的设置。",
//    "task_rule": [
//    {
//    "level": "1",
//    "name": "注册创角送500鱼丸",
//    "silver": "500",
//    "gold": "0"
//    },
//    {
//    "level": "2",
//    "name": "练至6级送1000鱼丸",
//    "silver": "1000",
//    "gold": "0"
//    },
//    {
//    "level": "3",
//    "name": "练至10级送1500鱼丸",
//    "silver": "1500",
//    "gold": "0"
//    },
//    {
//    "level": "4",
//    "name": "练至20级送3000鱼丸",
//    "silver": "3000",
//    "gold": "0"
//    },
//    {
//    "level": "5",
//    "name": "首充6元送6鱼翅",
//    "silver": "0",
//    "gold": "6"
//    }
//    ],
//    "silver": "6000",
//    "gold": "6",
//    "show_count": 200000,
//    "sort": "21",
//    "rule_type": "2",
//    "status": "0",
//    "ctime": "1441532656"
//    },
//    {
//    "id": "140",
//    "title": "仙境传说RO：守护永恒的爱",
//    "ios_id": "1071801856",
//    "allow_ip": "115.182.66.93,60.205.218.117,59.110.168.138",
//    "click_type": "0",
//    "down_ios_url": "https://itunes.apple.com/cn/app/xian-jing-chuan-shuoro-shou/id1071801856?l=zh&ls=1&mt=8",
//    "call_back_url": "https://l.tapdb.net/X61NRhHE",
//    "gift_icon": "d1dc790b14292744309abf4e01cfc90f.png",
//    "icon": "3d9d3d498e1031f0861cb155e0fe32f8.jpg",
//    "icon_small": "16d99583b82e279915fc4f2cc0f17715.png",
//    "start_time": "1485014400",
//    "end_time": "1519056000",
//    "depict": "自由冒险不氪金，欢送8千鱼丸！",
//    "get_depict": "自由冒险不氪金，欢送8千鱼丸！",
//    "task_desc": "1、打开最新斗鱼ios app，从我的-精彩推荐选项卡点击下载仙境传说RO：守护永恒的爱 \n2、下载成功后，注册创角送1000鱼丸，练至12级送2000鱼丸，练至25级送5000鱼丸\n3、返回任务大厅领取奖励 （注：如任务无法完成，请检查隐私-广告中限制广告跟踪是否被关闭，如果没有关闭，请关闭后重新从斗鱼APP中下载应用）",
//    "task_rule": [
//    {
//    "level": "1",
//    "name": "注册创角送1000鱼丸",
//    "silver": "1000",
//    "gold": "0"
//    },
//    {
//    "level": "2",
//    "name": "练至12级送2000鱼丸",
//    "silver": "2000",
//    "gold": "0"
//    },
//    {
//    "level": "3",
//    "name": "练至25级送5000鱼丸",
//    "silver": "5000",
//    "gold": "0"
//    }
//    ],
//    "silver": "8000",
//    "gold": "0",
//    "show_count": 390000,
//    "sort": "20",
//    "rule_type": "1",
//    "status": "0",
//    "ctime": "1484983219"
//    },
//    {
//    "id": "30",
//    "title": "横扫千军",
//    "ios_id": "997636530",
//    "allow_ip": "115.182.66.93,60.205.218.117,59.110.168.138",
//    "click_type": "0",
//    "down_ios_url": "https://itunes.apple.com/app/apple-store/id997636530?pt=103356814&ct=douyu&mt=8",
//    "call_back_url": "https://l.tapdb.net/1/qqJ27bbP",
//    "gift_icon": "7dc8da0eb118159c50a84c0eaa60b9be.png",
//    "icon": "59fb07e31735b6cd06e39621406f31c5.jpg",
//    "icon_small": "594aa8d471a3e70baa2eb2e454f7cea7.png",
//    "start_time": "1485878400",
//    "end_time": "1514649600",
//    "depict": "6千鱼丸粮草到！玩策略拼智商！",
//    "get_depict": "6千鱼丸粮草到！玩策略拼智商！",
//    "task_desc": "1、打开最新斗鱼ios app，从我的-精彩推荐选项卡点击下载横扫千军\n2、下载成功后，下载创角赠送1000鱼丸，达到15级赠送2000鱼丸，达到25级赠送3000鱼丸\n3、返回任务大厅领取奖励\n（注：如任务无法完成，请检查隐私-广告中限制广告跟踪是否被关闭，如果没有关闭，请关闭后重新从斗鱼APP中下载应用）",
//    "task_rule": [
//    {
//    "level": "1",
//    "name": "下载创角赠送1000鱼丸",
//    "silver": "1000",
//    "gold": "0"
//    },
//    {
//    "level": "2",
//    "name": "达到15级赠送2000鱼丸",
//    "silver": "2000",
//    "gold": "0"
//    },
//    {
//    "level": "3",
//    "name": "达到25级赠送3000鱼丸",
//    "silver": "3000",
//    "gold": "0"
//    }
//    ],
//    "silver": "6000",
//    "gold": "0",
//    "show_count": 300000,
//    "sort": "19",
//    "rule_type": "1",
//    "status": "0",
//    "ctime": "1446084316"
//    },
//    {
//    "id": "131",
//    "title": "狂暴之翼",
//    "ios_id": "1112060888",
//    "allow_ip": "122.226.73.100,23.105.202.231",
//    "click_type": "0",
//    "down_ios_url": "https://itunes.apple.com/cn/app/kuang-bao-zhi-yi-3d-xuan-zhanarpg/id1112060888?l=zh",
//    "call_back_url": "https://vdam.youzu.com/?q=5899a67c62913&amp;idfa={idfa}",
//    "gift_icon": "151d617b8d509474a48a47472f0ab6fe.png",
//    "icon": "6b3c1e45ee19d653d90ad06340accbfd.jpg",
//    "icon_small": "e9ac3c40c7eea7821ef6d84864575dc3.jpg",
//    "start_time": "1486569600",
//    "end_time": "1488211200",
//    "depict": "练至6级赠送1千鱼丸",
//    "get_depict": "练至6级赠送1千鱼丸",
//    "task_desc": "1、打开最新斗鱼ios app，从我的-精彩推荐选项卡点击下载狂暴之翼 \n2、下载成功后，练至6级赠送1000鱼丸 \n3、返回任务大厅领取奖励 （注：如任务无法完成，请检查隐私-广告中限制广告跟踪是否被关闭，如果没有关闭，请关闭后重新从斗鱼APP中下载应用）",
//    "task_rule": [
//    {
//    "level": "1",
//    "name": "练至6级赠送1000鱼丸",
//    "silver": "1000",
//    "gold": "0"
//    }
//    ],
//    "silver": "1000",
//    "gold": "0",
//    "show_count": 150000,
//    "sort": "18",
//    "rule_type": "1",
//    "status": "0",
//    "ctime": "1482401770"
//    },
//    {
//    "id": "80",
//    "title": "王国纪元",
//    "ios_id": "491763",
//    "allow_ip": "52.76.125.183,52.76.134.156",
//    "click_type": "0",
//    "down_ios_url": "https://itunes.apple.com/US/app/id1071976327?mt=8",
//    "call_back_url": "https://tracking.lenzmx.com/async_click?mb_pl=ios&amp;mb_nt=cb10768&amp;mb_campid=lm_cn_ios&amp;mb_auth=9F5jGOO94jUgu2AJ",
//    "gift_icon": "feb9b67d2e86cbe9f7ca9ac8bfc46c95.png",
//    "icon": "5b93e08b27c5f2bdff0cc79b921ff4a9.jpg",
//    "icon_small": "7620fe74a818fd06cfc0f5268a6c5bb4.jpg",
//    "start_time": "1487260800",
//    "end_time": "1488211200",
//    "depict": "王国纪元骑士精神再现",
//    "get_depict": "王国纪元骑士精神再现",
//    "task_desc": "1、打开最新斗鱼ios app，从我的-精彩推荐选项卡点击下载王国纪元 \n2、下载成功后，不参加鱼丸奖励 \n3、返回任务大厅领取奖励 （注：如任务无法完成，请检查隐私-广告中限制广告跟踪是否被关闭，如果没有关闭，请关闭后重新从斗鱼APP中下载应用）",
//    "task_rule": [
//    {
//    "level": "1",
//    "name": "不参加鱼丸奖励",
//    "silver": "0",
//    "gold": "0"
//    }
//    ],
//    "silver": "0",
//    "gold": "0",
//    "show_count": 80000,
//    "sort": "17",
//    "rule_type": "1",
//    "status": "0",
//    "ctime": "1464078554"
//    },
//    {
//    "id": "151",
//    "title": "大话西游热血版",
//    "ios_id": "1064372633",
//    "allow_ip": "",
//    "click_type": "0",
//    "down_ios_url": "https://itunes.apple.com/cn/app/da-hua-xi-you-re-xue-ban/id1064372633?mt=8",
//    "call_back_url": "http://gad.netease.com/mmad/click?s=9FtUiJCX2c7rn7KRutZ6pwhqZeQ%3D&amp;project_id=13681161&amp;monitor_type=4",
//    "gift_icon": "5316ed4ebc5e5ae20093bfff16f7368b.png",
//    "icon": "36021bf4bb05f02f1d028f3ee492146e.jpg",
//    "icon_small": "0440d9dc0d3f04a532ac140a50f5eae4.jpg",
//    "start_time": "1487865601",
//    "end_time": "1519395955",
//    "depict": "热血大话 即时开战",
//    "get_depict": "热血大话 即时开战",
//    "task_desc": "1、打开最新斗鱼ios app，从我的-精彩推荐选项卡点击下载大话西游热血版\n2、下载成功后，不参加鱼丸奖励\n3、返回任务大厅领取奖励 （注：如任务无法完成，请检查隐私-广告中限制广告跟踪是否被关闭，如果没有关闭，请关闭后重新从斗鱼APP中下载应用）",
//    "task_rule": [
//    {
//    "level": "1",
//    "name": "不参加鱼丸奖励",
//    "silver": "0",
//    "gold": "0"
//    }
//    ],
//    "silver": "0",
//    "gold": "0",
//    "show_count": 90000,
//    "sort": "16",
//    "rule_type": "1",
//    "status": "0",
//    "ctime": "1487845228"
//    },
//    {
//    "id": "150",
//    "title": "热血霸业OL",
//    "ios_id": "1194875680",
//    "allow_ip": "61.153.100.202",
//    "click_type": "0",
//    "down_ios_url": "http://api.ijunhai.com/channelAd/getAdParams/pf/2/channel_ad/douyutv/junhai_adid/2976/game_id/U100000221",
//    "call_back_url": "http://api.ijunhai.com/channelAd/getAdParams/pf/2/channel_ad/douyutv/junhai_adid/2976/game_id/U100000221",
//    "gift_icon": "8eba6df47e3a8101d436264e601407bc.png",
//    "icon": "e959eac9011e51bb10f0ad4616c2aaf4.jpg",
//    "icon_small": "d338747ea27d4e6f4c0092b1df9ac510.jpg",
//    "start_time": "1487606401",
//    "end_time": "1524298521",
//    "depict": "当年和网吧老板一起玩的传奇",
//    "get_depict": "当年和网吧老板一起玩的传奇",
//    "task_desc": "1、打开最新斗鱼ios app，从我的-精彩推荐选项卡点击下载热血霸业OL \n2、下载成功后，不参加鱼丸奖励 \n3、返回任务大厅领取奖励 （注：如任务无法完成，请检查隐私-广告中限制广告跟踪是否被关闭，如果没有关闭，请关闭后重新从斗鱼APP中下载应用）",
//    "task_rule": [
//    {
//    "level": "1",
//    "name": "不参加鱼丸奖励",
//    "silver": "0",
//    "gold": "0"
//    }
//    ],
//    "silver": "0",
//    "gold": "0",
//    "show_count": 100000,
//    "sort": "16",
//    "rule_type": "1",
//    "status": "0",
//    "ctime": "1487664883"
//    },
//    {
//    "id": "147",
//    "title": "苍月传奇",
//    "ios_id": "1197198778",
//    "allow_ip": "119.29.45.54,119.29.194.112,119.29.221.58",
//    "click_type": "0",
//    "down_ios_url": "http://uri6.com/BBBf2e",
//    "call_back_url": "http://sdk.52wan.dkmol.net/?m=API_AdvDouyu",
//    "gift_icon": "fecbed9f1d0debce3373b15351f70c13.png",
//    "icon": "b07ebf848e6ee7ef86dfa59320af6d2a.jpg",
//    "icon_small": "d6120c6f07719b1043b1cc2700f5880d.png",
//    "start_time": "1487003290",
//    "end_time": "1514708893",
//    "depict": "当年偷偷去网吧爽的感觉又回来了",
//    "get_depict": "当年偷偷去网吧爽的感觉又回来了",
//    "task_desc": "1、打开最新斗鱼ios app，从我的-精彩推荐选项卡点击下载苍月传奇 \n2、下载成功后，不参加鱼丸奖励 \n3、返回任务大厅领取奖励 （注：如任务无法完成，请检查隐私-广告中限制广告跟踪是否被关闭，如果没有关闭，请关闭后重新从斗\n\n鱼APP中下载应用）",
//    "task_rule": [
//    {
//    "level": "1",
//    "name": "不参加鱼丸奖励",
//    "silver": "0",
//    "gold": "0"
//    }
//    ],
//    "silver": "0",
//    "gold": "0",
//    "show_count": 80000,
//    "sort": "16",
//    "rule_type": "1",
//    "status": "0",
//    "ctime": "1487060845"
//    },
//    {
//    "id": "146",
//    "title": "口袋兽人",
//    "ios_id": "1104840500",
//    "allow_ip": "122.226.73.100,23.105.202.231",
//    "click_type": "0",
//    "down_ios_url": "https://itunes.apple.com/cn/app/kou-dai-shou-ren-xin-ce-e/id1104840500?mt=8&ct=589d75a842941",
//    "call_back_url": "https://cnm.y0game.com/?q=58a295f59e8c7&amp;idfa={idfa}",
//    "gift_icon": "d1d55d893386119715eaa2fe8b5338ea.png",
//    "icon": "99bd7222686ab553e030ef791214504f.jpg",
//    "icon_small": "4e9f777ae012d15f99e1516f75ea0de8.jpg",
//    "start_time": "1487001600",
//    "end_time": "1514649600",
//    "depict": "玩游戏，还是要选兽人！为了部落",
//    "get_depict": "玩游戏，还是要选兽人！为了部落",
//    "task_desc": "1、打开最新斗鱼ios app，从我的-精彩推荐选项卡点击下载口袋兽人 \n2、下载成功后，不参加鱼丸奖励 \n3、返回任务大厅领取奖励 （注：如任务无法完成，请检查隐私-广告中限制广告跟踪是否被关闭，如果没有关闭，请关闭后重新从斗\n\n鱼APP中下载应用）",
//    "task_rule": [
//    {
//    "level": "1",
//    "name": "不参加鱼丸奖励",
//    "silver": "0",
//    "gold": "0"
//    }
//    ],
//    "silver": "0",
//    "gold": "0",
//    "show_count": 100000,
//    "sort": "16",
//    "rule_type": "1",
//    "status": "0",
//    "ctime": "1487059278"
//    },
//    {
//    "id": "145",
//    "title": "寻找前世之旅",
//    "ios_id": "1163728627",
//    "allow_ip": "115.182.235.16",
//    "click_type": "0",
//    "down_ios_url": "https://itunes.apple.com/cn/app/id1163728627?mt=8",
//    "call_back_url": "http://fantasy.iqiyi.com/tracking/click/DiCuieLvKLvm.html",
//    "gift_icon": "457f8594bb2939682703e6a11728d83f.png",
//    "icon": "5fab5e7aefd0dd9f1fa0a6fc18442742.jpg",
//    "icon_small": "554d4ebf0ffc0b4687ac7dc9b8219e50.png",
//    "start_time": "1487606400",
//    "end_time": "1519142400",
//    "depict": "组队刷宝爆金装，一晚直升99！",
//    "get_depict": "组队刷宝爆金装，一晚直升99！",
//    "task_desc": "1、打开最新斗鱼ios app，从我的-精彩推荐选项卡点击下载寻找前世之旅 \n2、下载成功后，不参加鱼丸奖励 \n3、返回任务大厅领取奖励 （注：如任务无法完成，请检查隐私-广告中限制广告跟踪是否被关闭，如果没有关闭，请关闭后重新从斗\n\n鱼APP中下载应用）",
//    "task_rule": [
//    {
//    "level": "1",
//    "name": "不参加鱼丸奖励",
//    "silver": "0",
//    "gold": "0"
//    }
//    ],
//    "silver": "0",
//    "gold": "0",
//    "show_count": 80000,
//    "sort": "16",
//    "rule_type": "1",
//    "status": "0",
//    "ctime": "1486954801"
//    },
//    {
//    "id": "136",
//    "title": "烈火武尊",
//    "ios_id": "1185378706",
//    "allow_ip": "114.55.36.14",
//    "click_type": "0",
//    "down_ios_url": "https://rd.kuaigames.com/?pid=pkg586f3377a0dd1",
//    "call_back_url": "http://rd.kuaigames.com/douyu/click.php",
//    "gift_icon": "d114276264d8363a256642799187469f.png",
//    "icon": "41db9980e6357fdad25abff345dc9cc4.jpg",
//    "icon_small": "afa3f6bcb29ece03c6fbdf6ab56a1770.png",
//    "start_time": "1483718400",
//    "end_time": "1513180800",
//    "depict": "经典传奇，装备保值在线回收！",
//    "get_depict": "经典传奇，装备保值在线回收！",
//    "task_desc": "1、打开最新斗鱼ios app，从我的-精彩推荐选项卡点击下载烈火武尊 \n2、下载成功后，不参加鱼丸奖励\n3、返回任务大厅领取奖励 （注：如任务无法完成，请检查隐私-广告中限制广告跟踪是否被关闭，如果没有关闭，请关闭后重新从斗鱼APP中下载应用）",
//    "task_rule": [
//    {
//    "level": "1",
//    "name": "不参加鱼丸奖励",
//    "silver": "0",
//    "gold": "0"
//    }
//    ],
//    "silver": "0",
//    "gold": "0",
//    "show_count": 180000,
//    "sort": "16",
//    "rule_type": "1",
//    "status": "0",
//    "ctime": "1483697213"
//    },
//    {
//    "id": "135",
//    "title": "镇魔曲",
//    "ios_id": "1098075090",
//    "allow_ip": "123.58.175.218",
//    "click_type": "0",
//    "down_ios_url": "https://geo.itunes.apple.com/cn/app/zhen-mo-qu-wang-yi2017nian/id1098075090?l=zh&ls=1&mt=8&at=10lxv5&ct=G60",
//    "call_back_url": "http://gad.netease.com/mmad/click?s=cTUsPQ0WJrvaSUJmwRiPPZFxcpU%3D&amp;project_id=13251035&amp;monitor_type=4",
//    "gift_icon": "4713b6f21ad1a72a5a994534bd30063d.png",
//    "icon": "4f04543ad1e53b13226387d4866fa1b0.jpg",
//    "icon_small": "a12a4e598aafdb17d0963e7f4c30d526.jpg",
//    "start_time": "1487175387",
//    "end_time": "1489637789",
//    "depict": "网易开年巨制，今日独家首发",
//    "get_depict": "网易开年巨制，今日独家首发",
//    "task_desc": "1、打开最新斗鱼ios app，从我的-精彩推荐选项卡点击下载镇魔曲 \n2、下载成功后，不参加鱼丸奖励 \n3、返回任务大厅领取奖励 （注：如任务无法完成，请检查隐私-广告中限制广告跟踪是否被关闭，如果没有关闭，请关闭后重新从斗鱼APP中下载应用）",
//    "task_rule": [
//    {
//    "level": "1",
//    "name": "不参加鱼丸奖励",
//    "silver": "0",
//    "gold": "0"
//    }
//    ],
//    "silver": "0",
//    "gold": "0",
//    "show_count": 10000,
//    "sort": "15",
//    "rule_type": "1",
//    "status": "0",
//    "ctime": "1483601690"
//    },
//    {
//    "id": "108",
//    "title": "大航海之路",
//    "ios_id": "1115036996",
//    "allow_ip": "123.58.175.218",
//    "click_type": "0",
//    "down_ios_url": "http://gad.netease.com/mmad/click?s=3sJtTnLDhfQsaiKnsD9tB4NwxoE%3D&project_id=13148524&monitor_type=4",
//    "call_back_url": "http://gad.netease.com/mmad/click?s=3sJtTnLDhfQsaiKnsD9tB4NwxoE%3D&amp;project_id=13148524&amp;monitor_type=4",
//    "gift_icon": "34e4226eed1d0eb13bf1b7e778f3b5ce.png",
//    "icon": "c0787f3c68363afa0bbc08358ce173eb.jpg",
//    "icon_small": "7fd7e5a65e81af1b5f820bb433d8989f.jpg",
//    "start_time": "1482940801",
//    "end_time": "1514693237",
//    "depict": "网易大航海之路，送美女海盗！",
//    "get_depict": "网易大航海之路，送美女海盗！",
//    "task_desc": "1、打开最新斗鱼ios app，从我的-精彩推荐选项卡点击下载大航海之路\n2、下载成功后，不参加鱼丸奖励\n3、返回任务大厅领取奖励\n（注：如任务无法完成，请检查隐私-广告中限制广告跟踪是否被关闭，如果没有关闭，请关闭后重新从斗鱼APP中下载应用）",
//    "task_rule": [
//    {
//    "level": "1",
//    "name": "网易大航海之路，送美女海盗！",
//    "silver": "0",
//    "gold": "0"
//    }
//    ],
//    "silver": "0",
//    "gold": "0",
//    "show_count": 200000,
//    "sort": "15",
//    "rule_type": "1",
//    "status": "0",
//    "ctime": "1474636715"
//    },
//    {
//    "id": "102",
//    "title": "九阴真经3D",
//    "ios_id": "1121494585",
//    "allow_ip": "117.121.136.139",
//    "click_type": "0",
//    "down_ios_url": "http://a.woniu.com/mb3uueAb",
//    "call_back_url": "http://dd.woniu.com/_tra?wd=MB-16-12-28-YD-9YIN3D-DOUYU-1&amp;sd=-&amp;td=-&amp;proid=84",
//    "gift_icon": "0b27dc656b391faf0d602cdf7c4c572a.png",
//    "icon": "adc31bb6460865be44e1e09c70997f38.jpg",
//    "icon_small": "86d0356d4c374b4c017e90412b555c8e.png",
//    "start_time": "1486658399",
//    "end_time": "1488274802",
//    "depict": "练到60级，自创武功，开宗立派",
//    "get_depict": "练到60级，自创武功，开宗立派",
//    "task_desc": "1、打开最新斗鱼ios app，从我的-精彩推荐选项卡点击下载九阴真经3D \n2、下载成功后，不参加鱼丸奖励\n3、返回任务大厅领取奖励 （注：如任务无法完成，请检查隐私-广告中限制广告跟踪是否被关闭，如果没有关闭，请关闭后重新从斗鱼APP中下载应用）",
//    "task_rule": [
//    {
//    "level": "1",
//    "name": "不参加鱼丸奖励",
//    "silver": "0",
//    "gold": "0"
//    }
//    ],
//    "silver": "0",
//    "gold": "0",
//    "show_count": 200000,
//    "sort": "15",
//    "rule_type": "1",
//    "status": "0",
//    "ctime": "1471442839"
//    },
//    {
//    "id": "57",
//    "title": "大话西游",
//    "ios_id": "1015364140",
//    "allow_ip": "123.58.175.218",
//    "click_type": "0",
//    "down_ios_url": "http://gad.netease.com/mmad/click?s=vfxrBUnLFU%2FCpCSq6XX5Y7vxw%2F0%3D&project_id=13129342&monitor_type=4",
//    "call_back_url": "http://gad.netease.com/mmad/click?s=vfxrBUnLFU%2FCpCSq6XX5Y7vxw%2F0%3D&amp;project_id=13129342&amp;monitor_type=4",
//    "gift_icon": "f90a25ff079e349a39398b70bd14f279.png",
//    "icon": "5ad34af0627db2706c058ec4812868cf.jpg",
//    "icon_small": "348646270c20cef002c4a91e24dc2573.jpg",
//    "start_time": "1482940800",
//    "end_time": "1514649600",
//    "depict": "上海专区，同城交友",
//    "get_depict": "不参加鱼丸奖励",
//    "task_desc": "1、打开最新斗鱼ios app，从我的-精彩推荐选项卡点击下载大话西游 \n2、下载成功后，不参加鱼丸奖励 \n3、返回任务大厅领取奖励 （注：如任务无法完成，请检查隐私-广告中限制广告跟踪是否被关闭，如果没有关闭，请关闭后重新从斗鱼APP中下载应用）",
//    "task_rule": [
//    {
//    "level": "1",
//    "name": "不参加鱼丸奖励",
//    "silver": "0",
//    "gold": "0"
//    }
//    ],
//    "silver": "0",
//    "gold": "0",
//    "show_count": 90000,
//    "sort": "15",
//    "rule_type": "1",
//    "status": "0",
//    "ctime": "1457075311"
//    },
//    {
//    "id": "123",
//    "title": "妖刀传说",
//    "ios_id": "1170439579",
//    "allow_ip": "101.251.232.172,101.251.232.171,114.112.62.114",
//    "click_type": "0",
//    "down_ios_url": "https://itunes.apple.com/cn/app/id1170439579?mt=8",
//    "call_back_url": "http://api.heitao.com/click/douyutv/1324",
//    "gift_icon": "383b42a4bc6ca0dc17db1894cb500fb0.png",
//    "icon": "068ac51ea7ca09bdf91f07145a24781b.jpg",
//    "icon_small": "f6947010c97f3411809ff29befffa3bf.png",
//    "start_time": "1486656000",
//    "end_time": "1488211200",
//    "depict": "犬夜叉正版授权手游",
//    "get_depict": "犬夜叉正版授权手游",
//    "task_desc": "1、打开最新斗鱼ios app，从我的-精彩推荐选项卡点击下载妖刀传说 \n2、下载成功后，不参加鱼丸奖励 \n3、返回任务大厅领取奖励 （注：如任务无法完成，请检查隐私-广告中限制广告跟踪是否被关闭，如果没有关闭，请关闭后重新从斗鱼APP中下载应用）",
//    "task_rule": [
//    {
//    "level": "1",
//    "name": "不参加鱼丸奖励",
//    "silver": "0",
//    "gold": "0"
//    }
//    ],
//    "silver": "0",
//    "gold": "0",
//    "show_count": 130000,
//    "sort": "14",
//    "rule_type": "1",
//    "status": "0",
//    "ctime": "1479972980"
//    },
//    {
//    "id": "122",
//    "title": "天命传说",
//    "ios_id": "1180843459",
//    "allow_ip": "106.75.66.240",
//    "click_type": "0",
//    "down_ios_url": "http://uri6.com/6vEvMb",
//    "call_back_url": "http://api.douyu.cps.4gvv.com/click",
//    "gift_icon": "27b2289b8f5752a98e03c9bf3a40b685.png",
//    "icon": "03c13cfd824b9dd07e324fd479d6ab2b.jpg",
//    "icon_small": "b0114137ade08e4011462987d38e779b.png",
//    "start_time": "1487088000",
//    "end_time": "1518624000",
//    "depict": "送4千鱼丸助力探索冒险大世界！",
//    "get_depict": "送4千鱼丸助力探索冒险大世界！",
//    "task_desc": "1、打开最新斗鱼ios app，从我的-游戏中心选项卡点击下载斗《天命传说》\n2、下载成功后，注册创角，完成升级获得鱼丸奖励。\n3、返回任务大厅领取奖励 （注：如任务无法完成，请检查隐私-广告中限制广告跟踪是否被关闭，如果没有关闭，请关闭后重新从斗 鱼APP中下载应用）",
//    "task_rule": [
//    {
//    "level": "1",
//    "name": "注册创角送4000鱼丸",
//    "silver": "4000",
//    "gold": "0"
//    }
//    ],
//    "silver": "4000",
//    "gold": "0",
//    "show_count": 150000,
//    "sort": "14",
//    "rule_type": "1",
//    "status": "0",
//    "ctime": "1479803242"
//    },
//    {
//    "id": "47",
//    "title": "全民奇迹",
//    "ios_id": "837545884",
//    "allow_ip": "183.61.70.250",
//    "click_type": "0",
//    "down_ios_url": "https://itunes.apple.com/cn/app/quan-min-qi-ji-mu/id837545884?mt=8",
//    "call_back_url": "https://qmqj2.xy.com/idf/CdpKXz",
//    "gift_icon": "b5861b1902bc1198f6df272f92ae7cdb.png",
//    "icon": "38de2928cff5a7626c59771a2cc5fe6a.jpg",
//    "icon_small": "02ba902aaf53d7d979a2c46680e6e384.jpg",
//    "start_time": "1482940800",
//    "end_time": "1514649600",
//    "depict": "2周年回馈，专属萌宠时装免费领",
//    "get_depict": "2周年回馈，专属萌宠时装免费领",
//    "task_desc": "1、打开最新斗鱼ios app，从我的-精彩推荐选项卡点击下载全民奇迹 \n2、下载成功后，不参加鱼丸奖励 \n3、返回任务大厅领取奖励 （注：如任务无法完成，请检查隐私-广告中限制广告跟踪是否被关闭，如果没有关闭，请关闭后重新从斗鱼APP中下载应用）",
//    "task_rule": [
//    {
//    "level": "1",
//    "name": "不参加鱼丸奖励",
//    "silver": "0",
//    "gold": "0"
//    }
//    ],
//    "silver": "0",
//    "gold": "0",
//    "show_count": 130000,
//    "sort": "14",
//    "rule_type": "1",
//    "status": "0",
//    "ctime": "1452750789"
//    }
//    ]
