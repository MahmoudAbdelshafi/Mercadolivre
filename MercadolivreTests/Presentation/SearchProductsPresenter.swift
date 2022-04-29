//
//  SearchProductsPresenter.swift
//  MercadolivreTests
//
//  Created by Mahmoud Abdelshafi on 28/04/2022.
//

import XCTest
@testable import Mercadolivre

class SearchProductsPresenter: XCTestCase {
    
    enum FetchProductsUseTestingError:Error {
        case faildFetchingProducts
    }
    
    //MARK: - Mock UseCase
    
    class FetchProductsUseCaseMock: FetchProductsUseCase {
        
        var expectation: XCTestExpectation?
        var error: FetchProductsUseTestingError?
        let product = Product(title: "notebook", price: "20", thumbnail: "http")
        var products = [Product]()
        
        func execute(text: String, completion: @escaping (Result<[Product], Error>) -> Void) {
            if let _ = error {
                completion(.failure(FetchProductsUseTestingError.faildFetchingProducts))
            } else {
                products = [product, product, product]
                completion(.success(products))
            }
            expectation?.fulfill()
        }
    }
    
    func testSearchForProducts_Successfully() {
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
    
    func testSearchForProducts_fails() {
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
