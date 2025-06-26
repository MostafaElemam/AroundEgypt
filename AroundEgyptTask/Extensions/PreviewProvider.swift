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
    
    let experience = Experience(id: "8c0d0f32-715a-4981-8862-a10441185050",
                                title: "Temple of Isis (Philae)",
                                coverPhoto: "https://aroundegypt-production.s3.eu-central-1.amazonaws.com/21/DBiLufkgRD42qnvG83yuJzXiaV2NVp-metad214aWhEdnY2T2dvTzRobXRNcThkRXZOTk5sMjh5SVZCMW5BV2ZsMi5qcGVn-.jpg?X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIASZMRQEMKBKVP4NHO%2F20250625%2Feu-central-1%2Fs3%2Faws4_request&X-Amz-Date=20250625T181445Z&X-Amz-SignedHeaders=host&X-Amz-Expires=172800&X-Amz-Signature=b9c9d6380dd9827542de398b2abf5640edd63a7f7651841dbdc5e519e328cf7a",
                                description: "Philae is currently an island in the reservoir of the Aswan Low Dam, downstream of the Aswan Dam and Lake Nasser, Egypt. Philae was originally located near the expansive First Cataract of the Nile River in southern Egypt, and was the site of an Ancient Egyptian temple complex. These rapids and the surrounding area have been variously flooded since the initial construction of the Old Aswan Dam in 1902. The temple complex was later dismantled and relocated to nearby Agilkia Island as part of the UNESCO Nubia Campaign project, protecting this and other complexes before the 1970 completion of the Aswan High Dam.", city: Experience.City(name: "Aswan"), recommended: 1, viewsNumber: 2003, likesNumber: 9800, hasAudio: false, audioURL: nil)
}
