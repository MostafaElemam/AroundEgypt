//
//  HomeViewModelTests.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 26/06/2025.
//

import XCTest
@testable import AroundEgyptTask

final class HomeViewModelTests: XCTestCase {
    
    private func makeExperience(id: String, title: String) -> Experience {
        Experience(id: id, title: title, coverPhoto: "", description: "", city: .init(name: ""), recommended: 0, viewsNumber: 0, likesNumber: 30, hasAudio: false, audioURL: nil)
    }

    func test_getRecentExperiences_shouldLoadFromCoreData() async {
        // Arrange
        let mockCoreData = MockCoreDataManager()
        mockCoreData.savedRecent = [makeExperience(id: "1", title: "Philas Temple")]
        
        let mockService = MockNetworkService()
        mockService.shouldReturnError = true
        
        let vm = HomeViewModel(
            service: ExperiencesService(networkService: mockService),
            coreDataService: mockCoreData
        )
        //Act
        await vm.getRecentExperiences()

        // Assert
        XCTAssertEqual(vm.recentExperiences.count, 1)
        XCTAssertEqual(vm.recentExperiences.first?.title, "Philas Temple")
    }
    func test_getRecentExperiences_shouldLoadFromAPI() async {
        // Arrange
        let mockCoreData = MockCoreDataManager()
        mockCoreData.savedRecent = [makeExperience(id: "1", title: "Philas Temple")]
        
        let mockService = MockNetworkService()
        mockService.mockData = [makeExperience(id: "3", title: "Pyramids")]
        
        let vm = HomeViewModel(
            service: ExperiencesService(networkService: mockService),
            coreDataService: mockCoreData
        )
        //Act
        await vm.getRecentExperiences()

        // Assert
        XCTAssertEqual(vm.recentExperiences.count, 1)
        XCTAssertNotEqual(vm.recentExperiences.first?.id, "1")
        XCTAssertEqual(vm.recentExperiences.first?.title, "Pyramids")
    }

    func test_updateLikedExperiences_shouldUpdateAllLists() async {
        // Arrange
        let exp = makeExperience(id: "5", title: "Fav")
        let mockNetworkService = MockNetworkService()
        mockNetworkService.mockData = [exp]
        
        let vm = HomeViewModel(service: ExperiencesService(networkService: mockNetworkService),
                               coreDataService: MockCoreDataManager())
        
        await vm.getRecentExperiences()
        await vm.getRecommendedExperiences()
        // Act
        vm.updateLikedExperiences(id: "5")

        // Assert
        XCTAssertEqual(vm.recentExperiences[0].likesNumber, 31)
        XCTAssertEqual(vm.recommendedExperiences[0].likesNumber, 31)
    }
}
