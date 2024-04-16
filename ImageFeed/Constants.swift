//
//  Constants.swift
//  ImageFeed
//
//  Created by Artem on 14.04.2024.
//

import Foundation

enum Constants {
    static let accessKey = "EtTozn18OYAj-Nh0DW7V16BGSexGfA2z_Mdl60gqicg"
    static let secretKey = "EtTozn18OYAj-Nh0DW7V16BGSexGfA2z_Mdl60gqicg"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    
    static let accessScope = "public+read_user+write_likes"
    static let defaultBaseURL = URL(string: "https://api.unsplash.com")
}
