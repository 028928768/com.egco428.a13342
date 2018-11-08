//
//  MessageDB.swift
//  com.egco428.a13342
//
//  Created by Kanta'MacPro on 2/11/2561 BE.
//  Copyright © 2561 Kanta'MacPro. All rights reserved.
//

import UIKit
import os.log

class MessageDB: NSObject, NSCoding {
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Messages")
    
    //MARK Properties
    
    var cookieMessage : String
    var cookieType : String
    
    //MARK: Types
    struct PropertyKey {
        static let message = "cookieMessage"
        static let type = "cookieType"
   
    }
    //MARK Initialization
    
    init? (cookieMessage: String,cookieType: String){
        if cookieMessage.isEmpty {
            return nil
        }
        self.cookieMessage = cookieMessage
        self.cookieType = cookieType
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(cookieMessage, forKey: PropertyKey.message)
        aCoder.encode(cookieType, forKey: PropertyKey.type)
    }
    //
    required convenience init?(coder aDecoder: NSCoder) {
        //The message is required. if we cannot decode a message string, the initializer shoud fail.
        guard let message = aDecoder.decodeObject(forKey: PropertyKey.message) as? String else {
            os_log("Unable to decode the message for a cookie object.", log:OSLog.default, type: .debug)
            return nil
        }
        //decoder for type
        guard let type = aDecoder.decodeObject(forKey: PropertyKey.type) as? String else {
            os_log("Unable to decode the type for a cookie object.", log:OSLog.default, type: .debug)
            return nil
        }
        self.init(cookieMessage: message, cookieType: type)
    }
 
    
    
}

