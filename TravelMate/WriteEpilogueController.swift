//
//  WriteEpilogue.swift
//  TravelMate
//
//  Created by 이동규 on 2016. 10. 28..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit
import DKImagePickerController

// 후기 작성 뷰컨트롤러
class WriteEpilogueViewController: UIViewController, ImagePickDelegate {
    
    @IBOutlet weak var writeEpilogueView: WriteEpilogueView!
    
    @IBAction func writeCompletionPressed(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
    @IBAction func submitPressed(_ sender: UIBarButtonItem) {
        let networkManager = NetworkManager()
        networkManager.insertEpilogue(epilogue: writeEpilogueView.epilogue) { (err, code) in
            if err {
                // 실패
                print("실패")
            } else {
                // 성공
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        writeEpilogueView.delegate = self
    }
    
    func imagePickPressed() {
        let pickerController = DKImagePickerController()
        pickerController.singleSelect = false
        
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            for asset in assets {
                asset.fetchOriginalImage(false, completeBlock: { (image, hashable) in
                    guard let image = image else {
                        return
                    }
                    
                    self.writeEpilogueView.imagePick(image: image)
                })
            }
        }
        
        self.present(pickerController, animated: true, completion: nil)
    }
}
