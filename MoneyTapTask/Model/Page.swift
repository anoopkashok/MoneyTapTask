//
//  Page.swift
//  MoneyTapTask
//
//  Created by Anoop on 12/10/18.
//  Copyright © 2018 Anoop. All rights reserved.
//

import UIKit

class Page: NSObject {
    
    var pageID : String?
    var pageTitle : String?
    var pageDescription : String?
    var pageImageUrl : String?
    
    //Parse json and get page
    
    static func getPageFromJson(json:[String:Any])-> Page{
        
        let page = Page()
        if let title = json["title"] as? String{
            page.pageTitle = title
        }
        
        if let pageid = (json["pageid"] as? NSNumber) {
            let pageIDString = "\(pageid)"
            page.pageID =  pageIDString
        }
        
        if let thumbnail = json["thumbnail"] as? NSDictionary {
            if let imageurl = thumbnail["source"] as? String {
                page.pageImageUrl = imageurl
            }
        }
        
        if let terms = json["terms"] as? NSDictionary {
            if let descriptionArray = terms["description"] as? NSArray {
                if let descriptionText = descriptionArray[0] as? String {
                    page.pageDescription = descriptionText
                }
            }
        }
        
        return page
        
    }
    

}
