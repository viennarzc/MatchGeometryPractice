//
//  ListCardVersion2View.swift
//  MatchGeometryPractice
//
//  Created by Viennarz Curtiz on 7/21/22.
//

import SwiftUI

struct ListCardVersion2View: View {
    @State var detailsExpand: Bool = false
    @Namespace private var personNamespace
    
    @State var items: [Person] = [
        Person(name: "Tim Cook", position: "CEO", company: "Apple", description: "", imageString: "timcook"),
        Person(name: "Jeff bezos", position: "CEO", company: "Amazon", description: "", imageString: "jeffbezos"),
        Person(name: "Elon Musk", position: "CEO", company: "Tesla", description: "", imageString: "elonmusk"),
    ]
    
    private var desc = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    
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
            ScrollView(.vertical) {
                VStack {
                    
                    ZStack(alignment: .top) {
                        
                        VStack {
                            Image(person.imageString)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .matchedGeometryEffect(id: "\(person.id)-photo", in: personNamespace)
                                
                        }
                        
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
                        .padding()
                    }
                    
                    Text(desc)
                        .font(.title)
                        .padding()
                    
                    Text(desc)
                        .font(.title)
                        .padding()
                }
                
            }
             .transition(.asymmetric(insertion: .scale(scale: 1.5), removal: .opacity))
             .matchedGeometryEffect(id: "card", in: personNamespace)
             
             .background(.ultraThinMaterial)
             .clipShape(RoundedRectangle(cornerRadius: 16))
             .safeAreaInset(edge: .top) {
                 Color.clear.frame(height: 64)
                 
             }
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                
                itemList

                if detailsExpand, let person = selectedPerson {
                    expandView(person)
                        .padding(48)
                }
                
//                expandView(items.first!)
//                    .padding(32)
//
//
            }
        }.navigationViewStyle(.stack)
            
    }
}

struct ListCardVersion2View_Previews: PreviewProvider {
    static var previews: some View {
        ListCardVersion2View()
    }
}
