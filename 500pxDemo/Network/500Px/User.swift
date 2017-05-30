//
//  User.swift
//  500pxDemo
//
//  Created by Dan on 2017-05-22.
//  Copyright © 2017 Dan. All rights reserved.
//

import Foundation
import ObjectMapper

class User: NSObject, Mappable {
    
    private enum Keys: String {
        case ID = "id"
        case Username = "username"
        case FirstName = "firstname"
        case LastName = "lastname"
        case FullName = "fullname"
        case Sex = "sex"
        case City = "city"
        case State = "state"
        case Country = "country"
        case RegistrationDate = "registration_date"
        case About = "about"
        case Domain = "domain"
        case Locale = "locale"
        case UpgradeStatus = "upgrade_status"
        case ShowNude = "show_nude"
        case UserpicURL = "userpic_url"
        case StoreOn = "store_on"
        case Contacts = "contacts"
        case Equipment = "equipment"
        case PhotosCount = "photos_count"
        case GalleriesCount = "galleries_count"
        case Affection = "affection"
        case FriendsCount = "friends_count"
        case FollowersCount = "followers_count"
        case Admin = "admin"
    }
    
    //MARK:- General Info
    
    /// *API's Description:* id — ID of the user, integer
    var id: Int!
    /// *API's Description:* username — Username, string
    var username: String!
    /// *API's Description:* firstname — First name, string
    var firstName: String?
    /// *API's Description:* lastname — Last name, string
    var lastName: String?
    /// *API's Description:* fullname — A combination of first and last names or a username that would naturally appear on the site, string
    var fullName: String?
    /// *API's Description:* sex — Sex of the user, string. Values: 1 and 2 for male and female respectively, 0 if user refused to specify their sex.
    var sex: Sex?
    /// *API's Description:* city — City as specified in user’s profile, string
    var city: String?
    /// *API's Description:* state — State as specified in user’s profile, string
    var state: String?
    /// *API's Description:* country — Country as specified in user’s profile, string
    var country: String?
    /// *API's Description:* registration_date — Registration timestamp, timestamp
    var registrationDate: Date?
    /// *API's Description:* about — User’s about text, timestamp
    var about: String?
    /// *API's Description:* domain - The host name of the user's portfolio, string
    var domain: String?
    /// *API's Description:* locale — User’s preferred locale, string. Current values: en, ru, de, ja, br, es.
    var locale: String?
    /// *API's Description:* upgrade_status — Whether the user is a premium user, integer. Non-zero values identify premium users; a value of 2 identifies an Awesome user while a value of 1 identifies a Plus user. Other states may be added in the future, so write your parsers accordingly.
    var upgradeStatus: Int?
    /// *API's Description:* show_nude — Whether the user has content filter disabled, boolean.
    var showNude: Bool?
    /// *API's Description:* userpic_url — Profile picture’s URL of the user, string
    var userpicUrl: String?
    /// *API's Description:* store_on - Whether the user has the store option enabled, boolean
    var storeOn: Bool?
    /// *API's Description:* contacts — A dictionary of user’s contacts, object. Keys should be treated as provider names, and values as user IDs with given provider.
    var contacts: [String:Int]?
    /// *API's Description:* equipment - A dictionary of a user's equipment. Possible keys are camera, lens, misc. Each key will have an array of values.
    var equipment: [String:String]?
    /// *API's Description:* photos_count — Number of active photos posted by the user, integer.
    var photosCount: Int?
    /// *API's Description:* galleries_count — Number of galleries visible on the user's profile, integer.
    var galleriesCount: Int?
    /// *API's Description:* affection — Affection value, integer.
    var affection: Int?
    /// *API's Description:* friends_count — Number of people this user follows, integer.
    var friendsCount: Int?
    /// *API's Description:* followers_count — Number of people this user is being followed by, integer.
    var followersCount: Int?
    /// *API's Description:* admin - Boolean value that will be 1 if the user is a 500px team member.
    var admin: Bool = false
    /// *API's Description:* avatars - A dictionary of different avatar sizes. Keys are default, large, small, tiny. default is up to 300x300px, large is 100x100px, small is 50x50px, tiny is 30x30px.
    // TODO: Avatars, more
    
    required init?(map: Map) {
        guard map.JSON[Keys.ID.rawValue] != nil else { return }
        guard map.JSON[Keys.Username.rawValue] != nil else { return }
    }
    
    func mapping(map: Map) {
        id <- map[Keys.ID.rawValue]
        username <- map[Keys.Username.rawValue]
        firstName <- map[Keys.FirstName.rawValue]
        lastName <- map[Keys.LastName.rawValue]
        fullName <- map[Keys.FullName.rawValue]
        sex <- map[Keys.Sex.rawValue]
        city <- map[Keys.City.rawValue]
        state <- map[Keys.State.rawValue]
        country <- map[Keys.Country.rawValue]
        registrationDate <- (map[Keys.RegistrationDate.rawValue], DateTransform())
        about <- map[Keys.About.rawValue]
        domain <- map[Keys.Domain.rawValue]
        locale <- map[Keys.Locale.rawValue]
        upgradeStatus <- map[Keys.UpgradeStatus.rawValue]
        showNude <- map[Keys.ShowNude.rawValue]
        userpicUrl <- map[Keys.UserpicURL.rawValue]
        storeOn <- map[Keys.StoreOn.rawValue]
        contacts <- map[Keys.Contacts.rawValue]
        equipment <- map[Keys.Equipment.rawValue]
        photosCount <- map[Keys.PhotosCount.rawValue]
        galleriesCount <- map[Keys.GalleriesCount.rawValue]
        affection <- map[Keys.Affection.rawValue]
        friendsCount <- map[Keys.FriendsCount.rawValue]
        followersCount <- map[Keys.FollowersCount.rawValue]
        admin <- map[Keys.Admin.rawValue]
    }
}
