//
//  MockCoreDataManager.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 26/06/2025.
//

@testable import AroundEgyptTask

class MockCoreDataManager: CoreDataService {
    var savedExperience: Experience?
    var didCallUpdate = false
    
    var savedRecent: [Experience] = []
    var savedRecommended: [Experience] = []
    var updatedExperiences: [(Experience, Bool)] = []

    func getSavedExperiences(forRecent: Bool) -> [Experience] {
        return forRecent ? savedRecent : savedRecommended
    }
    func getSavedExperience(by id: String) -> Experience? {
        return savedExperience
    }

    func updateExperience(_ experience: Experience?, isRecent: Bool? = nil) {
        didCallUpdate = true
//        if let experience {
//            updatedExperiences.append((experience, isRecent))
//        }
        
    }
}
