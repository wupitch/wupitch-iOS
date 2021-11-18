//
//  SignUpCameraVC.swift
//  wupitch
//
//  Created by 김수정 on 2021/11/16.
//

import UIKit

class SignUpCameraVC: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var pictureBtn: UIButton!
    @IBOutlet weak var scanLayerView: UIView!{
        didSet{
            scanLayerView.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var cameraLayer: UIView!{
        didSet{
            self.cameraLayer.backgroundColor = UIColor.black
        }
    }
    
    @IBOutlet weak var cameraView: UIView!
    
    private lazy var imagePickerController: UIImagePickerController = {
        let imagePickers = UIImagePickerController()
        if UIImagePickerController.isCameraDeviceAvailable(.rear) {
            imagePickers.delegate = self
            imagePickers.sourceType = .camera
            imagePickers.view.frame = cameraView.bounds
            imagePickers.allowsEditing = false
            imagePickers.showsCameraControls = false
        }
        return imagePickers
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCameraInView()
        pictureBtn.makeRounded(cornerRadius: nil)
    }
    
    private func addCameraLayerAndScanLayer(){
        // Draw a graphics with a mostly solid alpha channel
        // and a square of "clear" alpha in there.
        UIGraphicsBeginImageContext(self.cameraLayer.bounds.size)
        let cgContext = UIGraphicsGetCurrentContext()
        cgContext?.fill(self.cameraLayer.bounds)
        cgContext?.clear(CGRect(x:self.scanLayerView.frame.origin.x, y:self.scanLayerView.frame.origin.y, width: self.scanLayerView.bounds.width, height: self.scanLayerView.bounds.height))
        let maskImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Set the content of the mask view so that it uses our
        // alpha channel image
        let maskView = UIView(frame: self.cameraLayer.bounds)
        maskView.layer.contents = maskImage?.cgImage
        self.cameraLayer.mask = maskView
    }
    
    private func addCameraInView(){
        // Add the imageviewcontroller to UIView as a subview
        self.cameraView.addSubview((imagePickerController.view))
        self.addCameraLayerAndScanLayer()
    }
    
    @IBAction func touchUpCancelBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func takePhotoButtonTapped(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            self.imagePickerController.takePicture()
        } else{
            print("Error on taking picture")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let width = self.scanLayerView.bounds.width
            let height = self.scanLayerView.bounds.height
            self.fixOrientation(img: image, completion: { fixedImage -> Void in
                self.cropImage(image: fixedImage, to: CGFloat(width / height), completion: { image -> Void in
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard.init(name: "SignUpImagePreview", bundle: nil)
                        guard let dvc = storyboard.instantiateViewController(identifier: "SignUpImagePreviewVC") as? SignUpImagePreviewVC else {return}
                        dvc.image = image
                        self.navigationController?.pushViewController(dvc, animated: true)
                    }
                })
            })
        }
    }
    
    
    func fixOrientation(img: UIImage, completion :@escaping (UIImage)-> ()) {
        DispatchQueue.global(qos: .background).async {
            if (img.imageOrientation == .up) {
                completion(img)
            }
            
            UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
            let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
            img.draw(in: rect)
            
            let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            completion(normalizedImage)
        }
    }
    
    func cropImage(image: UIImage, to aspectRatio: CGFloat,completion: @escaping (UIImage) -> ()) {
        DispatchQueue.global(qos: .background).async {
            
            let imageAspectRatio = image.size.height/image.size.width
            
            var newSize = image.size
            
            if imageAspectRatio > aspectRatio {
                newSize.height = image.size.width * aspectRatio
            } else if imageAspectRatio < aspectRatio {
                newSize.width = image.size.height / aspectRatio
            } else {
                completion (image)
            }
            
            let center = CGPoint(x: image.size.width/2, y: image.size.height/2)
            let origin = CGPoint(x: center.x - newSize.width/2, y: center.y - newSize.height/2)
            
            let cgCroppedImage = image.cgImage!.cropping(to: CGRect(origin: origin, size: CGSize(width: newSize.width, height: newSize.height)))!
            let croppedImage = UIImage(cgImage: cgCroppedImage, scale: image.scale, orientation: image.imageOrientation)
            
            completion(croppedImage)
        }
    }
}

