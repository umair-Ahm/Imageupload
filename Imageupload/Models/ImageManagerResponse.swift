//
//  ImageManagerResponse.swift
//  Imageupload
//
//  Created by Umair Ahmed on 25/01/2022.
//

import Foundation

struct ImageManagerResponse {
    let haveData : Bool
    var fileData : Data?
    
    init(haveData : Bool, fileData: Data? = nil){
        self.haveData = haveData
        self.fileData = fileData
    }
}
