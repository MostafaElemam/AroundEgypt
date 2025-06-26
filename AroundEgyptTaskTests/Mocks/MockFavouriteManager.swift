//
//  MockFavouriteManager.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 26/06/2025.
//
import Foundation
@testable import AroundEgyptTask

class MockFavouriteManager: FavouriteService {
    
    var addedIDs: [String] = []
    
    func loadLikedExperiences() -> Set<String> {
        return Set(addedIDs)
    }
    
    func addToLikedExperiences(id: String) {
        addedIDs.append(id)
    }
    func isLiked(experienceID: String) -> Bool {
        addedIDs.contains(experienceID)
    }
}
