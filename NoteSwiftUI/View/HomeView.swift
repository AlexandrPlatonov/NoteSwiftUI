//
//  HomeView.swift
//  NoteSwiftUI
//
//  Created by Александр Платонов on 26.12.2022.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.bottom)
                VStack {
                    VStack(spacing: 5) {
                        HStack {
                            Text("Notes")
                                .font(.title.bold())
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding([.leading,.trailing], 25)
                        .padding(.bottom, 50)
                    }
                    .padding(.top, 50)
                    .background(Rounded().fill(Color.white))
                    buttonAddNote
                    notesScrollView
                }
                .ignoresSafeArea()
                    .sheet(isPresented: $homeViewModel.isNewNote) {
                        NoteNewAndEditView(viewModel: NoteNewAndEditViewModel(isNewNote: homeViewModel.isNewNote), editContent: "")
                    }
                    .background(Color.black.edgesIgnoringSafeArea(.all))
            }
        }
    }
}

extension HomeView {
    private var buttonAddNote: some View {
        Button (action: homeViewModel.addNote) {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 25,height: 25)
                .padding()
        }
        .foregroundColor(.white)
        .background(Color.red)
        .clipShape(Circle())
        .padding(.top, -10)
        .offset(y: -30)
    }
    
    private var notesScrollView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                ForEach(homeViewModel.notes) { note in
                    NavigationLink {
                        NoteNewAndEditView(
                            viewModel: NoteNewAndEditViewModel(note: note,
                                                                  isNewNote: homeViewModel.isNewNote),
                            editContent: note.content ?? "")
                    } label: {
                        NoteCellView(note: note)
                            .swipeDeleteCustomModifier {
                                homeViewModel.deleteNote(note: note)
                            }
                    }
                }
            }
        }
    }
    
    struct Rounded : Shape {
        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 25, height: 25))
            return Path(path.cgPath)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
