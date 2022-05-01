//
//  ProductDetailsPresenterTests.swift
//  MercadolivreTests
//
//  Created by Mahmoud Abdelshafi on 30/04/2022.
//

import XCTest
@testable import Mercadolivre

class ProductDetailsPresenterTests: XCTestCase {
    
    enum FetchProductDetailsUseCaseTestingError: Error {
        case faildFetchingProductDetails
    }
    
    enum FetchRecentlyViewedProductsUseCaseMockTestingError: Error {
        case faildFetchingProducts
    }
    
    //MARK: - Mock UseCase
    
    class FetchProductDetailsUseCaseMock: FetchProductDetailsUseCase {
        
        var expectation: XCTestExpectation?
        var error: FetchProductDetailsUseCaseTestingError?
        let product = Product(title: "notebook", price: "20", thumbnail: "http", productID: "id1")
        
        func execute(id: String, completion: @escaping (Result<Product, Error>) -> Void) {
            if let _ = error {
                completion(.failure(FetchProductDetailsUseCaseTestingError.faildFetchingProductDetails))
            } else {
                completion(.success(product))
            }
            expectation?.fulfill()
        }
    }
    
    class FetchRecentlyViewedProductsUseCaseMock: FetchRecentlyViewedProductsUseCase {
        
        var expectation: XCTestExpectation?
        var error: FetchRecentlyViewedProductsUseCaseMockTestingError?
        let product = Product(title: "notebook", price: "20", thumbnail: "http", productID: "id1")
        let product2 = Product(title: "iphone", price: "30", thumbnail: "http", productID: "id2")
        var products = [Product]()
        
        func execute(completion: @escaping (Result<[Product], Error>) -> Void) {
            if let _ = error {
                completion(.failure(FetchRecentlyViewedProductsUseCaseMockTestingError.faildFetchingProducts))
            } else {
                products = [product, product2, product]
                completion(.success(products))
            }
            expectation?.fulfill()
        }
    }
    
    
    class ProductDetailsViewControllerMock: ProductDetailsViewPresentationProtocol {
        
        var expectation: XCTestExpectation?
        var presenter: ProductDetailsPresenter?
        
        func reloadData() {
            expectation?.fulfill()
        }
        
        func fillProductDetailsData() { }
        
        func showError(message: String) { }
    }
    
    //MARK: - FetchProductDetailsUseCase_MockTests
    
    func testGetProductDetails_Successfully() {
        //given
        let fetchProductDetailsUseCaseMock = FetchProductDetailsUseCaseMock()
        let fetchRecentlyViewedProductsUseCaseMock = FetchRecentlyViewedProductsUseCaseMock()
        fetchProductDetailsUseCaseMock.expectation = self.expectation(description: "Getting productDetails success")
        let presenter = DefaultProductDetailsPresenter(fetchProductDetailsUseCase: fetchProductDetailsUseCaseMock, fetchRecentlyViewedProductsUseCase: fetchRecentlyViewedProductsUseCaseMock)
        
        //When
        let passedModel = ProductDetailsDataModel(productID: "id1")
        presenter.setPassedProductDataModel(dataModel: passedModel)
        presenter.viewDidLoad()
        
        //Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(presenter.product)
        XCTAssertEqual(presenter.product?.productID, passedModel.productID)
    }
    
    func testGetProductDetails_fails() {
        //given
        let fetchProductDetailsUseCaseMock = FetchProductDetailsUseCaseMock()
        let fetchRecentlyViewedProductsUseCaseMock = FetchRecentlyViewedProductsUseCaseMock()
        fetchProductDetailsUseCaseMock.expectation = self.expectation(description: "Getting productDetails failed")
        fetchProductDetailsUseCaseMock.error = .faildFetchingProductDetails
        let presenter = DefaultProductDetailsPresenter(fetchProductDetailsUseCase: fetchProductDetailsUseCaseMock, fetchRecentlyViewedProductsUseCase: fetchRecentlyViewedProductsUseCaseMock)
        
        //When
        let passedModel = ProductDetailsDataModel(productID: "id1")
        presenter.setPassedProductDataModel(dataModel: passedModel)
        presenter.viewDidLoad()
        
        //Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(fetchProductDetailsUseCaseMock.error)
        XCTAssertNil(presenter.product)
    }
    
    //MARK: - FetchRecentlyViewedProductsUseCase_MockTests
    
    
    func testRecentlyViewedProducts_Successfully() {
        //given
        let fetchProductDetailsUseCaseMock = FetchProductDetailsUseCaseMock()
        let fetchRecentlyViewedProductsUseCaseMock = FetchRecentlyViewedProductsUseCaseMock()
        fetchRecentlyViewedProductsUseCaseMock.expectation = self.expectation(description: "Getting recently viewed products success")
        
        let presenter = DefaultProductDetailsPresenter(fetchProductDetailsUseCase: fetchProductDetailsUseCaseMock, fetchRecentlyViewedProductsUseCase: fetchRecentlyViewedProductsUseCaseMock)
        
        //When
        presenter.viewDidLoad()
        
        //Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(presenter.recentlyViewedProducts)
        XCTAssertEqual(presenter.recentlyViewedProducts?[1].productID, "id2")
    }
    
    func testRecentlyViewedProducts_fail() {
        //given
        let fetchProductDetailsUseCaseMock = FetchProductDetailsUseCaseMock()
        let fetchRecentlyViewedProductsUseCaseMock = FetchRecentlyViewedProductsUseCaseMock()
        fetchRecentlyViewedProductsUseCaseMock.expectation = self.expectation(description: "Getting recently viewed products fails")
        fetchRecentlyViewedProductsUseCaseMock.error = .faildFetchingProducts
        let presenter = DefaultProductDetailsPresenter(fetchProductDetailsUseCase: fetchProductDetailsUseCaseMock, fetchRecentlyViewedProductsUseCase: fetchRecentlyViewedProductsUseCaseMock)
        
        //When
        presenter.viewDidLoad()
        
        //Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(fetchRecentlyViewedProductsUseCaseMock.error)
        XCTAssertNil(presenter.recentlyViewedProducts)
    }
    
    
    func test_setViewContoller() {
        //given
        let fetchProductDetailsUseCaseMock = FetchProductDetailsUseCaseMock()
        let fetchRecentlyViewedProductsUseCaseMock = FetchRecentlyViewedProductsUseCaseMock()
        fetchRecentlyViewedProductsUseCaseMock.expectation = self.expectation(description: "Getting recently viewed products fails")
        fetchRecentlyViewedProductsUseCaseMock.error = .faildFetchingProducts
        let presenter = DefaultProductDetailsPresenter(fetchProductDetailsUseCase: fetchProductDetailsUseCaseMock, fetchRecentlyViewedProductsUseCase: fetchRecentlyViewedProductsUseCaseMock)
        
        //When
        let viewContoller = ProductDetailsViewControllerMock()
        presenter.setViewController(viewController: viewContoller)
        viewContoller.presenter = presenter
        viewContoller.presenter?.viewDidLoad()
        
        //Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(presenter.viewController)
    }
    
    
}
