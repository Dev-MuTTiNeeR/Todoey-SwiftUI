//
//  Data.swift
//  Todoey
//
//  Created by Cem Akkaya on 09/03/26.
//  Copyright © 2026 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @Persisted var name: String = ""
    @Persisted var age: Int = 0
}
