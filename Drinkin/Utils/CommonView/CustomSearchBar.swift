//
//  CustomSearchBar.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/12/11.
//

import UIKit

final class CustomSearchBar: UISearchBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSearchBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureSearchBar() {
        if let textfield = self.value(forKey: "searchField") as? UITextField {
            textfield.layer.borderColor = ColorPalette.buttonBorderColor
            textfield.layer.borderWidth = 2
            textfield.layer.cornerRadius = 4
            textfield.backgroundColor = .white
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
            textfield.textColor = UIColor.black
        }
        
        self.setValue("취소", forKey: "cancelButtonText")
    }
}


