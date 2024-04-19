//
//  PostModel.swift
//  ImediNewsApp
//
//  Created by telkanishvili on 19.04.24.
//

import UIKit
//MARK: - Structure
struct PostModel: Decodable {
    var title: String?
    var time: String?
    var url: String?
    var photoUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case time = "Time"
        case url = "Url"
        case photoUrl = "PhotoUrl"
    }
}

struct PostList: Decodable {
    var list: [PostModel]
    
    enum CodingKeys: String, CodingKey {
        case list = "List"
    }
}

var postList = PostList(list: [PostModel()])
