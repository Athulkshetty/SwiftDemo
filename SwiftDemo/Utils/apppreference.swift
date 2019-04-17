//
//  apppreference.swift
//  SwiftDemo
//
//  Created by LCode Technologies on 28/11/18.
//  Copyright © 2018 Lcodetechnologies. All rights reserved.
//

import UIKit

class apppreference: NSObject {
  var userID:NSString = "";
    
    func getUserID() -> NSString
    {
        return  userID;
    }
    func setUserID(name:NSString) -> Void
    {
        userID = name;

    }
    
    func languageSelectedStringForKey(key:NSString) -> NSString
    {
        let bundlepath:NSString?
        bundlepath = Bundle.main.path(forResource: "", ofType: "lproj")! as NSString
        let languageBundle:Bundle = Bundle(path: bundlepath! as String)!
        let str:NSString = languageBundle.localizedString(forKey: key as String, value: "", table: nil) as NSString
        return str
    }

}
