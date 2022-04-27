//
//  SearchProductsViewController.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 27/04/2022.
//

import UIKit

final class SearchProductsViewController: UIViewController {
    
    //MARK: - Properties
    
    private var presenter: SearchProductsPresenter!
    
    //MARK: - IBoutlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - Create
    
    static func create(with presenter: SearchProductsPresenter) -> SearchProductsViewController {
        let vc = SearchProductsViewController.loadFromNib()
        vc.presenter = presenter
        return vc
    }
    
    // MARK: - ViewLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }

}
