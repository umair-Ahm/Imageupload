//
//  ImageRequestModel.swift
//  Imageupload
//
//  Created by Umair Ahmed on 24/01/2022.
//

import Foundation

struct ImageRequestMultiPartModel : Encodable
{
   let imgData     :Data
   let filename    :String
   let name        :String
   let description :String
}
