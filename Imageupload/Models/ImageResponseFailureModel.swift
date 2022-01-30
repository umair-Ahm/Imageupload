//
//  ImageResponseFailureModel.swift
//  Imageupload
//
//  Created by Umair Ahmed on 24/01/2022.
//

import Foundation

// MARK: - ImageResponseFailureModel
struct ImageResponseFailureModel: Decodable {
    let error, request, method: String
}
