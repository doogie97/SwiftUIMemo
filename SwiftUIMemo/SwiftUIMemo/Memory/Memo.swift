//
//  Memo.swift
//  SwiftUIMemo
//
//  Created by Doogie on 12/19/23.
//

import Foundation

class Memo: Identifiable, ObservableObject {
    let id: UUID
    @Published var content: String
    let insertDate: Date
    
    init(content: String, insertDate: Date = Date.now) {
        self.id = UUID()
        self.content = content
        self.insertDate = insertDate
    }
}
