//
//  ViewController.swift
//  CrimePhotoApp
//
//  Created by 犬 on 2020/05/29.
//  Copyright © 2020 吉井 駿一. All rights reserved.
//

import UIKit
import Photos
import Foundation

class ViewController: UIViewController {

    var tapped = false
    
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var choiceButton: UIButton!
    @IBOutlet weak var sampleImageView: UIImageView!
    @IBOutlet weak var alertLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初期画面でのナビゲーションバーの設定
        navigationController?.navigationBar.barTintColor = .black
        navigationItem.title = "画像選択"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        sampleImageView.layer.borderWidth = 1
        sampleImageView.layer.borderColor = UIColor.gray.cgColor
        sampleImageView.image = UIImage(named: "noimage")!
        
        addImageButton.addTarget(self, action: #selector(tappedAddImageButton), for: .touchUpInside)
        addImageButton.layer.cornerRadius = 15
        addImageButton.layer.borderWidth = 1
        addImageButton.layer.borderColor = UIColor.gray.cgColor
        addImageButton.backgroundColor = .orange
        
        choiceButton.addTarget(self, action: #selector(tappedChoiceButton), for: .touchUpInside)
        choiceButton.layer.cornerRadius = 15
        choiceButton.layer.borderWidth = 1
        choiceButton.layer.borderColor = UIColor.gray.cgColor
        
        alertLabel.textColor = .clear
    }
    
    //画像追加ボタンが押され、カメラロールが開く
    @objc private func tappedAddImageButton(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    //決定ボタンが押され、編集画面に遷移
    @objc private func tappedChoiceButton(){
        let noImage: UIImage = UIImage(named: "noimage")!
        if sampleImageView.image == noImage{
            alertLabel.textColor = .red
        }
        else{
            let storyboard = UIStoryboard.init(name: "EditImage", bundle: nil)
            let editImageViewController = storyboard.instantiateViewController(withIdentifier: "EditImageViewController") as! EditImageViewController
            
            //ここで画像の情報を編集画面に渡したい
            
            editImageViewController.fakeImageView.image = sampleImageView.image!
            
            navigationController?.pushViewController(editImageViewController, animated: true)
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        alertLabel.textColor = .clear
        choiceButton.layer.backgroundColor = UIColor.orange.cgColor
        
        if let editedImage = info[.editedImage] as? UIImage{

            sampleImageView.image = editedImage
        }
        else if let originalImage = info[.originalImage] as? UIImage{
            
            sampleImageView.image = originalImage
        }
        
        
        sampleImageView.contentMode = .scaleAspectFill
        
        addImageButton.setTitle("画像を変更", for: .normal)
        dismiss(animated: true, completion: nil)
    }
}

