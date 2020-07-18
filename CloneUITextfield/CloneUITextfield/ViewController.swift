//
//  ViewController.swift
//  CloneUITextfield
//
//  Created by sapere4ude on 2020/07/12.
//  Copyright © 2020 sapere4ude. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myTextFiled: UITextField!
    @IBOutlet weak var myTextFiled2: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTextFiled.font = UIFont(name: "HelveticaNeue-Thin", size: 13)
        self.myTextFiled.keyboardType = .numberPad
        self.myTextFiled.borderStyle = .bezel
        self.myTextFiled2.isSecureTextEntry = true
        self.myTextFiled2.borderStyle = .line
        
        self.myTextFiled.delegate = self
        self.myTextFiled.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    @objc func textFieldDidChange(_ textField: UITextField){
        print("입력된 글자 : \(String(describing: self.myTextFiled.text))")
    }

}

extension ViewController:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textField 편집 시작!")
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField, _ textField2: UITextField) {  // 파라미터 2개 넣는 것 안됨
      func textFieldDidEndEditing(_ textField: UITextField) {
        print("textField 편집 종료!")
    }
}

