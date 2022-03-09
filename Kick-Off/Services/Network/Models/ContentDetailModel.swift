//
//  ContentDetailModel.swift
//  Kick-Off
//
//  Created by Burak Çokyıldırım on 9.03.2022.
//

import Foundation

struct ContentDetailModel: Decodable {
    var headline: String?
    var tags: [ContentsModel.Tag]?
    var cover: ContentsModel.Cover?
    var readTime: Int?

    var content: [Content]?

    enum CodingKeys: String, CodingKey {
        case content
    }

    enum NestedCodingKeys: String, CodingKey {
        case headline, tags, cover, content
        case readTime = "read_time"
    }

    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: CodingKeys.self)
        let nestedContainer = try rootContainer.nestedContainer(keyedBy: NestedCodingKeys.self, forKey: .content)

        headline = try nestedContainer.decodeIfPresent(String.self, forKey: .headline)
        tags = try nestedContainer.decodeIfPresent([ContentsModel.Tag].self, forKey: .tags)
        cover = try nestedContainer.decodeIfPresent(ContentsModel.Cover.self, forKey: .cover)
        readTime = try nestedContainer.decodeIfPresent(Int.self, forKey: .readTime)
        content = try nestedContainer.decodeIfPresent([Content].self, forKey: .content)
    }

    struct Content: Decodable {
        var paragraph: String?
        var header: String?
        var videoUrl: String?
        var thumbnailUrl: String?

        enum CodingKeys: String, CodingKey {
            case paragraph = "p"
            case header = "h2"
            case videoUrl = "video"
            case thumbnailUrl = "thumbnail_url"
        }
    }
}
