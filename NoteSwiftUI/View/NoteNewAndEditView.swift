//
//  NoteNewAndEditView.swift
//  NoteSwiftUI
//
//  Created by Александр Платонов on 26.12.2022.
//

import SwiftUI

enum FocusField: Int, CaseIterable {
    case titleTextField
    case textEditor
}

struct NoteNewAndEditView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var homeViewModel: HomeViewModel
    @StateObject var viewModel: NoteNewAndEditViewModel
    @State var editContent: String
    @FocusState private var focusedField: FocusField?
    
    var body: some View {
        VStack {
            textTitleScene(viewModel.isNewNote)
            titleNoteTextField(text: $viewModel.titleNote, focusedField: $focusedField)
            
            TextEditor(text: viewModel.isNewNote ? $viewModel.newContent : $viewModel.editContent)
                .focused($focusedField, equals: .textEditor)
        }
        
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                buttonBack
                    .foregroundColor(.yellow)
            }
            ToolbarItem(placement: .keyboard) {
                Button {
                    focusedField = nil
                } label: {
                    Text("hide keyboard")
                }
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .onDisappear {
            if editContent.isEmpty {
                viewModel.addNote(homeViewModel: homeViewModel)
            } else {
                viewModel.updateNote(homeViewModel: homeViewModel)
            }
        }
    }
}

extension NoteNewAndEditView {
    private var buttonBack: some View {
        Button {
            dismiss()
        } label: {
            HStack {
                Image(systemName: "arrow.left")
                    .foregroundColor(.yellow)
                if viewModel.changeButtonBackText() {
                    Text("Back")
                } else {
                    Text("Save and Back")
                }
            }
        }
    }
    
    
    private var buttonCloseNewNote: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "arrow.down.circle")
                .font(.system(size: 30))
                .foregroundColor(.yellow)
        }
    }
    
    @ViewBuilder private func textTitleScene(_ isNewNote: Bool)  -> some View {
        let textNewNote = "New note"
        let textEditNote = ""
        
        HStack {
            Text(isNewNote ? textNewNote : textEditNote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title.bold())
                .padding(.leading, 20)
            if viewModel.isNewNote {
                buttonCloseNewNote
            }
        }
    }
    
    private func titleNoteTextField(text: Binding<String>, focusedField: FocusState<FocusField?>.Binding)  -> some View  {
        TextField("Title of note", text: text)
            .focused(focusedField, equals: .titleTextField)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .font(.title2.bold())
            .frame(width: UIScreen.main.bounds.width * 0.9)
            .background(Color.gray.opacity(0.13))
            .cornerRadius(10)
            .foregroundColor(.gray.opacity(0.8))
    }
}


struct NoteNewAndEditView_Previews: PreviewProvider {
    static var previews: some View {
        NoteNewAndEditView(viewModel: NoteNewAndEditViewModel(isNewNote: true), editContent: "")
            .environmentObject(HomeViewModel())
    }
}
