//
//  UUID.swift
//  MimeoTakeHome-iOS
//
//  Created by Axel Mosiejko on 11/03/2020.
//  Copyright © 2020 Mimeo. All rights reserved.
//

import Foundation

struct UUID: Decodable {
    let uuid : String?
    
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
    }
     init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
     }
}
