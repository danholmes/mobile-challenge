//
//  Statics.swift
//  500pxDemo
//
//  Created by Dan on 2017-05-22.
//  Copyright © 2017 Dan. All rights reserved.
//

// Statics.swift is a collection of enums and other data types used in the 500px API.
// Wherever possible, the associated documentation has been described and linked to
// the API's official documentation.

import Foundation

enum PhotosFeature: String {
    case Popular = "popular"
    case HighestRated = "highest_rated"
    case Upcoming = "upcoming"
    case Editors = "editors"
    case FreshToday = "fresh_today"
    case FreshYesterday = "fresh_yesterday"
    case FreshWeek = "fresh_week"
}

enum ImageSize: Int {
    case Small = 1
    case Medium = 2
    case Large = 3
    case Full = 4
}

/** What kind of gallery a photo can belong to.
 
 [500px API Documentation](https://github.com/500px/api-documentation/blob/master/basics/formats_and_terms.md#gallery-kinds)
 */
enum Kind: Int, CustomStringConvertible {
    case General = 0
    case Lightbox = 1
    case Portfolio = 3
    case Profile = 4
    case Favorite = 5
    
    var description: String {
        get {
            switch self {
            case .General: return "General: Any photo on 500px"
            case .Lightbox: return "Lightbox: Marketplace photos"
            case .Portfolio: return "Portfolio: Photos displayed on the portfolio page"
            case .Profile: return "Profile: Photos uploaded by the gallery owner"
            case .Favorite: return "Favorite: Photos favorited by the gallery owner via the old API."
            }
        }
    }
}

/** *API's Description:* Sex of the user, string. Values: 1 and 2 for male and female respectively, 0 if user refused to specify their sex.
 
 [500px API Documentation](https://github.com/500px/api-documentation/blob/master/basics/formats_and_terms.md#profile-format)
 */
enum Sex: Int, CustomStringConvertible {
    case Unspecified = 0, Male, Female
    
    var description: String {
        get {
            switch self {
            case .Unspecified: return "Unspecified"
            case .Male: return "Male"
            case .Female: return "Female"
            }
        }
    }
}

/** *API's Description:* Categories of photos may be specified by their ID or string name, depending on the API method.
 
 [500px API Documentation](https://github.com/500px/api-documentation/blob/master/basics/formats_and_terms.md#categories)
 */
enum PhotoCategory: Int, CustomStringConvertible {
    case Uncategorized = 0, Celebrities, Film, Journalism, Nude, BlackAndWhite, StillLife, People, Landscapes, CityAndArchitecture, Abstract, Animals, Macro, Travel, Fashion, Commercial, Concert, Sport, Nature, PerformingArts, Family, Street, Underwater, Food, FineArt, Wedding, Transportation, UrbanExploration
    
    var description: String {
        get {
            switch self {
            case .Uncategorized: return "Uncategorized"
            case .Celebrities: return "Celebrities"
            case .Film: return "Film"
            case .Journalism: return "Journalism"
            case .Nude: return "Nude"
            case .BlackAndWhite: return "Black And White"
            case .StillLife: return "Still Life"
            case .People: return "People"
            case .Landscapes: return "Landscapes"
            case .CityAndArchitecture: return "City And Architecture"
            case .Abstract: return "Abstract"
            case .Animals: return "Animals"
            case .Macro: return "Macro"
            case .Travel: return "Travel"
            case .Fashion: return "Fashion"
            case .Commercial: return "Commercial"
            case .Concert: return "Concert"
            case .Sport: return "Sport"
            case .Nature: return "Nature"
            case .PerformingArts: return "Performing Arts"
            case .Family: return "Family"
            case .Street: return "Street"
            case .Underwater: return "Underwater"
            case .Food: return "Food"
            case .FineArt: return "Fine Art"
            case .Wedding: return "Wedding"
            case .Transportation: return "Transportation"
            case .UrbanExploration: return "Urban Exploration"
            }
        }
    }
}

/** *API's Description:* 500px currently supports these types of licenses, more details can be found at http://500px.com/creativecommons
 
 [500px API Documentation](https://github.com/500px/api-documentation/blob/master/basics/formats_and_terms.md#license_types)
 */
enum LicenceType: Int, CustomStringConvertible {
    case Standard500Px = 0, CCNonCommercialAttribution, CCNonCommercialNoDerivatives, CCNonCommercialShareAlike, CCAttribution, CCNoDerivatives, CCShareAlike, CCPublicDomainMark1, CCPublicDomainDedication
    
    var description: String {
        get {
            switch self {
            case .Standard500Px: return "Standard 500px License"
            case .CCNonCommercialAttribution: return "Creative Commons License Non Commercial Attribution"
            case .CCNonCommercialNoDerivatives: return "Creative Commons License Non Commercial No Derivatives"
            case .CCNonCommercialShareAlike: return "Creative Commons License Non Commercial Share Alike"
            case .CCAttribution: return "Creative Commons License Attribution"
            case .CCNoDerivatives: return "Creative Commons License No Derivatives"
            case .CCShareAlike: return "Creative Commons License Share Alike"
            case .CCPublicDomainMark1: return "Creative Commons License Public Domain Mark 1.0"
            case .CCPublicDomainDedication: return "Creative Commons License Public Domain Dedication"
            }
        }
    }
}

