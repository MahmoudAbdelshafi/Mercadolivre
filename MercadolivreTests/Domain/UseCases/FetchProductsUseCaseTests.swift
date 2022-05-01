//
//  FetchProductsUseCaseTests.swift
//  MercadolivreTests
//
//  Created by Mahmoud Abdelshafi on 01/05/2022.
//

import XCTest
@testable import Mercadolivre

class FetchProductsUseCaseTests: XCTestCase {
    
    static let products: [Product] = {
        let product1 = Product(title: "product1", price: "20usd", thumbnail: "https1", productID: "product_id_1")
        let product2 = Product(title: "product2", price: "30usd", thumbnail: "https2", productID: "product_id_2")
        return [ product1, product2 ]
    }()
    
    enum ProductsRepositoryTestError: Error {
        case failedFetching
    }
    
    class DefaultProductsRepositoryMock: ProductsRepository {
        var products: [Product] = []
        var error: ProductsRepositoryTestError?
        
        func searchForProducts(text: String, completion: @escaping (Result<[Product], Error>) -> Void) {
            if error != nil {
                completion(.failure(error!))
            } else {
            completion(.success(products))
            }
        }
    }
    
    func testFetchProductsUseCase_whenSuccessfullyFetchesProducts() {
        // given
        let expectation = self.expectation(description: "Fetch Products UseCase")
        expectation.expectedFulfillmentCount = 2
        let productsRepository = DefaultProductsRepositoryMock()
        productsRepository.products = FetchProductsUseCaseTests.products
        let useCase = DefaultFetchProductsUseCase(productsRepository: productsRepository)
    
        // when
        let searchText = "mac"
        
        useCase.execute(text: searchText, completion: { _ in
            expectation.fulfill()
        })
      
        // then
        var products = [Product]()
        productsRepository.searchForProducts(text: searchText) { result in
            products = (try? result.get()) ?? []
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(!products.isEmpty)
        XCTAssertNotNil(products)
        XCTAssertTrue(products.contains(where: {$0.productID == "product_id_2"}))
    }
    
    func testFetchProductsUseCase_whenFailedFetchingProducts() {
        // given
        let expectation = self.expectation(description: "Fetch faild UseCase")
        expectation.expectedFulfillmentCount = 2
        let productsRepository = DefaultProductsRepositoryMock()

        let useCase = DefaultFetchProductsUseCase(productsRepository: productsRepository)
        productsRepository.error = .failedFetching
        // when
        let searchText = "mac"
        
        useCase.execute(text: searchText, completion: { _ in
            expectation.fulfill()
        })
      
        // then
        var products = [Product]()
        productsRepository.searchForProducts(text: searchText) { result in
            products = (try? result.get()) ?? []
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(products.isEmpty)
        XCTAssertNotNil(productsRepository.error)
    }
    
}
