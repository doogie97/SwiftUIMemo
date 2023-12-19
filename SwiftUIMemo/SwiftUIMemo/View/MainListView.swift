//
//  MainListView.swift
//  SwiftUIMemo
//
//  Created by Doogie on 12/19/23.
//

import SwiftUI

struct MainListView: View {
    @EnvironmentObject var coredataManager: CoredataManager
    
    @State private var showComposer: Bool = false
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\MemoEntity.insertDate, order: .reverse)])
    var memoList: FetchedResults<MemoEntity>
    
    @State var keyword = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(memoList) { memo in
                    NavigationLink {
                        DetailView(memo: memo)
                    } label: {
                        MemoCell(memo: memo)
                    }
                }
                .onDelete(perform: { delete(set: $0) })
            }
            .listStyle(.plain)
            .navigationTitle("내 메모")
            .toolbar {
                Button {
                    showComposer = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showComposer) {
                ComposeView()
            }
            .searchable(text: $keyword, prompt: "메모 검색")
            .onChange(of: keyword) { newValue in
                if keyword.isEmpty {
                    memoList.nsPredicate = nil
                } else {
                    memoList.nsPredicate = NSPredicate(format: "content CONTAINS[c] %@", newValue)
                }
            }
        }
    }
    
    func delete(set: IndexSet) {
        for index in set {
            coredataManager.delete(memo: memoList[index])
        }
    }
}

#Preview {
    MainListView()
        .environment(\.managedObjectContext, CoredataManager.shared.container.viewContext)
        .environmentObject(CoredataManager.shared)
}
