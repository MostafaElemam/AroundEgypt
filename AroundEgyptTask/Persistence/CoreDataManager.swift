//
//  CoreDataManager.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 26/06/2025.
//


import CoreData
import SwiftUI

class CoreDataManager {
    // MARK: - Properties
    static let shared = CoreDataManager()
    private let container: NSPersistentContainer
    private let containerName: String = "ExperienceDataModel"
    private let entityName: String = "ExperienceEntity"
    
    var savedEntities: [ExperienceEntity] = []
    
    private init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data failed to load: \(error)")
            }
            self.getSavedEntities()
        }
    }
    // MARK: - Public
    func updateExperience(_ exp: Experience?, isRecent: Bool? = nil) {
        guard let exp else { return }
        // check if experience is already saved
        if let entity = savedEntities.first(where: { $0.id == exp.id }) {
            update(entity: entity, experience: exp)
        } else {
            add(experience: exp, isRecent: isRecent ?? false)
        }
    }
    func getSavedExperience(by id: String) -> Experience? {
        if let savedEntity = savedEntities.filter ({ $0.id == id }).first {
            return Experience(id: savedEntity.id ?? "",
                              title: savedEntity.title ?? "",
                              coverPhoto: savedEntity.coverPhoto ?? "",
                              description: savedEntity.detailedDesc ?? "",
                              city: Experience.City(name: savedEntity.cityName ?? ""),
                              recommended: Int(savedEntity.recommended),
                              viewsNumber: Int(savedEntity.viewsNum),
                              likesNumber: Int(savedEntity.likesNum),
                              hasAudio: false, audioURL: nil)
        }
        return nil
    }
    func getSavedExperiences(forRecent: Bool) -> [Experience] {
        let filteredEntities = savedEntities.filter { $0.isRecent == forRecent }
        return filteredEntities.map { entity in
            Experience(id: entity.id ?? "",
                       title: entity.title ?? "",
                       coverPhoto: entity.coverPhoto ?? "",
                       description: entity.detailedDesc ?? "",
                       city: Experience.City(name: entity.cityName ?? ""),
                       recommended: Int(entity.recommended),
                       viewsNumber: Int(entity.viewsNum),
                       likesNumber: Int(entity.likesNum),
                       hasAudio: false, audioURL: nil)
        }
    }
    // MARK: -  Private
    private func getSavedEntities() {
        let request = NSFetchRequest<ExperienceEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Experience Entities. \(error)")
        }
    }
    
    private func add(experience: Experience, isRecent: Bool) {
        let entity = ExperienceEntity(context: container.viewContext)
        entity.id = experience.id
        entity.title = experience.title
        entity.cityName = experience.city.name
        entity.detailedDesc = experience.description
        entity.likesNum = Int64(experience.likesNumber)
        entity.viewsNum = Int64(experience.viewsNumber)
        entity.isLiked = experience.isLiked
        entity.coverPhoto = experience.coverPhoto
        entity.recommended = Int16(experience.recommended)
        entity.isRecent = isRecent
        applyChanges()
    }
    private func update(entity: ExperienceEntity, experience: Experience) {
        entity.title = experience.title
        entity.cityName = experience.city.name
        entity.detailedDesc = experience.description
        entity.likesNum = Int64(experience.likesNumber)
        entity.viewsNum = Int64(experience.viewsNumber)
        entity.isLiked = experience.isLiked
        entity.coverPhoto = experience.coverPhoto
        entity.recommended = Int16(experience.recommended)
        applyChanges()
    }
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data. \(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getSavedEntities()
    }
}

