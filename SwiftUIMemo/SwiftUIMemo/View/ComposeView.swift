//
//  ComposeView.swift
//  SwiftUIMemo
//
//  Created by Doogie on 12/19/23.
//

import SwiftUI

struct ComposeView: View {
    @EnvironmentObject var coredataManager: CoredataManager
    
    var memo: MemoEntity? = nil
    
    @Environment(\.dismiss) var dismiss
    
    @State private var content: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextEditor(text: $content)
                    .padding()
                    .onAppear {
                        if let memo = memo?.content {
                            self.content = memo
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
                            coredataManager.update(memo: memo, content: content)
                        } else {
                            coredataManager.addMemo(content: content)
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
        .environmentObject(CoredataManager.shared)
}
