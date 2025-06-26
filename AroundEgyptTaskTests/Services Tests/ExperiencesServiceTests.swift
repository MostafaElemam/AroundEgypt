//
//  ExperiencesServiceTests.swift
//  AroundEgyptTaskTests
//
//  Created by Mostafa Elemam on 26/06/2025.
//

import XCTest
@testable import AroundEgyptTask

final class ExperiencesServiceTests: XCTestCase {

    func test_getExperiences_success_returnsExperiences() async {
        // Arrange
        let mockService = MockNetworkService()
        mockService.mockData = [
            Experience(id: "1", title: "Pyramids", coverPhoto: "", description: "Explore Giza", city: .init(name: "Cairo"), recommended: 10, viewsNumber: 100, likesNumber: 50, hasAudio: false, audioURL: nil)
        ]
        let service = ExperiencesService(networkService: mockService)
        
        // Act
        do {
            let experiences = try await service.getExperiences(url: "dummy-url")
            
            // Assert
            XCTAssertNotNil(experiences)
            XCTAssertEqual(experiences.count, 1)
            XCTAssertEqual(experiences.first?.title, "Pyramids")
        } catch {}
    }

        func test_getExperiences_failure_returnsNil() async {
            // Arrange
            let mockService = MockNetworkService()
            mockService.shouldReturnError = true
            let service = ExperiencesService(networkService: mockService)

            // Act
            do {
                let experiences = try await service.getExperiences(url: "dummy-url")
                XCTAssertNil(experiences)
                XCTAssertThrowsError(experiences)
                
            } catch {}
        }

}
