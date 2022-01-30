//
//  Global.swift
//  Imageupload
//
//  Created by Umair Ahmed on 24/01/2022.
//

import Foundation

//Register your application via below link and get a client id and  client secret
//https://api.imgur.com/oauth2/addclient
struct ImgurAPIKeys
{
    static let clientId = "cb2e38305cfe1ca"
}

struct ImgurURLLinks {
    static let uploadImageWithImgur = "https://api.imgur.com/3/image"
    static let imgurBaseStr = "https://api.imgur.com"
}

public enum APIMethods : String {
    case Get  = "GET"
    case Post = "POST"
}

public enum PressedButton : Int {
    case Base64pressed  = 1
    case ByteArraypressed = 2
    case MultiPartpressed = 3
}
