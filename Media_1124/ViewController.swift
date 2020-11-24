//
//  ViewController.swift
//  Media_1124
//
//  Created by Allie Kim on 2020/11/24.
//

import UIKit
import MobileCoreServices // swift의 모든 데이터타입이 정의되어 있는 .h

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!

    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var captureImage: UIImage!
    var flagImageSave = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // 카메라를 실행한다.
    @IBAction func cameraClicked(_ sender: UIBarButtonItem) {
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            flagImageSave = true
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.sourceType = .camera

            present(imagePicker, animated: true, completion: nil)
        }
    }

    // 앨범으로 이동한다.
    @IBAction func albumClicked(_ sender: UIBarButtonItem) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            flagImageSave = false
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.sourceType = .photoLibrary

            present(imagePicker, animated: true, completion: nil)
        }
    }

    // 사진을 찍은 후 앨범에서 사진을 가져온 후에 실행되는 함수이다.
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let mediaType = info[.mediaType] as! NSString
        print(mediaType)
        if mediaType.isEqual(to: kUTTypeImage as NSString as String) {
            captureImage = info[.originalImage] as? UIImage
            if flagImageSave {
                UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
            }
            imageView.image = captureImage
        }
        self.dismiss(animated: true, completion: nil)
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

}

