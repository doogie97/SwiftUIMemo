//
//  MemoCell.swift
//  SwiftUIMemo
//
//  Created by Doogie on 12/19/23.
//

import SwiftUI


struct MemoCell: View {
    @ObservedObject var memo: Memo
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(memo.content)
                .font(.body)
                .lineLimit(1)
            Text(memo.insertDate, style: .date)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}


#Preview {
    MemoCell(memo: Memo(content: "더미 데이터 입니다"))
}
