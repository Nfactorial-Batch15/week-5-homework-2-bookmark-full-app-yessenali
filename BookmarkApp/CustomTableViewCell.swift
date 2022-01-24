//
//  CustomTableViewCell.swift
//  BookmarkUIKit
//
//  Created by Yessenali Zhanaidar on 22.01.2022.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    let image = UIImage(named: "btn")
    
    private let customView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "bgColor")
        return view
    }()
    
    private let navTitle: UILabel = {
        let title = UILabel()
        title.text = "List"
        title.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return title
    }()
    
    private var linkLabel: UILabel = {
        let linkLabel = UILabel()
        return linkLabel
    }()
    
    public let linkBtn: UIButton = {
        let button = UIButton()
        let image: UIImage? = UIImage(named: "btn")
        button.setImage(image, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(linkButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var myLink = ""
    
    func configure(data: String, link: String) {
        linkLabel.text = data
        myLink = link
    }
    
    func openLink() {
        if let url = URL(string: myLink) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func linkButtonPressed() {
        openLink()
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setUI() {
        
        self.addSubview(customView)
        
        customView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-2)
            make.top.equalToSuperview().offset(1)
            make.height.equalTo(74)
        }
        
        
        
        customView.addSubview(linkLabel)
        linkLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(40)
        }
        
        customView.addSubview(linkBtn)
        linkBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.top.equalToSuperview().offset(40)
        }
    }
}
