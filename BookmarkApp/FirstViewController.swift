//
//  FirstScreen.swift
//  BookmarkApp
//
//  Created by Yessenali Zhanaidar on 17.01.2022.
//

import UIKit
import SnapKit

class FirstViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        self.navigationController?.navigationBar.barStyle = .default
//        return .lightContent
//    }
    
    private func initialize() {
        
        let imageName = "image"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(390)
            make.height.equalTo(614)
        }
        
        let label = UILabel()
        label.text = "Save all interesting\nlinks in one app"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.numberOfLines = 0
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(358)
            make.height.equalTo(92)
            make.bottom.equalToSuperview().inset(132)
        }
        
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        button.setTitle("Let's start collecting", for: .normal)
        button.setTitleColor(.black, for: .normal)
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.width.equalTo(358)
            make.height.equalTo(58)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
        button.addTarget(self, action: #selector(startButton), for: .touchUpInside)
    }
    
    @objc func startButton() {
        let showVC = ListViewController()
        self.navigationController?.pushViewController(showVC, animated: true)
    }
    
}

//extension FirstViewController
//{
//    override open var preferredStatusBarStyle: UIStatusBarStyle {
//        get {
//            return .lightContent
//        }
//    }
//}
