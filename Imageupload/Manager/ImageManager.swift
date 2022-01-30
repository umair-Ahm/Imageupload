//
//  ImageManager.swift
//  Imageupload
//
//  Created by Umair Ahmed on 24/01/2022.
//

import Foundation

struct ImageManager
{
    let httpLayer = HttpLayer()
    
    func uploadImageBase64(data:Data , completionHandler:@escaping(_ result:Data?) -> Void) {
         do
         {
             //Converting data in to base64EncodedString
             let requestbody = try JSONEncoder().encode(data.base64EncodedString())
             httpLayer.postApiData(requestUrl: URL(string: ImgurURLLinks.uploadImageWithImgur)!, isAuthRequired: true, requestBody: requestbody, resultType: ImageResponseModel.self) {  jsonResponseModel in
                 
                 ImgurResponseProcessing().ImgurModelSeperation(jsonResponseModel: jsonResponseModel, completionHandler: { imgdata in
                     completionHandler(imgdata)
                 })
             }
          }
          catch let error {
              print(String(describing: error))
              completionHandler(nil)
          }
     }
    
    func uploadImageByteArray(data:Data , completionHandler:@escaping(_ result:Data?) -> Void) {
        //Uplaoding image data directly
         httpLayer.postApiData(requestUrl: URL(string: ImgurURLLinks.uploadImageWithImgur)!, isAuthRequired: true, requestBody: data, resultType: ImageResponseModel.self) {  jsonResponseModel in
        
             ImgurResponseProcessing().ImgurModelSeperation(jsonResponseModel: jsonResponseModel, completionHandler: { imgdata in
                      completionHandler(imgdata)
             })
         }
    }
    
    func uploadImageMultiPart(data:Data , completionHandler:@escaping(_ result:Data?) -> Void) {
      	 let imageMultipartModel = ImageRequestMultiPartModel(imgData: data, filename: "alpha.png", name: "name1234", description: "file description for Imgur")
      	 httpLayer.postApiDataWithMultipartForm(requestUrl: URL(string: ImgurURLLinks.uploadImageWithImgur)! , isAuthRequired: true, request: imageMultipartModel, resultType: ImageResponseModel.self){  jsonResponseModel in
      	         ImgurResponseProcessing().ImgurModelSeperation(jsonResponseModel: jsonResponseModel, completionHandler: { imgdata in
      	             completionHandler(imgdata)
      	           })
      	 }
    }
  }

