//
//  Result.swift
//  com.egco428.a13342
//
//  Created by Kanta'MacPro on 31/10/2561 BE.
//  Copyright © 2561 Kanta'MacPro. All rights reserved.
//

import UIKit

class Result {
    //MARK Properties
    
    var cookiePhoto :UIImage?
    var result : String
    var datetime : String
    var type : String
    
    //MARK Initialization
    
    init?(cookiePhoto: UIImage?,result: String,datetime: String,type: String) {
        
        if result.isEmpty {
            return nil
        }
        
        //MARK Initialize stored properties
        self.cookiePhoto = cookiePhoto
        self.result = result
        self.datetime = datetime
        self.type = type
    }
}
