//
//  MemoCell.swift
//  SwiftUIMemo
//
//  Created by Doogie on 12/19/23.
//

import SwiftUI


struct MemoCell: View {
    @ObservedObject var memo: MemoEntity
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(memo.content ?? "")
                .font(.body)
                .lineLimit(1)
            Text(memo.insertDate ?? .now, style: .date)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}


#Preview {
    MemoCell(memo: MemoEntity(context: CoredataManager.shared.mainContext))
}
