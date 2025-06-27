//
//  FavouriteManager.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 26/06/2025.
//

import Foundation

protocol FavouriteService {
    func addToLikedExperiences(id: String)
    func loadLikedExperiences() -> Set<String>
    func isLiked(experienceID: String) -> Bool
}

class FavouriteManager: FavouriteService {
    static let shared = FavouriteManager()
    private var likedExperiences: Set<String> {
        get { loadLikedExperiences() }
        set { UserDefaults.standard.set(Array(newValue), forKey: "myLikedExperiences") }
    }
    
    private init() {}
    
    // MARK: - Functions
    func loadLikedExperiences() -> Set<String> {
        if let likedExperiences = UserDefaults.standard.array(forKey: "myLikedExperiences") as? [String] {
            return Set(likedExperiences)
        }
        return []
    }
    func addToLikedExperiences(id: String) {
        likedExperiences.insert(id)
    }
    func isLiked(experienceID: String) -> Bool {
        likedExperiences.contains(experienceID)
    }
}
