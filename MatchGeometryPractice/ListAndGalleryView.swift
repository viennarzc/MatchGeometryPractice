//
//  ListAndGalleryView.swift
//  MatchGeometryPractice
//
//  Created by Viennarz Curtiz on 7/26/22.
//

import SwiftUI

struct ListAndGalleryView: View {
    @State var isGalleryView: Bool = false
    
    @Namespace private var animation
    
    @State var persons: [Person] = [
        Person(name: "Tim Cook", position: "CEO", company: "Apple", description: "", imageString: "timcook"),
        Person(name: "Jeff bezos", position: "CEO", company: "Amazon", description: "", imageString: "jeffbezos"),
        Person(name: "Elon Musk", position: "CEO", company: "Tesla", description: "", imageString: "elonmusk"),
    ]
    
    @ViewBuilder
    private var listView: some View {
        LazyVStack(alignment: .leading, spacing: 8) {
            ForEach(persons) { person in
                HStack(alignment: .center, spacing: 16) {
                    Image(person.imageString)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                    
                    Text(person.name)
                    
                    Spacer()
                    
                }
                .padding()
                .matchedGeometryEffect(id: "\(person.id)-item", in: animation)
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .swipeActions(edge: .trailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "trash")
                    }

                }
            }
            .padding(.horizontal)

        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                if isGalleryView {
                    LazyHGrid(rows: [
                        GridItem(.adaptive(minimum: 100, maximum: 120), spacing: 170, alignment: .top),
                        GridItem(.adaptive(minimum: 100, maximum: 120), spacing: 170, alignment: .top)
                    ], alignment: .top, spacing: 16) {
                        ForEach(persons) { person in
                            VStack {
                                Image(person.imageString)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)

                                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                
                                Text(person.name)
                                    .font(.caption)
                                    .padding()
                                
                            }
                            .matchedGeometryEffect(id: "\(person.id)-item", in: animation)
                            .frame(width: 150, height: 150)
                            .background(Color(UIColor.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            
                            
                            
                        }
                    }
                    .transition(.asymmetric(insertion: .scale(scale: 1), removal: .scale(scale: 0.2).combined(with: .opacity)))
                    
                    
                } else {
                    listView
                        .transition(.asymmetric(insertion: .scale(scale: 0.2), removal: .scale(scale: 1).combined(with: .opacity)))
                }
            }
            .toolbar {
                Button {
                    withAnimation(.spring()) {
                        
                        isGalleryView.toggle()
                    }
                    
                } label: {
                    
                    if isGalleryView {
                        Label("Gallery view", systemImage: "rectangle.grid.2x2.fill")
                            
                        
                    } else {
                        Label("Gallery view", systemImage: "rectangle.grid.2x2")
                    }
                    
                }
                .labelsHidden()
                
            }
        }
        
    }
}

struct ListAndGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        ListAndGalleryView()
        
        ListAndGalleryView(isGalleryView: true)
            .previewInterfaceOrientation(.portrait)
    }
}
