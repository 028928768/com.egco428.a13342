//
//  MessageDB.swift
//  com.egco428.a13342
//
//  Created by Kanta'MacPro on 2/11/2561 BE.
//  Copyright © 2561 Kanta'MacPro. All rights reserved.
//

import UIKit
import os.log

class MessageDB {
    
    //MARK: Archiving Paths
  //  static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
  //  static let ArchiveURL = DocumentsDirectory.appendingPathComponent("results")
    
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
 
    
    
}

