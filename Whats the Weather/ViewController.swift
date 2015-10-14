//
//  ViewController.swift
//  Whats the Weather
//
//  Created by Jena Grafton on 10/14/15.
//  Copyright © 2015 Bella Voce Productions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var cityTextField: UITextField!
    
    @IBOutlet var resultLabel: UILabel!
    
    @IBAction func findWeather(sender: AnyObject) {
        
        let url = NSURL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text! + "/forecasts/latest")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            if let urlContent = data {
                
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                //print(webContent)
                
                let websiteArray = webContent!.componentsSeparatedByString("Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                if websiteArray.count > 0 {
                    
                    let weatherArray = websiteArray[1].componentsSeparatedByString("</span>")
                    
                    //print(weatherArray[0])
                    
                    if weatherArray.count > 0 {
                        
                        let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            
                            self.resultLabel.text = weatherSummary
                            
                        })
                        
                        
                        
                    }
                    
                }
                
                
                
                
                
            }
        }
        
        task.resume()
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

