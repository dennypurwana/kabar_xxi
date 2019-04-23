//
//  UILabel.swift
//  KabarXXI_
//
//  Created by Emerio-Mac2 on 23/04/19.
//  Copyright © 2019 Emerio-Mac2. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func htmlToString(html: String) {
        if let htmlData = html.data(using: .unicode) {
            do {
                self.attributedText = try NSAttributedString(data: htmlData,
                                                             options: [.documentType: NSAttributedString.DocumentType.html],
                                                             documentAttributes: nil)
            } catch let e as NSError {
                print("Couldn't parse \(html): \(e.localizedDescription)")
            }
        }
    }
}
