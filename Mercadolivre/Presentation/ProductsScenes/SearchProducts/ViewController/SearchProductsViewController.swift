//
//  SearchProductsViewController.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 27/04/2022.
//

import UIKit

protocol SearchProductsViewPresentationProtocol: AnyObject {
    func reloadData()
    func showError(message: String)
}

final class SearchProductsViewController: UIViewController {
    
    //MARK: - Properties
    
    private var presenter: SearchProductsPresenter!
    
    private let searchController = UISearchController()
    private weak var noResultPopup: NoResultView?
    
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
        setupUI()
    }
    
}

//MARK: - Private Functions

extension SearchProductsViewController {
    
    private func setupUI() {
        registerTableView()
        setupNavBar()
    }
    
    private func registerTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: ProductsTableViewCell.xibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ProductsTableViewCell.reusableIdentifier)
    }
    
    private func setupNavBar() {
        self.title = "Search"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func showNoResultPopup() {
        if let popup = Bundle.main.loadNibNamed(String(describing: NoResultView.self), owner: self, options: nil)?.first as? NoResultView {
            noResultPopup = popup
            noResultPopup?.initPopup(view: self.view)
        }
    }
    
    private func dismissNoResultPopup() {
        if noResultPopup != nil {
            noResultPopup?.isHidden = true
            noResultPopup?.removeFromSuperview()
            noResultPopup = nil
        }
    }
}

//MARK: - Table View DataSource & Delegate

extension SearchProductsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductsTableViewCell.reusableIdentifier,
            for: indexPath)
                as? ProductsTableViewCell else {
                    fatalError("Couldn't dequeue \(ProductsTableViewCell.self)")
                }
        cell.configure(product: presenter.products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath.row)
    }
    
}


//MARK: - SearchProductsViewPresentationProtocol

extension SearchProductsViewController: SearchProductsViewPresentationProtocol {
    
    func reloadData() {
        presenter.products.count < 1 ? self.showNoResultPopup() : dismissNoResultPopup()
        tableView.reloadData()
    }
    
    func showError(message: String) {
        self.showAlert(title: presenter.errorTitle, message: message)
        searchController.searchBar.text = .none
    }
    
}

//MARK: - UISearchBarDelegate

extension SearchProductsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText =  searchBar.text, !searchText.isEmpty else { return }
        presenter.getProducts(with: searchText)
        dismissNoResultPopup()
    }
}
