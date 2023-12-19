//
//  DetailView.swift
//  SwiftUIMemo
//
//  Created by Doogie on 12/19/23.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var memo: MemoEntity
    
    @State private var showComposer = false
    @State private var showDeleteAlert = false
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var coredataManager: CoredataManager
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(memo.content ?? "")
                            .padding()
                        
                        Spacer(minLength: 0)
                    }
                    
                    Text(memo.insertDate ?? .now, style: .date)
                        .padding()
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            HStack {
                Spacer()
                Button {
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                        .resizable()
                        .frame(width: 20, height: 23)
                }
                .foregroundStyle(.red)
                .alert("삭제 확인", isPresented: $showDeleteAlert) {
                    Button(role: .destructive) {
                        coredataManager.delete(memo: memo)
                        dismiss()
                    } label: {
                        Text("삭제")
                    }
                    
                } message: {
                    Text("메모를 삭제하시겠습니까?")
                }
                Spacer(minLength: 290)
                Button {
                    showComposer = true
                } label: {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .frame(width: 23, height: 23)
                }
                Spacer()
            }
            Spacer()
        }
        .navigationTitle("메모 보기")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showComposer) {
            ComposeView(memo: memo)
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(memo: MemoEntity(context: CoredataManager.shared.mainContext))
            .environmentObject(CoredataManager.shared)
    }
}
