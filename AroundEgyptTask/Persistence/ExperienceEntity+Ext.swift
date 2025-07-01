//
//  ExperienceEntity+Ext.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 28/06/2025.
//

import Foundation

extension ExperienceEntity {
    func populate(with experience: Experience) {
        id = experience.id
        title = experience.title
        cityName = experience.city.name
        detailedDesc = experience.description
        likesNum = Int64(experience.likesNumber)
        viewsNum = Int64(experience.viewsNumber)
        isLiked = experience.isLiked
        coverPhoto = experience.coverPhoto
        recommended = Int16(experience.recommended)
    }
    func getExperience() -> Experience {
        Experience(
            id: id ?? "",
            title: title ?? "",
            coverPhoto: coverPhoto ?? "",
            description: detailedDesc ?? "",
            city: Experience.City(name: cityName ?? ""),
            recommended: Int(recommended),
            viewsNumber: Int(viewsNum),
            likesNumber: Int(likesNum),
            hasAudio: false,
            audioURL: nil
        )
    }
}
