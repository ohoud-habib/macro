//
//  UserModel.swift
//  macro
//
//  Created by Maryam Bahwal on 12/11/1446 AH.
//

import Foundation
import SwiftData

@Model
class UserModel {
    var karma: Int

    init(karma: Int = 0) {
        self.karma = karma
    }
    func resetProgress(context: ModelContext) {
            self.karma = 0
            context.insert(self) // Only needed if it's a new object
            try? context.save()  // Save changes
        }
}
