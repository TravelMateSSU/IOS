//
//  WriteEpilogue.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 10. 28..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

// 후기 작성 뷰컨트롤러
class WriteEpilogueViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, ImagePickDelegate {
    
    @IBOutlet weak var writeEpilogueView: WriteEpilogueView!
    
    @IBAction func submitPressed(_ sender: UIBarButtonItem) {
        let networkManager = NetworkManager()
        networkManager.insertEpilogue(epilogue: writeEpilogueView.epilogue) { (err, code) in
            if err {
                print("실패")
            } else {
                print("성공")
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        writeEpilogueView.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            writeEpilogueView.imagePick(image: pickedImage)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickPressed(imagePicker: UIImagePickerController) {
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
}
