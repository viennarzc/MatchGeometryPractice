//
//  SwiftUIView.swift
//  MatchGeometryPractice
//
//  Created by Viennarz Curtiz on 7/21/22.
//

import SwiftUI

struct Person: Identifiable, Hashable {
    var id: String { name }
    let name: String
    let position: String
    let company: String
    let description: String
    let imageString: String
}

struct ListCardView: View {
    @State var detailsExpand: Bool = false
    @Namespace private var personNamespace
    
    @State var items: [Person] = [
        Person(name: "Tim Cook", position: "CEO", company: "Apple", description: "", imageString: "timcook"),
        Person(name: "Jeff bezos", position: "CEO", company: "Amazon", description: "", imageString: "jeffbezos"),
        Person(name: "Elon Musk", position: "CEO", company: "Tesla", description: "", imageString: "elonmusk"),
    ]
    
    @State var selectedPerson: Person? = nil
    
    private var itemList: some View {
        VStack {
     
            List(items) { item in
                Button {
                    selectedPerson = item
                    withAnimation {
                        detailsExpand.toggle()
                        
                    }
                } label: {
                    
                    HStack {
                        Image(item.imageString)
                            .resizable()
                            .aspectRatio(contentMode: .fill)

                            .clipShape(Circle())
                            .matchedGeometryEffect(id: "\(item.id)-photo", in: personNamespace)
                            .frame(width: 80, height: 80, alignment: .center)
                            
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(item.name)
                            Text("\(item.position), \(item.company)")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                    
                }

            }
            
            .navigationBarHidden(detailsExpand)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                itemList
                
                if detailsExpand, let person = selectedPerson {
                    VStack(spacing: 0) {
                    
                        Spacer()
                            .frame(height: 64)
                            .background()
                        HStack {
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    detailsExpand = false
                                }
                                
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(.gray)
                                    .contentShape(Rectangle())
                                
                            }
                            .buttonStyle(.plain)
                            
                        }
                        .background()
                        
                        ScrollView(.vertical) {
                            VStack {
  
                                ZStack(alignment: .top) {
                                    
                                    VStack {
                                        Image(person.imageString)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .matchedGeometryEffect(id: "\(person.id)-photo", in: personNamespace)
                                            .frame(maxWidth: .infinity)
                                    }
                                }
                            }
                            
                        }
                        
                    }
                    .zIndex(2)
                    .transition(.asymmetric(insertion: .scale(scale: 1.5), removal: .slide.combined(with: .scale(scale: 0))))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                    .background()
                    .safeAreaInset(edge: .top) {
                    
                            
                    }
                }

                
            }
        }.navigationViewStyle(.stack)
            
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ListCardView(detailsExpand: true, selectedPerson: Person(name: "Tim Cook", position: "CEO", company: "Apple", description: "Apple ", imageString: "timcook"))
        
        ListCardView(detailsExpand: false)
    }
}
