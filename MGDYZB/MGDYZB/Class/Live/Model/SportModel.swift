//
//  SportModel.swift
//  MGDYZB
//
//  Created by i-Techsys.com on 17/2/25.
//  Copyright © 2017年 ming. All rights reserved.
//

import UIKit

class SportModel: AnchorModel {
    var gameName : String!
    
    var room_src: String! {
        didSet {
            self.vertical_src = room_src
        }
    }
}

