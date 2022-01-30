//
//  ImageResponseModel.swift
//  Imageupload
//
//  Created by Umair Ahmed on 24/01/2022.
//

import Foundation

// MARK: - ImageResponseImgur
struct ImageResponseModel: Decodable {
    let data: dataResponse //can be Success or Faillure
    let success: Bool
    let status: Int
}

enum dataResponse: Decodable  {
    case successData (ImageResponseSuccessModel)
    case failedData  (ImageResponseFailureModel)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do{
            let  successData = try container.decode(ImageResponseSuccessModel.self)
            self = .successData(successData)
            
        } catch DecodingError.keyNotFound {
            //I am using DecodingError.keyNotFound as "error" key not exist in above success cause
            let failedData = try container.decode(ImageResponseFailureModel.self)
            self = .failedData(failedData)
        }
    }
    
}
