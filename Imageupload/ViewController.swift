//
//  ViewController.swift
//  Imageupload
//
//  Created by Umair Ahmed on 24/01/2022.
//

import UIKit

class ViewController: UIViewController {
    let imageManager = ImageManager()
    @IBOutlet weak var uploadedImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.stopactivityIndicator()
    }

    @IBAction func UploadImageAction(_ sender: UIButton) {
        if (!activityIndicator.isHidden)
        {
            print("Uplaoding is in progress")
            return
        }
        self.startactivityIndicator()
        
        if (sender.tag == PressedButton.Base64pressed.rawValue){
            if let senderImgData = (UIImage(named: "base64")?.pngData()){
                imageManager.uploadImageBase64(data: senderImgData) { receivedImageData in
                    
                    //Received data can be nil.So process it on main thread
                    self.processReceivedImageData(receivedImageData: receivedImageData)
                }
            }
        
        } else if (sender.tag == PressedButton.ByteArraypressed.rawValue){
            if let senderImgData = (UIImage(named: "byteArrayImg")?.pngData()){
                imageManager.uploadImageByteArray(data: senderImgData) { receivedImageData in
                    
                    //Received data can be nil.So process it on main thread
                    self.processReceivedImageData(receivedImageData: receivedImageData)
                 }
            }
         
        }else{
         //MultiPart
             if let senderImgData = (UIImage(named: "multiPartImg")?.pngData()){
                 imageManager.uploadImageMultiPart(data: senderImgData) { receivedImageData in
                     
                     //Received data can be nil.So process it on main thread
                     self.processReceivedImageData(receivedImageData: receivedImageData)
                }
             }
         }
    }

    func processReceivedImageData(receivedImageData:Data?){
        DispatchQueue.main.async {
          if(receivedImageData != nil){
            //Server Downloaded image data will assign to ImageView
            self.uploadedImageView.image = UIImage(data: receivedImageData!)
          }
          self.stopactivityIndicator()
        }
    }
    
    func startactivityIndicator(){
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        uploadedImageView.image = UIImage(named: "placeHolderImg")
        
    }
    func stopactivityIndicator(){
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
}




