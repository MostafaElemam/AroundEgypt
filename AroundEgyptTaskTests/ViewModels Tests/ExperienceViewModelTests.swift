//
//  ExperienceViewModelTests.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 26/06/2025.
//

import XCTest
@testable import AroundEgyptTask

final class ExperienceViewModelTests: XCTestCase {

    func test_getDetails_loadsOfflineThenOnline() async {
        // Arrange
        let experience = Experience(id: "123", title: "Abu Simbel", coverPhoto: "", description: "", city: .init(name: "Aswan"), recommended: 1, viewsNumber: 10, likesNumber: 0, hasAudio: false, audioURL: nil)

        let mockCoreData = MockCoreDataManager()
        mockCoreData.savedExperience = experience

        let mockService = MockNetworkService()
        mockService.mockExperience = experience

        
        let vm = ExperienceViewModel(id: "123", service: ExperienceService(networkService: mockService), favouriteManager: MockFavouriteManager(), coreDataService: mockCoreData)

        // Act
        try? await Task.sleep(nanoseconds: 300_000_000)

        // Assert
        XCTAssertEqual(vm.experience?.id, "123")
        XCTAssertEqual(vm.experience?.title, "Abu Simbel")
    }

    func test_likeExperience_success_updatesLike() async {
        // Arrange
        let exp = Experience(id: "123", title: "", coverPhoto: "", description: "", city: .init(name: ""), recommended: 0, viewsNumber: 0, likesNumber: 2, hasAudio: false, audioURL: nil)
        let mockService = MockNetworkService()
        mockService.mockExperience = exp
        mockService.shouldReturnError = false
        mockService.mockLikeSuccess = true

        let mockCoreData = MockCoreDataManager()
        let mockFavourites = MockFavouriteManager()

        let vm = ExperienceViewModel(
            id: "123",
            service: ExperienceService(networkService: mockService),
            favouriteManager: mockFavourites,
            coreDataService: mockCoreData
        )
        
        // Act
        await vm.getDetails()
        let success = await vm.likeExperience()
        
        // Assert
        XCTAssertTrue(success)
        XCTAssertEqual(vm.experience?.likesNumber, 3)
        XCTAssertTrue(mockCoreData.didCallUpdate)
        XCTAssertEqual(mockFavourites.addedIDs, ["123"])
    }
}
