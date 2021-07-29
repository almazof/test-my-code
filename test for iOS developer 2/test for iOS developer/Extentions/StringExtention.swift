//
//  StringExtention.swift
//  test for iOS developer
//
//  Created by Zugra Rakhmatullina on 28.07.2021.
//

import UIKit

extension String {
    
    func convertToDate(at formatt: String, to: String) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = formatt
            let date = formatter.date(from: self)
            formatter.dateFormat = to
            let text = formatter.string(from: date!)
            return text
    }
    
    func widhtText(font: UIFont) -> CGFloat {
        let height = Int(font.pointSize)
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: .max, height: height))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()

        return label.frame.width
     }
}
