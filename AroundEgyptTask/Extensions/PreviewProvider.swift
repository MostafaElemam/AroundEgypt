//
//  PreviewProvider.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 25/06/2025.
//

import SwiftUI

extension Preview {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() {}
    
    var experience = Experience(id: "8c0d0f32-715a-4981-8862-a10441185050",
                                title: "Temple of Isis (Philae)",
                                coverPhoto: "https://aroundegypt-production.s3.eu-central-1.amazonaws.com/21/DBiLufkgRD42qnvG83yuJzXiaV2NVp-metad214aWhEdnY2T2dvTzRobXRNcThkRXZOTk5sMjh5SVZCMW5BV2ZsMi5qcGVn-.jpg?X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIASZMRQEMKBKVP4NHO%2F20250701%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20250701T103031Z&X-Amz-SignedHeaders=host&X-Amz-Expires=172800&X-Amz-Signature=920c575e192eb9ee17360b93be523f6bec96cfd5109d4637bf7568ecf57a8a1c",
                                description: "Philae is currently an island in the reservoir of the Aswan Low Dam, downstream of the Aswan Dam and Lake Nasser, Egypt. Philae was originally located near the expansive First Cataract of the Nile River in southern Egypt, and was the site of an Ancient Egyptian temple complex. These rapids and the surrounding area have been variously flooded since the initial construction of the Old Aswan Dam in 1902. The temple complex was later dismantled and relocated to nearby Agilkia Island as part of the UNESCO Nubia Campaign project, protecting this and other complexes before the 1970 completion of the Aswan High Dam.", city: Experience.City(name: "Aswan"), recommended: 0, viewsNumber: 2003, likesNumber: 9800, hasAudio: false, audioURL: nil)
    
    func dummyExperiences(count: Int) -> [Experience] {
        var exps: [Experience] = []
        for _ in 0..<count {
            experience.id = UUID().uuidString
            experience.coverPhoto = ""
            exps.append(experience)
        }
        return exps
    }
}
