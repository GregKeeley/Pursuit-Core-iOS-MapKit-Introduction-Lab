//
//  PublicSchoolModel.swift
//  MapKitLab
//
//  Created by Gregory Keeley on 2/24/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import Foundation

struct PublicSchool: Codable {
    let schoolName: String
    let latitude: String
    let longitude: String
    private enum CodingKeys: String, CodingKey {
        case schoolName = "school_name"
        case latitude
        case longitude
    }
    
}
