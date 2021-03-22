//
//  User.swift
//  SNDKGroupPractical
//
//  Created by Manish Sharma on 21/03/21.
//  Copyright © 2021 Manish Sharma. All rights reserved.
//

import Foundation

// MARK: - UserResponse
struct UserResponse: Decodable {
    let status, message, webpage: String?
    let response: Response?
}

// MARK: - Response
struct Response: Decodable {
    let table1: [Table1]?
}

// MARK: - Table1
struct Table1: Decodable {
    let userdisplayname: String?
}

