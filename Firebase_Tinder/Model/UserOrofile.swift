//
//  UserOrofile.swift
//  Firebase_Tinder
//
//  Created by Ripon sk on 20/11/22.
//

import Foundation
struct UserProfile{
    var Uid:String?
    var firstName:String?
    var lastName:String?
    var emailId:String?
    var Profileimage:String?
    var status: String?
    init(Uid: String? = nil, firstName: String? = nil, lastName: String? = nil, emailId: String? = nil, Profileimage: String? = nil, status: String? = nil) {
        self.Uid = Uid
        self.firstName = firstName
        self.lastName = lastName
        self.emailId = emailId
        self.Profileimage = Profileimage
        self.status = status
    }
}
