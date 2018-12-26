//
//  Category.swift
//  Todoey
//
//  Created by Amer Azmeh on 24.12.18.
//  Copyright © 2018 Amer Azmeh. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var randomColor = ""
    let items = List<Item>()
}
