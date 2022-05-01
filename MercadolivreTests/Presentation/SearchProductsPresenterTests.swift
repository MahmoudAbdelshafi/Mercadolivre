//
//  SearchProductsPresenterTests.swift
//  MercadolivreTests
//
//  Created by Mahmoud Abdelshafi on 28/04/2022.
//

import XCTest
@testable import Mercadolivre

class SearchProductsPresenterTests: XCTestCase {
    
    enum FetchProductsUseCaseTestingError:Error {
        case faildFetchingProducts
    }
    
    //MARK: - Mock UseCase
    
    class FetchProductsUseCaseMock: FetchProductsUseCase {
        
        var expectation: XCTestExpectation?
        var error: FetchProductsUseCaseTestingError?
        let product = Product(title: "notebook", price: "20", thumbnail: "http", productID: "1")
        var products = [Product]()
        
        func execute(text: String, completion: @escaping (Result<[Product], Error>) -> Void) {
            if let _ = error {
                completion(.failure(FetchProductsUseCaseTestingError.faildFetchingProducts))
            } else {
                products = [product, product, product]
                completion(.success(products))
            }
            expectation?.fulfill()
        }
    }
    
    class SearchProductsViewControllerMock: SearchProductsViewPresentationProtocol {
        
        var expectation: XCTestExpectation?
        var presenter: ProductDetailsPresenter?
        
        func reloadData() {
            expectation?.fulfill()
        }
        
        func showError(message: String) { }
    }
    
    //MARK: - Tests
    
    func testSearchForProducts_andGetProducts_Successfully() {
        //given
        let fetchProductsUseCaseMock = FetchProductsUseCaseMock()
        fetchProductsUseCaseMock.expectation = self.expectation(description: "Search for data should success")
        let presenter = DefaultSearchProductsPresenter(fetchProductsUseCase: fetchProductsUseCaseMock)
        
        //When
        presenter.getProducts(with: "notebook")
        
        //Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(presenter.products.count, 3)
        XCTAssertEqual(presenter.products.first, fetchProductsUseCaseMock.products.first)
    }
    
    func testSearchForProducts_getProducts_fails() {
        //given
        let fetchProductsUseCaseMock = FetchProductsUseCaseMock()
        fetchProductsUseCaseMock.expectation = self.expectation(description: "Search for products should fail")
        fetchProductsUseCaseMock.error = .faildFetchingProducts
        let presenter = DefaultSearchProductsPresenter(fetchProductsUseCase: fetchProductsUseCaseMock)
        
        //When
        presenter.getProducts(with: "notebook")
        
        //Then
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(fetchProductsUseCaseMock.error)
        XCTAssertNil(presenter.products.first)
    }
    
}
