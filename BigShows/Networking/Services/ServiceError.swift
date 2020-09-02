//
//  ServiceError.swift
//  BigShows
//
//  Created by Andre Valdivia on 8/30/20.
//  Copyright © 2020 Andre Valdivia. All rights reserved.
//

import Foundation

enum ServiceError: Error{
    case connectivity
    case invalidData
    case decode
}
