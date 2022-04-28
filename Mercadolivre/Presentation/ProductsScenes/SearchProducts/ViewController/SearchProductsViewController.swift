//
//  SearchProductsViewController.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 27/04/2022.
//

import UIKit

protocol SearchProductsViewPresentationProtocol: AnyObject {
    func reloadData()
}

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
        presenter.getProducts(with: "mac")
    }

}

//MARK: - Private Functions

extension SearchProductsViewController {
    
    private func registerTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: ProductsTableViewCell.xibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ProductsTableViewCell.reusableIdentifier)
    }
}

//MARK: - Table View DataSource & Delegate

extension SearchProductsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductsTableViewCell.reusableIdentifier,
            for: indexPath)
                as? ProductsTableViewCell else {
                    fatalError("Couldn't dequeue \(ProductsTableViewCell.self)")
                }
        return cell
    }
    
}


//MARK: - SearchProductsViewPresentationProtocol

extension SearchProductsViewController: SearchProductsViewPresentationProtocol {
    
    func reloadData() {
        tableView.reloadData()
    }
}
