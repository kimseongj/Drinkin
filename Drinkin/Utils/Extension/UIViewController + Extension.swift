//
//  UIViewController + Extension.swift
//  Drinkin
//
//  Created by kimseongjun on 2023/09/23.
//

import UIKit

extension UIViewController {
    //MARK: - Make Custom NavigationBackBarButton
    
    func makeBlackBackBarButton() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
}

//MARK: - Login Recommend Alert

extension UIViewController {
    func showLoginRecommendAlert() {
        let alertController = makeAlert(title: "로그인 후 이용 가능합니다.", message: "나의 홈바에서 로그인해주세요.")
        present(alertController, animated: true, completion: nil)
    }
}

    //MARK: - Error Alert
    
extension UIViewController {
    func showAlert(errorType: APIError) {
        switch errorType {
        case .networkError(let error):
            let alertController = makeAlert(title: "이용에 불편을 드려 죄송합니다. \(error)", message: "네트워크가 연결되어 있지 않습니다. 다시 시도해주세요.")
            present(alertController, animated: true, completion: nil)
        case .refreshTokenExpired:
            let alertController = makeAlert(title: "로그인이 만료되었습니다.", message: "다시 로그인해주세요.")
            present(alertController, animated: true, completion: nil)
        case .notFound, .decodingError:
            let alertController = makeAlert(title: "이용에 불편을 드려 죄송합니다.", message: "앱 담당자에게 문의해 주십시오.")
            present(alertController, animated: true, completion: nil)
        default:
            break
        }
    }
    
    //MARK: - Make Alert
    
    func makeAlert(title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            alertController.dismiss(animated: true)
        }
        
        alertController.addAction(okAction)
        
        return alertController
    }
    
    //MARK: - Redirect To LoggedOut Screen
    
    func redirectToLoggedOutScreen() {
        if let tabBarController = self.tabBarController {
            if let firstNavController = tabBarController.viewControllers?.first as? UINavigationController,
               let firstRootViewController = firstNavController.viewControllers.first {
                
                firstNavController.popToViewController(firstRootViewController, animated: true)
                
                tabBarController.selectedIndex = 0
            }
        }
    }
    
    //MARK: - HandlingError
    
    func handlingError(errorType: APIError) {
        switch errorType {
        case .noError:
            return
        case .refreshTokenExpired:
            redirectToLoggedOutScreen()
        default:
            showAlert(errorType: errorType)
        }
    }
}

//MARK: - ActivityIndicator

extension UIViewController {
    
    func showActivityIndicator(style: UIActivityIndicatorView.Style = .large) {
        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)
        self.view.insertSubview(activityIndicator, at: view.subviews.count)
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        if let activityIndicator = view.subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}
