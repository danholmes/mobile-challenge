//
//  Comment.swift
//  500pxDemo
//
//  Created by Dan on 2017-05-22.
//  Copyright © 2017 Dan. All rights reserved.
//

import Foundation
import ObjectMapper

///  [*API NOTES*](https://github.com/500px/api-documentation/blob/master/basics/formats_and_terms.md#comment-object-formats)

class Comment: NSObject, Mappable {
    
    private enum Keys: String {
        case ID = "id"
        case UserID = "user_id"
        case Name = "name"
        case Desc = "description"
        case Subtitle = "subtitle"
        case ItemsCount = "items_count"
        case Privacy = "privacy"
        case Kind = "kind"
        case CreatedAt = "created_at"
        case UpdatedAt = "updated_at"
        case CustomPath = "custom_path"
        case LastAddedPhoto = "last_added_photo"
        case User = "user"
    }
    
    /// *API's Description:* id — ID of the gallery, integer
    var id: Int!
    /// *API's Description:* user_id — ID of the user that owns the gallery, integer
    var userId: Int!
    /// *API's Description:* name — Title of the gallery, string
    var name: String!
    /// *API's Description:* description — Description of the gallery, string
    var desc: String?
    /// *API's Description:* subtitle — A short (500 char.) blurb of the gallery, string
    var subtitle: String?
    /// *API's Description:* items_count — Number of items in the gallery, integer
    var itemsCount: Int?
    /// *API's Description:* privacy - Boolean value whether or not the gallery is private. A value of true means the gallery is private to the user
    var privacy: Bool?
    /// *API's Description:* kind - Indicates the gallery kind, integer
    var kind: Kind?
    /// *API's Description:* created_at — Timestamp indicating time the gallery was created, timestamp
    var createdAt: Date?
    /// *API's Description:* updated_at — Timestamp indicating time the gallery was updated, timestamp
    var updatedAt: Date?
    /// *API's Description:* cover_photo - Array containing a JSON hash of the cover photo's id, size, url, and nsfw flag
    // TODO: cover_photo
    /// *API's Description:* custom_path - Custom path of the gallery, string
    var customPath: String?
    /// *API's Description:* last_added_photo (optional) - Photo that was last added to the gallery, in short format
    var lastAddedPhoto: PhotoInfo?
    /// *API's Description:* user (optional) - User who owns the gallery, in short format
    var user: User?
    
    required init?(map: Map) {
        guard map.JSON[Keys.ID.rawValue] != nil else { return }
        guard map.JSON[Keys.UserID.rawValue] != nil else {  return }
        
    }
    
    func mapping(map: Map) {
        id <- map[Keys.ID.rawValue]
        userId <- map[Keys.UserID.rawValue]
        name <- map[Keys.Name.rawValue]
        desc <- map[Keys.Desc.rawValue]
        subtitle <- map[Keys.Subtitle.rawValue]
        itemsCount <- map[Keys.ItemsCount.rawValue]
        privacy <- map[Keys.Privacy.rawValue]
        createdAt <- (map[Keys.CreatedAt.rawValue], DateTransform())
        updatedAt <- (map[Keys.UpdatedAt.rawValue], DateTransform())
        customPath <- map[Keys.CustomPath.rawValue]
        lastAddedPhoto <- map[Keys.LastAddedPhoto.rawValue]
        user <- map[Keys.User.rawValue]
    }
}
