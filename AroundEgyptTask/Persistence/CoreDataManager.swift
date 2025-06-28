//
//  CoreDataManager.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 26/06/2025.
//


import CoreData
import SwiftUI

protocol CoreDataService {
    func getSavedExperience(by id: String) -> Experience?
    func getSavedExperiences(forRecent: Bool) -> [Experience]
    func updateExperience(_ exp: Experience?, isRecent: Bool?)
}

class CoreDataManager: CoreDataService {
    static let shared = CoreDataManager()
    
    private let containerName = "ExperienceDataModel"
    private let entityName = "ExperienceEntity"
    private let container: NSPersistentContainer
    private let backgroundContext: NSManagedObjectContext
    
    private init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data failed to load: \(error)")
            }
        }
        backgroundContext = container.newBackgroundContext()
    }
    
    // MARK: - Public
    
    func updateExperience(_ exp: Experience?, isRecent: Bool? = nil) {
        guard let exp else { return }
        
        backgroundContext.perform {
            let request: NSFetchRequest<ExperienceEntity> = ExperienceEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", exp.id)
            
            do {
                let results = try self.backgroundContext.fetch(request)
                if let entity = results.first {
                    self.update(entity: entity, with: exp)
                } else {
                    self.add(experience: exp, isRecent: isRecent ?? false)
                }
                try self.backgroundContext.save()
            } catch {
                print("Core Data update error: \(error)")
            }
        }
    }
    
    func getSavedExperience(by id: String) -> Experience? {
        let request: NSFetchRequest<ExperienceEntity> = ExperienceEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let result = try container.viewContext.fetch(request).first
            if let entity = result {
                return self.mapEntityToExperience(entity)
            }
        } catch {
            print("Fetch by ID error: \(error)")
        }
        return nil
    }
    
    func getSavedExperiences(forRecent: Bool) -> [Experience] {
        let request: NSFetchRequest<ExperienceEntity> = ExperienceEntity.fetchRequest()
        request.predicate = NSPredicate(format: "isRecent == %@", NSNumber(value: forRecent))
        
        do {
            let entities = try container.viewContext.fetch(request)
            return entities.map { self.mapEntityToExperience($0) }
        } catch {
            print("Fetch recent/rec error: \(error)")
            return []
        }
    }
    
    // MARK: - Private
    
    private func add(experience: Experience, isRecent: Bool) {
        let entity = ExperienceEntity(context: backgroundContext)
        entity.isRecent = isRecent
        entity.populate(with: experience)
    }
    
    private func update(entity: ExperienceEntity, with experience: Experience) {
        entity.populate(with: experience)
    }
    
    private func mapEntityToExperience(_ entity: ExperienceEntity) -> Experience {
        entity.getExperience()
    }
}

