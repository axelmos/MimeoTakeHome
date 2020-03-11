//
//  JSONResponse.swift
//  MimeoTakeHome-iOS
//
//  Created by Axel Mosiejko on 11/03/2020.
//  Copyright © 2020 Mimeo. All rights reserved.
//

import Foundation

struct JSONResponse: Decodable {
    let uuid: String?
    let filename: String?
    let size: [String : String]?
    let rotation: Int?
    
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case filename = "filename"
        case size = "size"
        case rotation = "rotation"
    }
     init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
        filename = try values.decodeIfPresent(String.self, forKey: .filename)
        size = try values.decodeIfPresent([String : String].self, forKey: .size)
        rotation = try values.decodeIfPresent(Int.self, forKey: .rotation)
     }
}
