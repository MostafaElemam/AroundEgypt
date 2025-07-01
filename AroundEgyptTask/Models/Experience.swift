//
//  Experience.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 25/06/2025.
//

import Foundation

/*
 {
 "id": "3e168a21-bfaa-4628-a8af-f08acf96b189",
 "title": "Alexandria Opera house",
 "cover_photo": "https://aroundegypt-production.s3.eu-central-1.amazonaws.com/10/Tv5a1h6wsiDr6NHtXTbQlVqINABWpp-metaZk9WYkN5NlZyMTFmNWhnaUZqbzFOOU9HOWlnN2Z0ejNWaDhKZWlJSy5qcGVn-.jpg?X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIASZMRQEMKBKVP4NHO%2F20250625%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20250625T082748Z&X-Amz-SignedHeaders=host&X-Amz-Expires=172800&X-Amz-Signature=1f4ba56dc840bbc224ebeafb90a60af4c7e40ea0767e1d274847ff1930569a3d",
 "description": "Alexandria Opera House or Sayyid Darwish Theatre was built in 1918 and opened in 1921 in the city of Alexandria, Egypt. When it opened, it was named Teatro Mohamed Ali.",
 "views_no": 8225,
 "likes_no": 1046,
 "recommended": 1,
 "city": {
 "id": 11,
 "name": "Alexandria",
 "disable": null,
 "top_pick": 0
 },
 "famous_figure": "Sayyid Darwish Theater",
 "detailed_description": "Alexandria Opera House was constructed in 1918 during the era of Sultan Fouad 1st. It was called Muhammad Ali theater. The original owner of Alexandria opera house called Badr El Din Kerdany. He appointed a french architect who's name is Georges Baroque to do the design of it. In 1962 Alexandria opera House renamed "Sayed Darwish Theater" to honor Mr.Sayed Darwish. Sayed Darwish a famous Egyptian musician. Moreover Sayed Darwish is the one who composed the Egyptian national anthem. Unfortunately, the ravages of time destroyed the exquisite beauty of Alexandria opera house building.",
 
 "audio_url": "https://aroundegypt-production.s3.eu-central-1.amazonaws.com/11/xkdircrH4BPNZMdNJ6YJJKhwtrJAcZ-metaMi1BbGV4YW5kcmlhLU9wZXJhLUhvdXNlXzAxLm1wMw%3D%3D-.mp3",
 "has_audio": true
 }
 */

struct ExperiencesResponse: Codable {
    let data: [Experience]
}
struct ExperienceResponse: Codable {
    let data: Experience
}

struct Experience: Codable, Identifiable {
    var id: String
    let title: String
    var coverPhoto: String
    let description: String
    let city: City
    let recommended: Int
    let viewsNumber: Int
    var likesNumber: Int
    let hasAudio: Bool
    let audioURL: String?
    var isLiked: Bool {
        get { FavouriteManager.shared.isLiked(experienceID: id) }
        set {}
    }
    
    struct City: Codable {
        let name: String
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, city, recommended
        case coverPhoto  = "cover_photo"
        case description = "detailed_description"
        case viewsNumber = "views_no"
        case likesNumber = "likes_no"
        case hasAudio = "has_audio"
        case audioURL = "audio_url"
    }
    
    
}
