//
//  ProductDetailsViewController.swift
//  Mercadolivre
//
//  Created by Mahmoud Abdelshafi on 29/04/2022.
//

import UIKit


protocol ProductDetailsViewPresentationProtocol: AnyObject {
    func reloadData()
    func fillProductDetailsData()
    func showError(message: String)
}

class ProductDetailsViewController: UIViewController {
    
    //MARK: - Properties
    
    private var presenter: ProductDetailsPresenter!
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var productTitleLabel: UILabel!
    @IBOutlet private weak var productPriceLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var recentlyViewedView: UIView!
    
    //MARK: - Create
    
    static func create(with presenter: ProductDetailsPresenter) -> ProductDetailsViewController {
        let vc = ProductDetailsViewController.loadFromNib()
        vc.presenter = presenter
        return vc
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        setupUI()
    }
    
}

//MARK: - ProductDetailsViewPresentationProtocol

extension ProductDetailsViewController: ProductDetailsViewPresentationProtocol {
    
    func fillProductDetailsData() {
        productImage.loadWebImageWithUrl(imageUrl: presenter.product?.thumbnail ?? "")
        productTitleLabel.text = presenter.product?.title
        productPriceLabel.text = presenter.product?.price
    }
    
    func reloadData() {
        presenter.recentlyViewedProducts?.count ?? 0 < 1 ? hideRecentlyViewedView() : showRecentlyViewedView()
        collectionView.reloadData()
    }
    
    func showError(message: String) {
        self.showAlert(title: "Error", message: message)
    }
    
}

//MARK: - Private Functions

extension ProductDetailsViewController {
    
    private func setupUI() {
        title = "Product Details"
        registerCollectionView()
    }
    
    private func hideRecentlyViewedView() {
        recentlyViewedView.isHidden = true
    }
    
    private func showRecentlyViewedView() {
        recentlyViewedView.isHidden = false
    }
    
    private func registerCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: RecentlyViewedCollectionViewCell.xibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: RecentlyViewedCollectionViewCell.reusableIdentifier)
    }
    
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension ProductDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.recentlyViewedProducts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecentlyViewedCollectionViewCell.reusableIdentifier,
            for: indexPath)
                as? RecentlyViewedCollectionViewCell else {
                    fatalError("Couldn't dequeue \(RecentlyViewedCollectionViewCell.self)")
                }
        if let recentProduct = presenter.recentlyViewedProducts?[indexPath.row] {
            cell.configure(product: recentProduct)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 300)
    }
    
}
