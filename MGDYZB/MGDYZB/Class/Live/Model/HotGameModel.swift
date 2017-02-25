//
//  HotGameModel.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/2/25.
//  Copyright © 2017年 ming. All rights reserved.
//

import UIKit

class HotGameModel: AnchorModel {
    var avatar : String!
    var avatarMid : String!
    var avatarSmall : String!
    var cate1Id : String!
    var cate2Id : String!
    var cate3Id : String!
    var cateId : Int!
    var childId : Int!
    var cid1 : Int!
    var gameName : String!
    var gameUrl : String!
    var iconEndTime : Bool!
    var iconId : String!
    var iconStartTime : Bool!
    var showStatus : String!
    var showTime : String!
    var specificCatalog : String!
    var specificStatus : String!
    var url : String!
    var verticalSrc : String!
    var vodQuality : String!
    var room_src: String! {
        didSet {
            self.vertical_src = room_src
        }
    }
}
