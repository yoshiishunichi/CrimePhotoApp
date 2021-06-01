//
//  ResultViewController.swift
//  CrimePhotoApp
//
//  Created by 犬 on 2020/05/30.
//  Copyright © 2020 吉井 駿一. All rights reserved.
//

import Foundation
import UIKit
import Accounts
import StoreKit


class ResultViewController: UIViewController{
    
    var receiveImage: UIImage!
    var receiveName = ""
    var receiveAge = ""
    var receiveJob = ""
    var receiveCrime = ""
    
    @IBAction func kakinButton(_ sender: Any) {
        let url = URL(string: "https://www.amazon.co.jp/hz/wishlist/ls/32D14CNNFVFWT?ref_=wl_share")!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    @IBOutlet weak var sampleImageView: UIImageView!
    
    @IBAction func showActivityView(_ sender: UIBarButtonItem) {
        
        let controller = UIActivityViewController(activityItems: [sampleImageView.image!, "”容疑者画像メーカー”で容疑者画像を作成したよ！\n#容疑者画像メーカー"], applicationActivities: nil)
        controller.popoverPresentationController?.sourceView = self.view
        controller.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0, width: 1.0, height: 1.0)
        self.present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "作成結果"
        
        //EditImageViewControllerからデータを受け取っていく
        let name = receiveName
        let age = "(" + receiveAge + ")"
        let job = receiveJob
        let crime = receiveCrime + "の疑い"
        let backgroundImage: UIImage = UIImage(named: "back")!
        
        let gi = "容疑者"
        
        //背景と犯人の写真を合成したImageを作成
        let reSizeCrime = CGSize(width: backgroundImage.size.height, height: backgroundImage.size.height)
        let crimeImage = receiveImage.reSizeImage(reSize: reSizeCrime)
        sampleImageView.image = backgroundImage.setBackground(image: crimeImage)
        var sampleImage = sampleImageView.image
        sampleImageView.layer.borderWidth = 1
        sampleImageView.layer.borderColor = UIColor.gray.cgColor
        
        //画像のサイズ取得
        let imageWidth = sampleImage!.size.width
        print("imagewidth:", imageWidth)
        let para = imageWidth / 500
        let imageHeight = sampleImage!.size.height
        //範囲の指定
        let rect = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        //imagecontext
        UIGraphicsBeginImageContextWithOptions(sampleImage!.size, false, 0)
        //画像をさっきの範囲に入れる
        sampleImage!.draw(in: rect)
        
        // 文字列のフォント指定
        let nameFont = UIFont.boldSystemFont(ofSize: 28 * para)
        let jobFont = UIFont.boldSystemFont(ofSize: 18 * para)
        let giFont = jobFont
        let ageFont = jobFont
        let crimeFont = jobFont
        
        //名前を入れる
        let nameCount = (name as NSString).length
        let nameWidth = ((CGFloat(nameCount) * 29 ) + CGFloat(5  * (nameCount-1))) * para
        let nameHeight = CGFloat(29) * para
        //nameの描画範囲
        let nameRect = CGRect(x: imageWidth/2 - nameWidth / 2 , y: imageHeight - nameHeight * 1.8, width: nameWidth, height: nameHeight)
        let nameStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        let nameFontAttributes = [
            NSAttributedString.Key.font: nameFont,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.paragraphStyle: nameStyle,
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.strokeWidth: -3.0 * para,
            NSAttributedString.Key.kern: 5.0 * para
            ] as [NSAttributedString.Key : Any]
        let attrName = NSAttributedString(string: name, attributes: nameFontAttributes as [NSAttributedString.Key : Any])
        attrName.draw(in: nameRect)
        var newImage = UIGraphicsGetImageFromCurrentImageContext();
        sampleImageView.image = newImage
        
        //職業を入れる
        let jobCount = (job as NSString).length
        let jobWidth = ((CGFloat(jobCount) * 18) + CGFloat(jobCount)) * para
        let jobHeight = CGFloat(18.5) * para
        //jobの描画範囲
        let jobRect = CGRect(x: (imageWidth/2 - nameWidth / 2) - jobWidth , y: imageHeight - nameHeight * 1.8 + jobHeight / 3, width: jobWidth, height: jobHeight)
        let jobStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        let jobFontAttributes = [
            NSAttributedString.Key.font: jobFont,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.paragraphStyle: jobStyle,
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.strokeWidth: -3 * para,
            NSAttributedString.Key.kern: 0.1 * para
            ] as [NSAttributedString.Key : Any]
        let attrJob = NSAttributedString(string: job, attributes: jobFontAttributes as [NSAttributedString.Key : Any])
        attrJob.draw(in: jobRect)
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        sampleImageView.image = newImage
        
        //"容疑者"を入れる
        let giWidth = (CGFloat(3 * 18.2) + CGFloat(3.0)) * para
        let giHeight = jobHeight
        //"容疑者"の描画範囲
        let giRect = CGRect(x: (imageWidth/2 + nameWidth / 2)  , y: imageHeight - nameHeight * 1.5, width: giWidth, height: giHeight)
        let giStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        let giFontAttributes = [
            NSAttributedString.Key.font: giFont,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.paragraphStyle: giStyle,
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.strokeWidth: -3 * para,
            NSAttributedString.Key.kern: 0.1 * para
            ] as [NSAttributedString.Key : Any]
        let attrGi = NSAttributedString(string: gi, attributes: giFontAttributes as [NSAttributedString.Key : Any])
        attrGi.draw(in: giRect)
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        sampleImageView.image = newImage
        
        //年齢を入れる
        let ageCount = (age as NSString).length
        let ageWidth = ((CGFloat(ageCount) * 18) + CGFloat(Double((ageCount - 1)))) * para
        let ageHeight = jobHeight
        //jobの描画範囲
        let ageRect = CGRect(x: (imageWidth/2 + nameWidth / 2) + giWidth , y: imageHeight - nameHeight * 1.5, width: ageWidth, height: ageHeight)
        let ageStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        let ageFontAttributes = [
            NSAttributedString.Key.font: ageFont,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.paragraphStyle: ageStyle,
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.strokeWidth: -3 * para
            ] as [NSAttributedString.Key : Any]
        let attrAge = NSAttributedString(string: age, attributes: ageFontAttributes as [NSAttributedString.Key : Any])
        attrAge.draw(in: ageRect)
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        sampleImageView.image = newImage
        sampleImage = sampleImageView.image
        
        //「逮捕」画像を入れる
        let taihoImage: UIImage = UIImage(named: "taiho")!
        let reSizeTaiho = CGSize(width: 37.0 * para, height: 18.5 * para)
        let reSizedTaiho = taihoImage.reSizeImage(reSize: reSizeTaiho)
        sampleImageView.image = sampleImage?.setTaiho(image: reSizedTaiho, x: (imageWidth / 2 - nameWidth / 2) - jobWidth, y: imageHeight - nameHeight * 1.8 - 19 * para, para:para)
        
        //容疑を入れる
        let crimeCount = (crime as NSString).length
        let crimeWidth = ((CGFloat(crimeCount) * 18) + CGFloat(1  * Double((crimeCount - 1)))) * para
        let crimeHeight = CGFloat(19) * para
        //crimeの描画範囲
        let crimeRect = CGRect(x: imageWidth / 2 - nameWidth / 2 - jobWidth + 39 * para, y: imageHeight - nameHeight * 1.8 - 20 * para, width: crimeWidth, height: crimeHeight)
        let crimeStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        let crimeFontAttributes = [
            NSAttributedString.Key.font: crimeFont,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.paragraphStyle: crimeStyle,
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.strokeWidth: -3 * para,
            NSAttributedString.Key.kern: 1 * para
            ] as [NSAttributedString.Key : Any]
        let attrCrime = NSAttributedString(string: crime, attributes: crimeFontAttributes as [NSAttributedString.Key : Any])
        attrCrime.draw(in: crimeRect)
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        sampleImageView.image = newImage
        sampleImage = sampleImageView.image
        UIGraphicsEndImageContext()
        
        
        // 右上にロゴ入れる
        let logo: UIImage = UIImage(named: "ロゴ")!
        sampleImageView.image = sampleImage?.setLogo(image: logo, x: imageWidth - (36 + 10) * para, y: 10 * para, para: para)
    }
}

extension UIImage{
    
    //指定されたサイズにリサイズ
    func reSizeImage(reSize: CGSize) -> UIImage{
        
        UIGraphicsBeginImageContextWithOptions(reSize, false, UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        let reSizedImage: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return reSizedImage
    }
    
    func setBackground(image: UIImage) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(CGSize(width: self.size.width, height: self.size.height), false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        image.draw(in: CGRect(x: (self.size.width - self.size.height) / 2 , y: 0, width: self.size.height, height: self.size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        return newImage
    }
    
    func setTaiho(image: UIImage, x: CGFloat, y: CGFloat, para: CGFloat) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(CGSize(width: self.size.width, height: self.size.height), false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        image.draw(in: CGRect(x: x , y: y, width: 37.0 * para, height: 18.5 * para))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        return newImage
    }
    
    func setLogo(image: UIImage, x: CGFloat, y: CGFloat, para: CGFloat) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(CGSize(width: self.size.width, height: self.size.height), false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        image.draw(in: CGRect(x: x , y: y, width: 36.0 * para, height: 24.0 * para))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        return newImage
    }
    
}
