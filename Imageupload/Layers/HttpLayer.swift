//
//  HttpLayer.swift
//  Imageupload
//
//  Created by Umair Ahmed on 24/01/2022.
//

import Foundation

struct HttpLayer
{
    func postApiData<T:Decodable>(requestUrl: URL, isAuthRequired:Bool, requestBody: Data, resultType: T.Type, completionHandler:@escaping(_ result: T)-> Void)
    {
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = requestBody
        
        //Specifically for Image upload to imgur
        if (isAuthRequired)
        {
           urlRequest.addValue("Client-ID " + ImgurAPIKeys.clientId, forHTTPHeaderField: "Authorization")
        }
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            if(error == nil && data != nil && data?.count != 0)
            {
                do {
                    let response = try JSONDecoder().decode(T.self, from: data!)
                    _=completionHandler(response)
                }
                catch let decodingError {
                    print(String(describing: decodingError))
               }
            }

        }.resume()
    }

     func postApiDataWithMultipartForm<T:Decodable>(requestUrl: URL, isAuthRequired:Bool, request: ImageRequestMultiPartModel, resultType: T.Type, completionHandler:@escaping(_ result: T)-> Void)
    {
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = APIMethods.Post.rawValue
        let boundary = "---------------------------------\(UUID().uuidString)"
        let lineBreak = "\r\n"
        
        //Main Boundary Start
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
       
        //Specifically for Image upload to imgur
        if (isAuthRequired)
        {
          urlRequest.addValue("Client-ID " + ImgurAPIKeys.clientId, forHTTPHeaderField: "Authorization")
         }
       
        var requestData = Data()
        
        //We are sending below 4 Values to server
        //1-image data
        
        //Below 3 fields are optional (We can skip them)
        //2-filename
        //3-name
        //4-description
  
        //Content Boundary Start
       requestData.append("--\(boundary + lineBreak)" .data(using: .utf8)!)
        
       //Content Dispostion for "image", it's content type and Value
        requestData.append("content-disposition: form-data; name=\"image\" " .data(using: .utf8)!)
        requestData.append("Content-Type: image/png \(lineBreak + lineBreak)".data(using: .utf8)!)
        requestData.append(request.imgData)
        
        //Content Boundry End
        requestData.append("--\(boundary + lineBreak)" .data(using: .utf8)!)
        
        //Content Dispostion for "filename" and it's value
        requestData.append("content-disposition: form-data; name=\"filename\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
        requestData.append(request.filename .data(using: .utf8)!)
     
        //Content Dispostion for "name" and it's value
        requestData.append("content-disposition: form-data; name=\"name\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
        requestData.append(request.name .data(using: .utf8)!)
        
        //Content Dispostion for "description" and it's value
        requestData.append("content-disposition: form-data; name=\"description\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
        requestData.append("\(request.description + lineBreak)" .data(using: .utf8)!)

        //End Of Main Boundary
        requestData.append("--\(boundary)--\(lineBreak)" .data(using: .utf8)!)
   
        urlRequest.httpBody = requestData
       
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            if(error == nil && data != nil && data?.count != 0)
            {
               do {
                    let response = try JSONDecoder().decode(T.self, from: data!)
                     _=completionHandler(response)
                }
                catch let decodingError {
                    print(String(describing: decodingError))
                }
            }

        }.resume()

    }
}
