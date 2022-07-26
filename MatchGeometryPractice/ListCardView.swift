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
                    withAnimation(.spring()) {
                        detailsExpand.toggle()
                    }
                } label: {
                    
                    HStack {
                        Image(item.imageString)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .transition(.asymmetric(insertion: .opacity, removal: .opacity))
                            .matchedGeometryEffect(id: "\(item.id)-photo", in: personNamespace)
                            .frame(width: 80, height: 80, alignment: .center)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(item.name)
                            Text("\(item.position), \(item.company)")
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 200, alignment: .leading)
                    .padding()
                    
                    
                }

            }
            .listStyle(PlainListStyle() )
            .navigationBarHidden(detailsExpand)
        }
        .transition(.asymmetric(insertion: .slide, removal: .slide))
        .matchedGeometryEffect(id: "card", in: personNamespace)
    }
    
    fileprivate func expandView(_ person: Person) -> some View {
         VStack(spacing: 0) {
            
            Spacer()
                .frame(height: 64)
                .background()
            HStack {
                Spacer()
                
                Button {
                    withAnimation(.spring()) {
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
                                .clipShape(Circle())
                                .matchedGeometryEffect(id: "\(person.id)-photo", in: personNamespace)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                
            }
            
        }

         .transition(.asymmetric(insertion: .scale(scale: 1.5), removal: .opacity))
         .matchedGeometryEffect(id: "card", in: personNamespace)
         .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
         .background()
         .safeAreaInset(edge: .top) {}
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                itemList
                
                if detailsExpand, let person = selectedPerson {
                    expandView(person)
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
