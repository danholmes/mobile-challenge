//
//  PhotoInfo.swift
//  500pxDemo
//
//  Created by Dan on 2017-05-22.
//  Copyright © 2017 Dan. All rights reserved.
//

import Foundation
import ObjectMapper

/// A model representing a 500Px photo. [500Px API Documentation Link](https://github.com/500px/api-documentation/blob/master/basics/formats_and_terms.md#photo-object-formats)
class PhotoInfo: NSObject, Mappable {
    
    private enum Keys: String {
        case ID = "id"
        case Name = "name"
        case Desc = "description"
        case Width = "width"
        case Height = "height"
        case User = "user"
        case Rating = "rating"
        case HighestRating = "highest_rating"
        case HighestRatingDate = "highest_rating_date"
        case VotesCount = "votes_count"
        case CommentsCount = "comments_count"
        case TimesViewed = "times_viewed"
        case Privacy = "privacy"
        case EditorsChoice = "editors_choice"
        case NSFW = "nfsw"
        case GalleriesCount = "galleries_count"
        case Camera = "camera"
        case Lens = "lens"
        case FocalLength = "focal_length"
        case ISO = "iso"
        case ShutterSpeed = "shutter_speed"
        case AperatureValue = "aperature_value"
        case ForSale = "for_sale"
        case SalesCount = "sales_count"
        case StoreDownload = "store_download"
        case StorePrint = "store_print"
        case Category = "category"
        case Feature = "feature"
        case Status = "status"
        case CreatedAt = "created_at"
        case TakenAt = "taken_at"
        case Location = "location"
        case Latitude = "latitude"
        case Longitude = "longitude"
        case LicenceType = "licence_type"
        case ImageURL = "image_url"
    }
    
    //MARK:- General Info
    
    /// *API's Description:* ID of the photo, integer
    var id: Int!
    /// *API's Description:* Title of the photo, string
    var name: String!
    /// *API's Description:* Description of the photo, string
    var desc: String?
    /// *API's Description:* The width of the original, unresized photo, integer
    var width: Float?
    /// *API's Description:* The height of the origin, unresized photo, integer
    var height: Float?
    
    //MARK:- Social Info
    
    /// *API's Description:* Author’s profile, object
    var user: User?
    /// *API's Description:* Rating of the photo, decimal
    var rating: Float?
    /// *API's Description:* The highest rating this photo has had, decimal
    var highestRating: Float?
    /// *API's Description:* The date the highest rating was reached on, timestamp
    var highestRatingDate: Date?
    /// *API's Description:* Number of votes cast on this photo, integer
    var votesCount: Int?
    /// *API's Description:* Number of comments this photo has, integer
    var commentsCount: Int?
    /// *API's Description:* The number of views this photo has, integer
    var timesViewed: Int?
    /// *API's Description:* Boolean value whether or not the community page (http://500px.com/photo/:id) of this photo is available. A value of true means the page is not available.
    var privacy: Bool?
    /// *API's Description:* Boolean value whether the current photo is NSFW
    var nsfw: Bool?
    /// *API's Description:* Boolean value indicating whether or not the photo is in Editors' Choice.
    var editorsChoice: Bool?
    /// *API's Description:* Number of galleries this photo is present in, integer
    var galleriesCount: Int?
    
    //MARK:- Camera Info
    
    /// *API's Description:* Make and model of the camera this photo was made with, string
    var camera: String?
    /// *API's Description:* This photo’s camera lens information, string
    var lens: String?
    /// *API's Description:* Focal length of the shot, string
    var focalLength: String?
    /// *API's Description:* ISO value of the shot, string
    var iso: String?
    /// *API's Description:* Shutter speed value of the shot, string
    var shutterSpeed: String?
    /// *API's Description:* Aperture value of the shot, string
    var aperatureValue: String?
    
    
    //MARK:- Store Info
    
