//
//  ViewController.swift
//  camera
//
//  Created by MAC on 15/02/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    let imagePicker = UIImagePickerController()
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
    
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let userPickedImage = info[UIImagePickerController.InfoKey.editedImage]
        imgView.image = userPickedImage as? UIImage
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    func proceedWithCameraAccess(){
        let cameraMediaType = AVMediaType.video
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: cameraMediaType)

        switch cameraAuthorizationStatus {
        case .authorized:
            self.openCamera()
        case .notDetermined, .denied, .restricted:
            // Prompting user for the permission to use the camera.
            AVCaptureDevice.requestAccess(for: cameraMediaType) { granted in
                if granted {
                    print("Granted access to \(cameraMediaType)")
                    self.openCamera()
                } else {
                    print("Denied access to \(cameraMediaType)")
                }
            }
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

     
     
     */

    
    @IBAction func btnCamera(_ sender: UIButton) {
//    present(imagePicker, animated: true, completion: nil)
        proceedWithCameraAccess()
    }
    
    
   
    
    @IBAction func btnGallery(_ sender: UIButton) {
        
        openGallary()
    
    }
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
        }else{
            let alertController = UIAlertController.init(title: "Paaji camera hai ni ga", message: "Bund marao", preferredStyle: .alert)
            alertController.addAction(UIAlertAction.init(title: "Mara lai bund", style: .default, handler: { (success) in
                //do nothing
            }))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    func openGallary()
      {
          imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(imagePicker, animated: true, completion: nil)
      }

    
    @IBAction func btnSavedImages(_ sender: UIButton) {
   
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                  print("Button capture")

                  imagePicker.delegate = self
                  imagePicker.sourceType = .savedPhotosAlbum
                  imagePicker.allowsEditing = false

                  present(imagePicker, animated: true, completion: nil)
              }
          }

          func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
              self.dismiss(animated: true, completion: { () -> Void in

              })

              imgView.image = image
          }
      }
    

      
           


