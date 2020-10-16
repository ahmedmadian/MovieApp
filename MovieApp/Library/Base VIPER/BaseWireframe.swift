//
//  BaseWireframe.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/15/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit

class BaseWireframe {
    
    private var _viewController: UIViewController
    
    var viewController: UIViewController {
        return _viewController
    }
    
    var navigationController: UINavigationController? {
        return viewController.navigationController
    }
    
    init(viewController: UIViewController) {
        _viewController = viewController
    }
}

extension BaseWireframe: Wireframeable {
    
    func popFromNavigationController(animated: Bool) {
        let _ = navigationController?.popViewController(animated: animated)
    }
    
    func dismiss(animated: Bool) {
        navigationController?.dismiss(animated: animated)
    }
    
    func showErrorAlert(with message: String?) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        showAlert(with: "Something went wrong", message: message, actions: [okAction])
    }
    
    func showAlert(with title: String?, message: String?) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        showAlert(with: title, message: message, actions: [okAction])
    }
    
    func showAlert(with title: String?, message: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        navigationController?.present(alert, animated: true, completion: nil)
    }
}

extension UIViewController {
    
    func present(wireframe: BaseWireframe, modalPresentationStyle: UIModalPresentationStyle, animated: Bool = true, completion: (() -> Void)? = nil) {
        wireframe.viewController.modalPresentationStyle = modalPresentationStyle
        present(wireframe.viewController, animated: animated, completion: completion)
    }
    
}

extension UINavigationController {
    
    func push(route router: BaseWireframe, animated: Bool = true) {
        self.pushViewController(router.viewController, animated: animated)
    }
    
    func setRootRoute(_ route: BaseWireframe, animated: Bool = true) {
        self.setViewControllers([route.viewController], animated: animated)
    }
    
}

extension UITabBarController {
    
    func setRootRoute(_ routes: [BaseWireframe], animated: Bool = true) {
        let viewControllers = routes.map { $0.viewController}
        self.setViewControllers(viewControllers, animated: animated)
    }
    
}
