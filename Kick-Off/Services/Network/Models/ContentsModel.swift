//
//  ContentsModel.swift
//  Kick-Off
//
//  Created by Burak Çokyıldırım on 8.03.2022.
//

import Foundation

struct ContentsModel: Decodable {
    var allContents: [Content]?

    enum CodingKeys: String, CodingKey {
        case allContents = "contents"
    }

    struct Content: Decodable {
        var id: String?
        var author: Author?
        var headline: String?
        var summary: String?
        var tags: [Tag]?
        var cover: Cover?
        var readTime: Int?

        enum CodingKeys: String, CodingKey {
            case id, author, headline,
                 summary, tags, cover
            case readTime = "read_time"
        }

    }

    struct Author: Decodable {
        var name: String?
        var imageUrl: String?

        enum CodingKeys: String, CodingKey {
            case name
            case imageUrl = "image_url"
        }
    }

    struct Tag: Decodable {
        var id: String?
        var name: String?
        var color: String?
        var backgroundColor: String?

        enum CodingKeys: String, CodingKey {
            case id, name, color
            case backgroundColor = "background_color"
        }
    }

    struct Cover: Decodable {
        var type: String?
        var url: String?
    }
}
