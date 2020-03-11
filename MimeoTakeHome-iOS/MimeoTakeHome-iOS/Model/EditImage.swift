//
//  EditImage.swift
//  MimeoTakeHome-iOS
//
//  Created by Axel Mosiejko on 11/03/2020.
//  Copyright © 2020 Mimeo. All rights reserved.
//

import Foundation

struct EditImage: Codable {
    
    var fullPath: String! // the full path with file name included.
    var filename: String!
    var position: Int? // the rotation position (from 0 to 3)
    var uuid: String?
    var width: String?
    var height: String?
    
}
