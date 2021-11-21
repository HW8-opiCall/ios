//
//  UserModel.swift
//  opiCall (iOS)
//
//  Created by Min Jae Lee on 2021-11-20.
//

import Foundation

struct UserModel: Codable {
    let uid: String?
    let name: String?
    let address: String?
    let have_naloxone: Bool?
}
