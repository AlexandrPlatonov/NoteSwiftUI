//
//  NoteCellView.swift
//  NoteSwiftUI
//
//  Created by Александр Платонов on 26.12.2022.
//

import SwiftUI

struct NoteCellView: View {
    
    @StateObject var note: Note
    
    var body: some View {
        withAnimation(.spring()) {
            VStack(alignment: .leading, spacing: 8) {
                Text(note.title ?? Date().toString)
                    .font(.headline.bold())
                    .foregroundColor(.gray)
                Text(note.content ?? "empty note")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                HStack {
                    Spacer()
                    Text(note.timestamp?.toString ?? Date().toString)
                        .font(.caption)
                        .padding(.trailing)
                        .foregroundColor(.gray)
                }
            }
            .padding(10)
            .frame(width: UIScreen.main.bounds.width / 1.1, height: UIScreen.main.bounds.height / 7)
            .background(RoundedRectangle(cornerRadius: 25).fill(Color.white))

            
        }
    }
}

extension Date {
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy, HH:mm"
        return dateFormatter.string(from: self)
    }
}

struct NoteCellView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
