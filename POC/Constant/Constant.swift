//
//  Constant.swift
//  POC
//
//  Created by Shashank on 21/07/20.
//  Copyright © 2020 Shashank. All rights reserved.
//

import UIKit
import MBProgressHUD


class Constant: NSObject {
    struct KConstant {
        static let url = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        static let cell_identifier = "Cell"
        static let indicator_title = "Loading"
    }
 
}
class Loader {
    public static func showIndicator(withTitle title: String, and Description:String, and View : UIView) {
       let Indicator = MBProgressHUD.showAdded(to: View, animated: true)
       Indicator.label.text = title
       Indicator.isUserInteractionEnabled = false
       Indicator.detailsLabel.text = Description
       Indicator.show(animated: true)
    }
     // implement MBProgressHud for hiding the loader
    public static func hideIndicator(View : UIView) {
       MBProgressHUD.hide(for: View, animated: true)
    }
}
