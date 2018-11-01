//
//  Result.swift
//  com.egco428.a13342
//
//  Created by Kanta'MacPro on 31/10/2561 BE.
//  Copyright © 2561 Kanta'MacPro. All rights reserved.
//

import UIKit
import os.log

class Result: NSObject, NSCoding {
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("results")
    
    //MARK Properties
    
    var cookiePhoto :UIImage?
    var result : String
    var datetime : String
    var type : String
    
    //MARK: Types
    struct PropertyKey {
        static let photo = "cookiePhoto"
        static let result = "result"
        static let datetime = "datetime"
        static let type = "type"
    }
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
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(cookiePhoto, forKey: PropertyKey.photo)
        aCoder.encode(result, forKey: PropertyKey.result)
        aCoder.encode(datetime, forKey: PropertyKey.datetime)
        aCoder.encode(type, forKey: PropertyKey.type)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let result = aDecoder.decodeObject(forKey: PropertyKey.result) as? String else {
            os_log("Unable to decode the name for a cookie object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let cookiePhoto = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        guard let datetime = aDecoder.decodeObject(forKey: PropertyKey.datetime) as? String else {
            os_log("Unable to decode the name for a cookie datetime.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let type = aDecoder.decodeObject(forKey: PropertyKey.type) as? String else {
            os_log("Unable to decode the name for a cookie type.", log: OSLog.default, type: .debug)
            return nil
        }
        
        
        // Must call designated initializer.
        
        self.init(cookiePhoto: cookiePhoto, result: result, datetime: datetime, type: type)
    }
    
}
