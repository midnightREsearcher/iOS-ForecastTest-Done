//
//  DetailViewController.swift
//  App
//
//

import UIKit
import Combine
import GlobalUI

class DetailViewController: UIViewController {
    
    private let viewModel: DetailViewModel
    
    public init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addFullScreenView(DetailView(viewModel: viewModel))
    }
}
