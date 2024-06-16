//
//  ListViewCoordinator.swift
//  App
//
//

import UIKit

class ListViewCoordinator {
    weak var navigationController: UINavigationController?
    private weak var viewController: ListViewController?
    
    func start(window: UIWindow) {
        let viewModel = ListViewModel()
        let viewController = ListViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        self.navigationController = navigationController
        self.viewController = viewController
        
        viewModel.showDetail = { item in
            let detailViewModel = DetailViewModel(forecastItem: item)
            let detailViewController = DetailViewController(viewModel: detailViewModel)
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
}
