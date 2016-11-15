//
//  WriteMapDetailView.swift
//  TravelMate
//
//  Created by 김혜지 on 2016. 11. 10..
//  Copyright © 2016년 이동규. All rights reserved.
//

import UIKit

class WriteMapDetailView: UIView {
    @IBOutlet weak var enrollButton: UIButton!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var maxPeople: UITextField!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var descriptionText: UITextView!
    
    @IBOutlet weak var travelStartDay: UITextField!
    @IBOutlet weak var travelEndDay: UITextField!
    @IBOutlet weak var RecruitStartDay: UITextField!
    @IBOutlet weak var RecruitEndDay: UITextField!
    
    let dateFormat = "yyyy-MM-dd"
    let descriptionPlaceHolder = "ex) 저와 같이 여행가실 분 구해요!"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInitialization()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInitialization()
    }
    
    func commonInitialization(){
        let view = Bundle.main.loadNibNamed("WriteMapDetailView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        
        viewInit()
    }
    
    func viewInit(){
        initTag()
        
        initDateText()
        
        initTextView()
    }
    
    func initTag(){
        travelStartDay.tag = 1
        travelEndDay.tag = 2
        RecruitEndDay.tag = 3
    }
    
    @IBAction func tapGestureAction(_ sender: AnyObject) {
        self.endEditing(true)
    }
    
    /*
     * 날짜 텍스트 클릭 -> DatePicker 호출
     */
    @IBAction func datePickerMake(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        
        datePickerView.tag = sender.tag
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: UIControlEvents.valueChanged)
    }
    
    /*
     * DatePicker에서 날짜 선택 -> 날짜 텍스트 세팅
     */
    func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        var selectedDay = dateFormatter.string(from: sender.date)
        
        switch sender.tag {
        case travelStartDay.tag:
            travelStartDay.text = selectedDay
        case travelEndDay.tag:
            travelEndDay.text = selectedDay
        case RecruitEndDay.tag:
            RecruitEndDay.text = selectedDay
        default:
            return
        }
    }
    
    /*
     * 날짜 텍스트 오늘 날짜로 세팅.
     */
    func initDateText(){
        let todaysDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let DateInFormat = dateFormatter.string(from: todaysDate)
        
        travelStartDay.text = DateInFormat
        travelEndDay.text = DateInFormat
        RecruitStartDay.text = DateInFormat
        RecruitEndDay.text = DateInFormat
    }
    
    func initTextView(){
        descriptionText.delegate = self
        descriptionText.text = descriptionPlaceHolder
        descriptionText.textColor = UIColor.lightGray
    }
    
    @IBAction func stepperForPeopleCount(_ sender: UIStepper) {
        maxPeople.text = Int(sender.value).description
    }
}

extension WriteMapDetailView: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == descriptionPlaceHolder{
            textView.text = ""
            textView.textColor = UIColor.black
        }
        
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == ""{
            textView.text = descriptionPlaceHolder
            textView.textColor = UIColor.lightGray
        }
        
        textView.resignFirstResponder()
    }
}