    /// *API's Description:* Boolean value whether or not the photo is for sale
    var forSale: Bool?
    /// *API's Description:* The number of sales this photo has
    var salesCount: Int?
    /// *API's Description:* Boolean value indicating whether or not the photo is for sale as a digital download.
    var storeDownload: Bool?
    /// *API's Description:* Boolean value indicating whether or not the photo is for sale as a canvas print.
    var storePrint: Bool?
    
    
    //MARK:- Misc
    
    /// *API's Description:* Category of the photo, (short) integer
    var category: PhotoCategory?
    /// *API's Description:* The section of the site this photo appears under, string. Possible values are popular upcoming fresh_today fresh_yesterday fresh_week
    var feature: PhotosFeature?
    /// *API's Description:* Status of the photo in the system, integer. An active photo always has the status of 1.
    var status: Int?
    /// *API's Description:* Timestamp indicating time of photo creation, timestamp
    var createdAt: Date?
    /// *API's Description:* Timestamp of when the photo was taken, timestamp
    var takenAt: Date?
    /// *API's Description:* A human-readable name of the location where the photo was taken, string
    var location: String?
    /// *API's Description:* Latitude of the location where the photo was taken, decimal
    var latitude: Float?
    /// *API's Description:* Longitude of the location where the photo was taken, decimal
    var longitude: Float?
    /// *API's Description:* [License type](https://github.com/500px/api-documentation/blob/master/basics/formats_and_terms.md#license_types) of the photo, (short) integer
    var licenceType: LicenceType?
    
    var imageUrl: String?
    
    //TODO: Comments, Images, Voted, Purchased
    
    //MARK:- Methods
    
    required init?(map: Map) {
        guard map.JSON[Keys.ID.rawValue] != nil else { return }
        guard map.JSON[Keys.Name.rawValue] != nil else { return }
    }
    
    func mapping(map: Map) {
        id <- map[Keys.ID.rawValue]
        name <- map[Keys.Name.rawValue]
        desc <- map[Keys.Desc.rawValue]
        width <- map[Keys.Width.rawValue]
        height <- map[Keys.Height.rawValue]
        user <- map[Keys.User.rawValue]
        rating <- map[Keys.Rating.rawValue]
        highestRating <- map[Keys.HighestRating.rawValue]
        highestRatingDate <- (map[Keys.HighestRatingDate.rawValue], DateTransform())
        votesCount <- map[Keys.VotesCount.rawValue]
        commentsCount <- map[Keys.CommentsCount.rawValue]
        timesViewed <- map[Keys.TimesViewed.rawValue]
        privacy <- map[Keys.Privacy.rawValue]
        editorsChoice <- map[Keys.EditorsChoice.rawValue]
        nsfw <- map[Keys.NSFW.rawValue]
        galleriesCount <- map[Keys.GalleriesCount.rawValue]
        camera <- map[Keys.Camera.rawValue]
        lens <- map[Keys.Lens.rawValue]
        focalLength <- map[Keys.FocalLength.rawValue]
        iso <- map[Keys.ISO.rawValue]
        shutterSpeed <- map[Keys.ShutterSpeed.rawValue]
        aperatureValue <- map[Keys.AperatureValue.rawValue]
        forSale <- map[Keys.ForSale.rawValue]
        salesCount <- map[Keys.SalesCount.rawValue]
        storeDownload <- map[Keys.StoreDownload.rawValue]
        storePrint <- map[Keys.StorePrint.rawValue]
        category <- map[Keys.Category.rawValue]
        feature <- map[Keys.Feature.rawValue]
        status <- map[Keys.Status.rawValue]
        createdAt <- (map[Keys.CreatedAt.rawValue], DateTransform())
        takenAt <- (map[Keys.TakenAt.rawValue], DateTransform())
        location <- map[Keys.Location.rawValue]
        latitude <- map[Keys.Latitude.rawValue]
        longitude <- map[Keys.Longitude.rawValue]
        licenceType <- map[Keys.LicenceType.rawValue]
        imageUrl <- map[Keys.ImageURL.rawValue]
    }
    
}
