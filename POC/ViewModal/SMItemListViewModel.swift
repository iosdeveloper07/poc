//
//  SMItemListViewModel.swift
//  POC
//
//  Created by Shashank on 21/07/20.
//  Copyright © 2020 Shashank. All rights reserved.
//

import Foundation
import UIKit

class SMItemListViewModel: NSObject {
    func ItemListAPI (view : UIView, completionHandler: @escaping (_ success: Bool, _ message: String, _ response : ItemListModal?) -> Void) {
        
        DispatchQueue.main.async {
            Loader.showIndicator(withTitle: Constant.KConstant.indicator_title, and: "", and : view)
        }

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: Constant.KConstant.url)!
        let task = session.dataTask(with: url) { data, response, error in
            // if there is no error for this  response
            guard error == nil else {
                print ("error: \(error!)")
                return
            }
            // if there is some data  from this  response
            guard let content = data else {
                print("there is no data")
                return
            }
            let str_data = String(data: content, encoding: .isoLatin1)?.data(using: .utf8)
            // serialise the data  into Dictionary
            guard let json = (try? JSONSerialization.jsonObject(with: str_data!, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            print("json response dictionary is \n \(json)")
            DispatchQueue.main.async {
                if error == nil {
                    if let result = self.parseObject(ItemListModal.self, data: json) {
                        print(result.self)
                        completionHandler(true,"",result)
                    }
                }
            }
        }
        // execute the HTTP request
        task.resume()

    }
    func parseObject<T: Codable>(_: T.Type, data: [String: Any]) -> T? {
        do {
            let resultsData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            return try JSONDecoder().decode(T.self, from: resultsData)
        } catch {
            //Logger.log("\(error)")
            print(error.localizedDescription)
            return nil
        }
    }
    
    


}

