//
//  ComposeView.swift
//  SwiftUIMemo
//
//  Created by Doogie on 12/19/23.
//

import SwiftUI

struct ComposeView: View {
    @EnvironmentObject var store: MemoStore
    
    var memo: Memo? = nil
    
    @Environment(\.dismiss) var dismiss
    
    @State private var content: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextEditor(text: $content)
                    .padding()
                    .onAppear {
                        if let memo = memo {
                            self.content = memo.content
                        }
                    }
            }
            .navigationTitle(memo == nil ? "새 메모" : "메모 편집")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("취소")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if let memo = memo {
                            store.update(memo: memo, content: content)
                        } else {
                            store.insert(memo: content)
                        }
                        dismiss()
                    } label: {
                        Text("저장")
                    }
                }
            }
        }
    }
}

#Preview {
    ComposeView()
        .environmentObject(MemoStore())
}
