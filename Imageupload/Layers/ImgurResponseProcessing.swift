//
//  ImgurResponseProcessing.swift
//  Imageupload
//
//  Created by Umair Ahmed on 27/01/2022.
//

import Foundation

struct ImgurResponseProcessing {
    func ImgurModelSeperation (jsonResponseModel:ImageResponseModel, completionHandler:@escaping(_ result:Data?) -> Void) {
        switch jsonResponseModel.data {
          case .successData (let successModel):
            print("Success model \(successModel)")
            print("success model Image link is \(successModel.link)")
            self.getImgDataFromURL(imagelink: successModel.link) { imgData in
                 completionHandler(imgData)
             }
            case .failedData (let failureModel):
            print("Failure model \(failureModel)")
            completionHandler(nil)
          }
        
    }
    
    private func getImgDataFromURL(imagelink:String , completionHandler:@escaping(_ result:Data) -> Void)  {
        DispatchQueue.global().async {
            let imageUrl = URL(string: imagelink)
            if let imagedata = try? Data(contentsOf: imageUrl!){
                completionHandler(imagedata)
               }
            }
      }
   
}
