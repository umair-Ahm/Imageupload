//
//  ImageResponseSuccessModel.swift
//  Imageupload
//
//  Created by Umair Ahmed on 24/01/2022.
//

import Foundation

// MARK: - ImageResponseSuccessModel
struct ImageResponseSuccessModel: Decodable {
    let id: String
    let datetime: Int
    let type: String
    let animated: Bool
    let width, height, size, views: Int
    let bandwidth: Int
    let deletehash: String
    let link: String

}
