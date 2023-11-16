//
//  UIViewController + Extension.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/23.
//

import UIKit

extension UIViewController {
    func makeBlackBackBarButton() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    func showAlert(errorType: APIError) {
        switch errorType {
        case .networkError:
            let alertController = makeAlert(title: "이용에 불편을 드려 죄송합니다.", message: "네트워크가 연결되어 있지 않습니다. 다시 시도해주세요.")
            present(alertController, animated: true, completion: nil)
        case .refreshTokenExpired:
            let alertController = makeAlert(title: "이용에 불편을 드려 죄송합니다.", message: "로그인이 만료되었습니다. 다시 로그인해주세요.")
            present(alertController, animated: true, completion: nil)
        case .notFound, .decodingError:
            let alertController = makeAlert(title: "이용에 불편을 드려 죄송합니다.", message: "앱 담당자에게 문의해 주십시오.")
            present(alertController, animated: true, completion: nil)
        default:
            break
        }
    }
    
    func makeAlert(title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.dismiss(animated: true)
        }
        
        alertController.addAction(okAction)
        
        return alertController
    }
}
