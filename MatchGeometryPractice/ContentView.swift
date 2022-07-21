//
//  ContentView.swift
//  MatchGeometryPractice
//
//  Created by Viennarz Curtiz on 7/21/22.
//

import SwiftUI

struct ContentView: View {
    @Namespace private var photoAnimation
    @State private var enlarge: Bool = false
    
    var body: some View {
        
        ZStack {
            if enlarge {
                ZStack {
                    Image("elonmusk")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .matchedGeometryEffect(id: "photo", in: photoAnimation)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                        .aspectRatio(contentMode: .fill)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                enlarge.toggle()
                                
                            }
                            
                        }
                    
                    VStack {
                        Spacer()
                        Text("Elon Musk")
                            .font(.title2)
                            .matchedGeometryEffect(id: "name", in: photoAnimation)
                            .frame(width: 200, height: 60, alignment: .center)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .padding(.vertical, 24)
                    
                    
                }
            } else {
                VStack {
                    Image("elonmusk")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .matchedGeometryEffect(id: "photo", in: photoAnimation)
                        .clipShape(Circle())
                        .frame(width: 120, height: 120, alignment: .center)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                enlarge.toggle()
                                
                            }
                    }
                    
                    Text("Elon Musk")
                        .font(.body)
                        .matchedGeometryEffect(id: "name", in: photoAnimation)
                        .frame(width: 200, height: 60, alignment: .center)
                }
                
            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
