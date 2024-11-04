//
//  ArrayExtensionsTests.swift
//  MovariumTests
//
//  Created by Anton Solovev on 04.11.2024.
//

import XCTest
@testable import Movarium

final class ArrayExtensionsTests: XCTestCase {
    func testChunkedEmpty() {
        let sut: [Int] = []
        XCTAssertEqual(sut.chunked(into: 3), [])
    }

    func testChunkedExactMultiple() {
        let sut = [1, 2, 3, 4, 5, 6]
        XCTAssertEqual(sut.chunked(into: 3), [[1, 2, 3], [4, 5, 6]])
    }

    func testChunkedWithRemainder() {
        let sut = [1, 2, 3, 4, 5]
        XCTAssertEqual(sut.chunked(into: 2), [[1, 2], [3, 4], [5]])
    }

    func testChunkedSizeLargerThanCount() {
        let sut = [1, 2]
        XCTAssertEqual(sut.chunked(into: 10), [[1, 2]])
    }
}
