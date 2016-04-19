//
//  ViewController.swift
//  webrequest-test
//
//  Created by Admin on 19/4/16.
//  Copyright © 2016 Dreamsmart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "http://swapi.co/api/people/1/"
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        
        session.dataTaskWithURL(url) { (data: NSData?, response:
            NSURLResponse?, error: NSError?) -> Void in
            
            if let responseData = data {
                
                do {
                
                    let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
                    
                    if let dict = json as? Dictionary<String, AnyObject> {
                        //print("DID WE GET HERE: \(dict.debugDescription)")
                        
                        if let name = dict["name"] as? String, let height = dict["height"] as? String, let birth = dict["birth_year"] as? String, let hair = dict["hair_color"] as? String {
                            
                            let person = SWPerson(name: name, height: height, birthYear: birth, hairColor: hair)
                            
                            print(person.name)
                            print(person.height)
                            print(person.hairColor)
                            print(person.birthYear)
                            
                            if let films = dict["films"] as? [String] {
                                for film in films {
                                    print(film)
                                }
                            }
                        }
                    }
                    
                   // print(json)
                }
                
                catch {
                    print("Could not serialize")
                }
     
            }
            
            
        }.resume()
    }

  
}

