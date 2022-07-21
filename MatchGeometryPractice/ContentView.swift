//
//  ContentView.swift
//  MatchGeometryPractice
//
//  Created by Viennarz Curtiz on 7/21/22.
//

import SwiftUI

struct ContentView: View {
    @Namespace private var photoAnimation
    @Namespace private var cardAnimation
    @State private var enlarge: Bool = false
    @State var cardEnlarge: Bool = false
    
    private var largePhoto: some View {
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
    }
    
    private var smallPhoto: some View {
        VStack {
            Group {
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
                    .frame(width: 300, height: 30, alignment: .center)
                
            }
            
            
            
        }
    }
    
    var body: some View {
        
        VStack {
            if cardEnlarge {
                largeCard
            } else {
                card
                    
            }
        }
     
    }
    
    private var card: some View {
        HStack {
            Image("elonmusk")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: 60, height: 60, alignment: .center)

            
            VStack {
                
                Text("Elon Musk")
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text("CEO, Tesla")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
              
        }
        .transition(.asymmetric(insertion: .scale(scale: 1.4, anchor: .center), removal: .opacity))
        .matchedGeometryEffect(id: "card", in: cardAnimation)
        .padding()
        .background()
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .gray, radius: 10, x: 1, y: 5)
        .onTapGesture {
            withAnimation(.spring()) {
                cardEnlarge.toggle()
                
            }
        }
    }
    
    private var largeCard: some View {
        ZStack {
            Image("elonmusk")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            LinearGradient(colors: [.black.opacity(0.5), .clear], startPoint: .bottom, endPoint: .center)
            
            VStack(alignment: .leading) {
                Spacer()
                
                Text("Elon Musk")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Text("CEO, Tesla")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.6))
            }
            .padding(.vertical, 16)
            
            
            
        }
        .transition(.asymmetric(insertion: .scale(scale: 1), removal: .scale(scale: 0.5)))
        .matchedGeometryEffect(id: "card", in: cardAnimation)
        .frame(width: UIScreen.main.bounds.width - 48, height: 600, alignment: .center)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .gray, radius: 10, x: 1, y: 5)
        .onTapGesture {
            withAnimation(.spring()) {
                cardEnlarge.toggle()
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(cardEnlarge: true)
        ContentView(cardEnlarge: false)
    }
}
