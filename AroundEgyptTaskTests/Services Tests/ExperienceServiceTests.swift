//
//  ExperienceServiceTests.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 26/06/2025.
//


import XCTest
@testable import AroundEgyptTask

final class ExperienceServiceTests: XCTestCase {
    private let mockExp = Experience(
        id: "1",
        title: "Giza Pyramids",
        coverPhoto: "pyramids.jpg",
        description: "Visit the ancient pyramids",
        city: .init(name: "Giza"),
        recommended: 1,
        viewsNumber: 500,
        likesNumber: 100,
        hasAudio: false,
        audioURL: nil
    )

    func test_getExperience_success_returnsExperience() async {
        // Arrange
        let mock = MockNetworkService()
        mock.mockExperience = mockExp

        let service = ExperienceService(networkService: mock)

        // Act
        let result = await service.getExperience(for: "1")

        // Assert
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.id, "1")
        XCTAssertEqual(result?.title, "Giza Pyramids")
    }

    func test_getExperience_failure_returnsNil() async {
        // Arrange
        let mock = MockNetworkService()
        mock.shouldReturnError = true
        mock.expectedError = .invalidURL

        let service = ExperienceService(networkService: mock)

        // Act
        let result = await service.getExperience(for: "1")

        // Assert
        XCTAssertNil(result)
    }

    func test_likeExperience_success_returnLikesPlus1() async {
        // Arrange
        let mock = MockNetworkService()
        mock.mockExperience = mockExp

        let service = ExperienceService(networkService: mock)

        // Act
        let result = await service.likeExperience(id: "1")

        // Assert
        XCTAssertEqual(result, 101)
    }

    func test_likeExperience_failure_returnsNil() async {
        // Arrange
        let mock = MockNetworkService()
        mock.shouldReturnError = true
        mock.expectedError = .serverError(statusCode: 500)

        let service = ExperienceService(networkService: mock)

        // Act
        let result = await service.likeExperience(id: "1")

        // Assert
        XCTAssertNil(result)
    }
}
