//
//  Viber.swift
//  Advocates
//
//  Created by Michael James on 18/07/2019.
//  Copyright © 2019 Mike James. All rights reserved.
//  Origins:  Based on code from hello@ivanvorobei.by

import Foundation
import UIKit

class ViberService: SocialServiceProtocol {
    
    static var isSetApp: Bool {
        return UIApplication.shared.canOpenURL(URL(string: "viber://forward?text=test")!)
    }
    
    static func share(text: String, complection: @escaping (_ isOpened: Bool)->Void = {_ in }) {
        let urlStringEncoded = text.addingPercentEncoding( withAllowedCharacters: .urlHostAllowed)
        let urlOptional = URL(string: "viber://forward?text=\(urlStringEncoded ?? "")")
        if let url = urlOptional {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: complection)
            } else {
                complection(false)
            }
        } else {
            complection(false)
        }
    }
    
    private init() {}
}

private func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
