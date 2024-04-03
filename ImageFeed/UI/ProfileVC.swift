//
//  Profile.swift
//  ImageFeed
//
//  Created by Artem on 20.03.2024.
//

import UIKit

final class ProfileVC: UIViewController {
    
    private lazy var userPhoto: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "UserPhoto")
        return image
    }()
    
    private lazy var userName: UILabel = {
        let label = UILabel()
        label.text = "user name"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var userNickname: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "@user nickname"
        label.font = .systemFont(ofSize: 13, weight: .thin)
        return label
    }()
    
    private lazy var userStatus: UILabel = {
        let label = UILabel()
        label.text = "Hello world"
        label.textColor = .white
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Exit"), for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        let views = [userPhoto, userName, userNickname, userStatus, logoutButton]
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
                userPhoto.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
                userPhoto.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                userPhoto.widthAnchor.constraint(equalToConstant: 70),
                userPhoto.heightAnchor.constraint(equalToConstant: 70),

                userName.topAnchor.constraint(equalTo: userPhoto.bottomAnchor, constant: 8),
                userName.leadingAnchor.constraint(equalTo: userPhoto.leadingAnchor),

                userNickname.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 8),
                userNickname.leadingAnchor.constraint(equalTo: userPhoto.leadingAnchor),

                userStatus.topAnchor.constraint(equalTo: userNickname.bottomAnchor, constant: 8),
                userStatus.leadingAnchor.constraint(equalTo: userPhoto.leadingAnchor),

                logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55),
                logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}
