//
//  GameModel.swift
//  MGDYZB
//
//  Created by ming on 16/10/26.
//  Copyright © 2016年 ming. All rights reserved.

//  简书：http://www.jianshu.com/users/57b58a39b70e/latest_articles
//  github:  https://github.com/LYM-mg
//

import UIKit

class GameModel: BaseGameModel {

    var broadcastLimit : String!
    var cateId : String!
    var count : Int!
    var countIos : Int!
    var iconName : String!
    var isAudio : String!
    var isCt1Hidden : String!
    var isDel : String!
    var isGameCate : String!
    var isHidden : String!
    var isRelate : String!
    var nightRankScore : String!
    var nums : String!
    var openFullScreen : String!
    var orderdisplay : String!
    var picName : String!
    var picName2 : String!
    var picUrl : String!
    var picUrl2 : String!
    var pushHome : String!
    var pushIos : String!
    var pushNearby : String!
    var pushQqapp : String!
    var pushVerticalScreen : String!
    var rankScore : String!
    var shortName : String!
    var smallIconName : String!
    var smallIconUrl : String!
    var squareIconUrlM : String!
    var squareIconUrlW : String!
    var tagId : String!
    var tagIntroduce : String!
    var tagName : String!
    var url : String!
    var voddCateids : String!


    /**
     * Instantiate the instance using the passed dict values to set the properties values
     */
    override init(dict: [String:Any]){
        super.init()
        broadcastLimit = dict["broadcast_limit"] as? String
        cateId = dict["cate_id"] as? String
        count = dict["count"] as? Int
        countIos = dict["count_ios"] as? Int
        iconName = dict["icon_name"] as? String
        icon_url = dict["icon_url"] as? String ?? ""
        isAudio = dict["is_audio"] as? String
        isCt1Hidden = dict["is_ct1_hidden"] as? String
        isDel = dict["is_del"] as? String
        isGameCate = dict["is_game_cate"] as? String
        isHidden = dict["is_hidden"] as? String
        isRelate = dict["is_relate"] as? String
        nightRankScore = dict["night_rank_score"] as? String
        nums = dict["nums"] as? String
        openFullScreen = dict["open_full_screen"] as? String
        orderdisplay = dict["orderdisplay"] as? String
        picName = dict["pic_name"] as? String
        picName2 = dict["pic_name2"] as? String
        picUrl = dict["pic_url"] as? String
        picUrl2 = dict["pic_url2"] as? String
        pushHome = dict["push_home"] as? String
        pushIos = dict["push_ios"] as? String
        pushNearby = dict["push_nearby"] as? String
        pushQqapp = dict["push_qqapp"] as? String
        pushVerticalScreen = dict["push_vertical_screen"] as? String
        rankScore = dict["rank_score"] as? String
        shortName = dict["short_name"] as? String
        smallIconName = dict["small_icon_name"] as? String
        smallIconUrl = dict["small_icon_url"] as? String
        squareIconUrlM = dict["square_icon_url_m"] as? String
        squareIconUrlW = dict["square_icon_url_w"] as? String
        tagId = dict["tag_id"] as? String
        tagIntroduce = dict["tag_introduce"] as? String
        tag_name = dict["tag_name"] as? String ?? ""
        url = dict["url"] as? String
        voddCateids = dict["vodd_cateids"] as? String
    }

}
