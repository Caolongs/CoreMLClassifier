//
//  ViewController.swift
//  CMLFlowerClassifier
//
//  Created by cao longjian on 2017/11/1.
//  Copyright © 2017年 cao longjian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
    let model = MobileNet()
    lazy var picker: UIImagePickerController = {
        let picker = UIImagePickerController.init()
        picker.delegate = self
        picker.allowsEditing = false
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configView()
        self.diplayDesc()
    }

    private func configView() {
        self.imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.imageTap))
        self.imageView.addGestureRecognizer(tap)
    }
    
    private func diplayDesc() {
        let output = modelOutput()
        let probability = Int(output.classLabelProbs[output.classLabel]! * 100)
        descLabel.text = "I'm \(probability)% sure it's a \(output.classLabel)! "
    }
    
    private func modelOutput() -> MobileNetOutput {
        guard let image = imageView.image else {
            fatalError("No image specified.")
            descLabel.text = "No image specified."
        }
        let scaledImage = image.scaleImage(newSize: CGSize.init(width: 224.0, height: 224.0))
        let buffer = scaledImage!.buffer()!
        guard let output = try? model.prediction(image: buffer) else {
            fatalError("Prediction process failed.")
            descLabel.text = "Prediction process failed."
        }
        return output
    }
    
// MARK: - Action
    @objc func imageTap() -> Void {
        UIAlertController.jj_actionSheetWithTitle(actionArr: ["相机","相册"], cancle: "取消") { (index) in
            self.imagePicker(type: index)
        }
    }
    
    func imagePicker(type:Int) -> Void {
        if type == 0 {
            self.picker.sourceType = .camera
            self.picker.cameraCaptureMode = .photo
        } else {
            self.picker.sourceType = .photoLibrary
        }
        self.present(self.picker, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let scaledImage = chosenImage.scaleImage(newSize: CGSize.init(width: 224.0, height: 224.0))
        self.imageView.image = scaledImage;
        self.diplayDesc()
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UINavigationControllerDelegate
extension ViewController: UINavigationControllerDelegate {
    
}

