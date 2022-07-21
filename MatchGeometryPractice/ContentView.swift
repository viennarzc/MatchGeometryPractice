//
//  ContentView.swift
//  MatchGeometryPractice
//
//  Created by Viennarz Curtiz on 7/21/22.
//

import SwiftUI

struct ContentView: View {
    
    @Namespace private var cardAnimation
    @State var cardEnlarge: Bool = false
    
    @State var cardInsertionTransitionPickerValue: String = "slide"
    @State var cardRemovalTransitionPickerValue: String = "slide"
    
    @State private var cardInsertionTransition: AnyTransition = .slide
    @State private var cardRemovalTransition: AnyTransition = .slide
    
    @State private var largeCardHeight: CGFloat = 600
    
    private var cardRemovalTransitionPicker: some View {
        VStack(alignment: .leading) {
            Text("Small Card Insertion Transition")
                .font(.caption)
            Picker(selection: $cardRemovalTransitionPickerValue) {
                Text("slide").tag("slide")
                Text("opacity").tag("opacity")
                Text("scale").tag("scale")
                
            } label: {
                Text("Card Transition")
            }
            .pickerStyle(.segmented)
            .onChange(of: cardRemovalTransitionPickerValue) { newValue in
                switch newValue {
                case "slide":
                    cardRemovalTransition = .slide
                case "opacity":
                    cardRemovalTransition = .opacity
                    
                case "scale":
                    cardRemovalTransition = .scale
                    
                default:
                    cardRemovalTransition = .opacity
                    
                }
            }
        }
    }
    
    private var cardInsertionTransitionPicker: some View {
        VStack(alignment: .leading) {
            Text("Small Card Insertion Transition")
                .font(.caption)
            Picker(selection: $cardInsertionTransitionPickerValue) {
                Text("slide").tag("slide")
                Text("opacity").tag("opacity")
                Text("scale").tag("scale")
                
            } label: {
                Text("Card Transition")
            }
            .pickerStyle(.segmented)
            .onChange(of: cardInsertionTransitionPickerValue) { newValue in
                switch newValue {
                case "slide":
                    cardInsertionTransition = .slide
                case "opacity":
                    cardInsertionTransition = .opacity
                    
                case "scale":
                    cardInsertionTransition = .scale
                    
                default:
                    cardInsertionTransition = .opacity
                    
                }
            }
        }
    }
    
    var body: some View {
        
        VStack(alignment: .center) {
           cardInsertionTransitionPicker
                .padding(.horizontal)
            
            Text("Large card height \(largeCardHeight)")
            Slider(value: $largeCardHeight, in: 50...600)
                .padding(.horizontal)
            
            Spacer()
                .frame(height: 30)
            
            if cardEnlarge {
                largeCard
            } else {
                card
                    .padding()
                    
            }

        }

        .frame(maxWidth: .infinity)
     
    }
    
    private var card: some View {
        HStack {
            Image("elonmusk")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .matchedGeometryEffect(id: "card", in: cardAnimation)
                .frame(width: 60, height: 60, alignment: .center)

            
            VStack(alignment: .leading) {
                
                Text("Elon Musk")
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text("CEO, Tesla")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    
            }
            
            Spacer()
              
        }
        .transition(.asymmetric(insertion: cardInsertionTransition, removal: cardRemovalTransition))
        .frame(maxWidth: .infinity)
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
        .transition(.asymmetric(insertion: .scale(scale: 1), removal: .scale(scale: 0)))
        .matchedGeometryEffect(id: "card", in: cardAnimation)
        .frame(width: UIScreen.main.bounds.width - 48, height: largeCardHeight, alignment: .center)
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
