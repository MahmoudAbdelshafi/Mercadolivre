//
//  FetchProductDetailsUseCaseTests.swift
//  MercadolivreTests
//
//  Created by Mahmoud Abdelshafi on 02/05/2022.
//

import XCTest
@testable import Mercadolivre

class FetchProductDetailsUseCaseTests: XCTestCase {

    static let product = Product(title: "product1", price: "20usd", thumbnail: "https1", productID: "product_id_1")
    
    static let products: [Product] = {
        let product1 = Product(title: "product1", price: "20usd", thumbnail: "https1", productID: "product_id_1")
        let product2 = Product(title: "product2", price: "30usd", thumbnail: "https2", productID: "product_id_2")
        return [ product1, product2 ]
    }()

    enum ProductDetailsRepositoryTestError: Error {
        case failedFetching
    }
    
    class DefaultProductDetailsRepositoryMock: ProductDetailsRepository {
        
        var product: Product?
        var error: ProductDetailsRepositoryTestError?
        
        func getProductDetails(id: String, completion: @escaping (Result<Product, Error>) -> Void) {
            if error != nil {
                completion(.failure(error!))
            } else {
            completion(.success(product!))
            }
        }
        
        func fetchRecentlyViewdProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        }
    }
    
    func testFetchProductDetailsUseCase_whenSuccessfullyFetchesProduct() {
        // given
        let expectation = self.expectation(description: "Fetch Product Details UseCase")
        expectation.expectedFulfillmentCount = 2
        let productDetailsRepository = DefaultProductDetailsRepositoryMock()
        productDetailsRepository.product = FetchProductDetailsUseCaseTests.product
        let useCase = DefaultFetchProductDetailsUseCase(productDetailsRepository: productDetailsRepository)
    
        // when
        let id = "MLU480128783"
        
        useCase.execute(id: id, completion: { _ in
            expectation.fulfill()
        })
      
        // then
        var product: Product?
        
        productDetailsRepository.getProductDetails(id: id) { result in
            product = (try? result.get())
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(product)
        XCTAssertTrue(product?.productID == "product_id_1")
    }
    
    func testFetchProductDetailsUseCase_whenFailedFetching() {
        // given
        
        let expectation = self.expectation(description: "Fetch Product Details fails UseCase")
        expectation.expectedFulfillmentCount = 2
        let productDetailsRepository = DefaultProductDetailsRepositoryMock()
        productDetailsRepository.error = .failedFetching
        let useCase = DefaultFetchProductDetailsUseCase(productDetailsRepository: productDetailsRepository)

       
        // when
        let id = "MLU480128783"
        
        useCase.execute(id: id, completion: { _ in
            expectation.fulfill()
        })
      
        // then
        var product: Product?
        
        productDetailsRepository.getProductDetails(id: id) { result in
            product = (try? result.get())
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(product)
        XCTAssertNotNil(productDetailsRepository.error)
    }
    
}
