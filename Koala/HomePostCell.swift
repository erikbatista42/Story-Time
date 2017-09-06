//
//  HomePostCell.swift
//  Koala
//
//  Created by Erik on 8/7/17.
//  Copyright © 2017 swift.lang.eu. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Player

class HomePostCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            guard let thumbnailUrl = post?.thumbnailUrl else { return }
            photoImageView.loadImage(UrlString: thumbnailUrl)
            
//            usernameLabel.text = "\(post?.user.username ?? "")\n\(timeLabel.attributedText?.string ?? "")"
            usernameLabel.text  = post?.user.username
            
            guard let profileImageUrl = post?.user.profileImageUrl else { return }
            userProfileImageView.loadImage(UrlString: profileImageUrl)
            setupTimeLabel()
        }
    }
    
    let userProfileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let photoImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    let usernameLabel: UILabel = {
        let label = UILabel()
    
        let attributedText = NSMutableAttributedString(string: "", attributes: [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.rgb(red: 59, green: 89, blue: 152, alpha: 1)])
        
        attributedText.append(NSAttributedString(string: "\n1 week ago", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.lightGray]))
        label.numberOfLines = 0
        label.attributedText = attributedText
        return label
    }()
    
    let optionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "optionsButton").withRenderingMode(.alwaysOriginal), for: .normal)
//        button.addTarget(self, action: #selector(handleOptionsButton), for: .touchUpInside)
        return button
    }()
    
    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "heart_icon").withRenderingMode(.alwaysOriginal), for: .normal)
        //button.addTarget(self, action: #selector(handleLikeButton), for: .touchUpInside)
        return button
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.text = "0 likes"
        label.font = UIFont(name: "AvenirNext-Regular", size: 18)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "share_icon").withRenderingMode(.alwaysOriginal), for: .normal)
       // button.addTarget(self, action: #selector(handleShareButton), for: .touchUpInside)
        return button
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "", attributes: [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.rgb(red: 59, green: 89, blue: 152, alpha: 1)])
    
        label.attributedText = attributedText
        return label
    }()
    
    let usernameButton: UIButton = {
       let button = UIButton()
       button.setTitle("username", for: .normal)
        return button
    }()
    
    
    
        override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(usernameButton)
        addSubview(userProfileImageView)
        addSubview(usernameLabel)
        addSubview(optionsButton)
        addSubview(photoImageView)
        addSubview(timeLabel)
        
        usernameButton.anchor(top: topAnchor, left: nil, bottom: photoImageView.topAnchor, right: timeLabel.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            
        userProfileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
            userProfileImageView.layer.cornerRadius = 40/2
            
        usernameLabel.anchor(top: topAnchor, left: userProfileImageView.rightAnchor, bottom: photoImageView.topAnchor, right: optionsButton.leftAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            
        optionsButton.anchor(top: topAnchor, left: nil, bottom: photoImageView.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 44, height: 0)
            
        photoImageView.anchor(top: userProfileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        photoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
            
        
        timeLabel.anchor(top: topAnchor, left: nil, bottom: photoImageView.topAnchor, right: optionsButton.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//            timeLabel.anchor(top: usernameLabel.bottomAnchor?, left: userProfileImageView.rightAnchor, bottom: photoImageView.topAnchor, right: optionsButton.leftAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            
        setupActionButtons()
        
    }
    
    func setupTimeLabel() {
      guard let post = self.post else { return }
        
      let timeAgoDisplay = post.creationDate.timeAgoDisplay()
        let attributedText = NSMutableAttributedString(string: timeAgoDisplay, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName : UIColor.lightGray])
        
        timeLabel.attributedText = attributedText
//        print("this is it:", timeLabel.attributedText?.string)
    }
    
    fileprivate func setupActionButtons() {
        let stackView = UIStackView(arrangedSubviews: [likeButton,likesLabel])
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: photoImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 50)
        addSubview(shareButton)
        shareButton.anchor(top: photoImageView.bottomAnchor, left: nil, bottom:  nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 25, width: 40, height: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



