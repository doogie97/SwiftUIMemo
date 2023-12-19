//
//  MemoStore.swift
//  SwiftUIMemo
//
//  Created by Doogie on 12/19/23.
//

import Foundation

class MemoStore: ObservableObject {
    @Published var list: [Memo]
    
    init() {
        list = [
            Memo(content: "그래 그리 쉽지는 않겠지", insertDate: Date.now),
            Memo(content: "나를 허락한 이 세상이란", insertDate: Date.now.addingTimeInterval(3600 * -24)),
            Memo(content: "손 쉽게 다가오는", insertDate: Date.now.addingTimeInterval(3600 * -48)),
            Memo(content: "편하고도 감미로운 공간이 아냐", insertDate: Date.now.addingTimeInterval(3600 * -72))
        ]
    }
    
    func insert(memo: String) {
        list.insert(Memo(content: memo), at: 0)
    }
    
    func update(memo: Memo?, content: String) {
        guard let memo = memo else {
            return
        }
        
        memo.content = content
    }
    
    func delete(memo: Memo) {
        list.removeAll { $0.id == memo.id }
    }
    
    func delete(set: IndexSet) {
        for index in set {
            list.remove(at: index)
        }
    }
}
