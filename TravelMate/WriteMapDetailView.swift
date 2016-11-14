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
    @IBOutlet weak var descriptionText: UITextView!
    
    @IBOutlet weak var travelStartDay: UITextField!
    @IBOutlet weak var travelEndDay: UITextField!
    @IBOutlet weak var RecruitStartDay: UITextField!
    @IBOutlet weak var RecruitEndDay: UITextField!
    
    let dateFormat = "yyyy-MM-dd"
    
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
        initDateText()
    }
    
    @IBAction func tapGestureAction(_ sender: AnyObject) {
        self.endEditing(true)
    }
    
    /*
     * 날짜 텍스트 클릭 -> DatePicker 호출
     */
    @IBAction func datePickerMake(_ sender: UITextField) {
        print("click")
        
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: UIControlEvents.valueChanged)
    }
    
    /*
     * DatePicker에서 날짜 선택 -> 날짜 텍스트 세팅
     */
    func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        RecruitEndDay.text = dateFormatter.string(from: sender.date)
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
}
