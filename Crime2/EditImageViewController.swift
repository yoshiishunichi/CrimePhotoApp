//
//  EditImageViewController.swift
//  CrimePhotoApp
//
//  Created by 犬 on 2020/05/29.
//  Copyright © 2020 吉井 駿一. All rights reserved.
//

import Foundation
import UIKit

class EditImageViewController: UIViewController, UIGestureRecognizerDelegate{
    
    @IBOutlet var allView: UIView!
    
    @IBOutlet weak var choicedImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    var fakeImageView = UIImageView(image: nil)
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var jobTextField: UITextField!
    
    @IBOutlet weak var crimeLabel: UILabel!
    @IBOutlet weak var crimeTextField: UITextField!
    
    @IBOutlet weak var spaceAlertLabel: UILabel!
    @IBOutlet weak var ageAlertLabel: UILabel!
    
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        choicedImageView.image = fakeImageView.image
        choicedImageView.layer.borderWidth = 1
        choicedImageView.layer.borderColor = UIColor.gray.cgColor
        
        createButton.layer.cornerRadius = 45
        createButton.layer.borderWidth = 1
        createButton.layer.borderColor = UIColor.black.cgColor
        createButton.layer.backgroundColor = UIColor.gray.cgColor
        
        spaceAlertLabel.textColor = .clear
        ageAlertLabel.textColor = .clear
        
        nameTextField.textColor = .black
        ageTextField.textColor = .black
        jobTextField.textColor = .black
        crimeTextField.textColor = .black
        
        navigationItem.title = "情報入力"
        
        createButton.addTarget(self, action: #selector(tappedCreatButton), for: .touchUpInside)
        
        allView.isUserInteractionEnabled = true
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(EditImageViewController.tapped(_:)))
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
    
    //これで、キーボードをキーボードの外タップして消せる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    //createButtonが押されてリザルトに遷移
    @objc private func tappedCreatButton(){
        
        let age = ageTextField.text!
        
        if age != "" && Int(age) == nil{
            ageAlertLabel.textColor = .red
            createButton.layer.backgroundColor = UIColor.gray.cgColor
        }
        else {
            ageAlertLabel.textColor = .clear
        }
        
        if (nameTextField.text! == "" || ageTextField.text! == "" || jobTextField.text! == "" || crimeTextField.text == "" ){
            spaceAlertLabel.textColor = .red
            createButton.layer.backgroundColor = UIColor.gray.cgColor
        }
        else {
            spaceAlertLabel.textColor = .clear
        }
        if nameTextField.text! != "" && ageTextField.text! != "" && jobTextField.text! != "" && crimeTextField.text != ""  && Int(age) != nil
        {
            ageAlertLabel.textColor = .clear
            spaceAlertLabel.textColor = .clear
            createButton.layer.backgroundColor = UIColor.green.cgColor
            
            let storyboard = UIStoryboard.init(name: "Result", bundle: nil)
            let resultViewController = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
            
            //画像を渡す
            resultViewController.receiveImage = choicedImageView.image
            
            //テキストを渡す
            resultViewController.receiveName = nameTextField.text!
            resultViewController.receiveAge = ageTextField.text!
            resultViewController.receiveJob = jobTextField.text!
            resultViewController.receiveCrime = crimeTextField.text!
            
            navigationController?.pushViewController(resultViewController, animated: true)
        }
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer){
        let age = ageTextField.text!
        if age != "" && Int(age) == nil{
            ageAlertLabel.textColor = .red
            createButton.layer.backgroundColor = UIColor.gray.cgColor
        }
        else {
            ageAlertLabel.textColor = .clear
        }
        
        if (nameTextField.text! == "" || ageTextField.text! == "" || jobTextField.text! == "" || crimeTextField.text == "" ){
            spaceAlertLabel.textColor = .red
            createButton.layer.backgroundColor = UIColor.gray.cgColor
        }
        else {
            spaceAlertLabel.textColor = .clear
        }
        if nameTextField.text! != "" && ageTextField.text! != "" && jobTextField.text! != "" && crimeTextField.text != ""  && Int(age) != nil{
            spaceAlertLabel.textColor = .clear
            ageAlertLabel.textColor = .clear
            createButton.layer.backgroundColor = UIColor.green.cgColor
        }
    }
}
