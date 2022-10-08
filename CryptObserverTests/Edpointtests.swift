
//  Edpointtests.swift
//  CryptObserverTests
//
//  Created by Gergely Kovacs on 2022. 10. 08..
//
@testable import CryptObserver
import XCTest

class Edpointtests: XCTestCase {


let sut = Endpoint(path: "/v2/assets", queryItems: [])

    func test_EindpontsAreConstructedCorrectly() {
        XCTAssertEqual(sut.url, URL(string:"https://api.coincap.io/v2/assets?"))
    }
}
