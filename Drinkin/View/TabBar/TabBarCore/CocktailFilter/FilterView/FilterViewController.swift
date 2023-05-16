//
//  FilterViewController.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/05/15.
//

import UIKit

class FilterViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let initializationButton: UIButton = {
       let button = UIButton()
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        LoginViewController()
    }
}

struct ViewControllerRepresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }
}

class BaseSortModalView: UIViewController {
    
}

class HoldedIngredientSortModalView: UIViewController {
    
}

class LevelSortModalView: UIViewController {
    
}

class ABVSortModalView: UIViewController {
    
}

class IngredientView: UIViewController {
    
}
