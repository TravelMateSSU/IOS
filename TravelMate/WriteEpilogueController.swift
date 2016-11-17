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
    
    let networkManager = NetworkManager()
    
    @IBOutlet weak var writeEpilogueView: WriteEpilogueView!
    
    @IBAction func writeCompletionPressed(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
    @IBAction func submitPressed(_ sender: UIBarButtonItem) {
        
        if writeEpilogueView.epilogue.contents == nil {
            errorMessage()
            return
        } else {
            let trim: String = writeEpilogueView.epilogue.contents.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            
            if trim.isEmpty{
                errorMessage()
                return
            }
        }
        
        networkManager.requestEpilogueInsertion(epilogue: writeEpilogueView.epilogue, {
            code in
            if code == 200 {
                print("성공")
                SweetAlert().showAlert(title: "후기가 등록되었습니다!", subTitle: "", style: .Success, buttonTitle: "확인", action: { Void in
                    self.dismiss(animated: true, completion: nil)
                })

            } else {
                SweetAlert().showAlert(title: "후기 등록에 실패하였습니다.", subTitle: "다시 시도해주세요(ㅠㅠ)", style: .Error)
            }
        })
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
    
    func errorMessage(){
        SweetAlert().showAlert(title: "후기 등록에 실패하였습니다.", subTitle: "공란없이 후기를 작성해주세요.", style: .Warning)
    }
}
