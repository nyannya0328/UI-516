//
//  Home.swift
//  UI-516
//
//  Created by nyannyan0328 on 2022/03/23.
//

import SwiftUI

struct Home: View {
    @Namespace var animation
    @State var expandCard : Bool = false
    @State var currentCard : Album?
    @State var showDetail : Bool = false
    @State var currentIndex : Int = -1
    
    
    @State var cardSize : CGSize = .zero
    @State var animatedDetailView : Bool = false
    @State var rotedCard : Bool = false
    @State var showDetailContent : Bool = false
    var body: some View {
        VStack{
            
            HStack{
                
                Button {
                    
                    
                    
                } label: {
                    
                    Image(systemName: "line.3.horizontal.decrease")
                        .font(.title2)
                }
                
                Spacer()
                
                
                Button {
                    
                    
                    
                } label: {
                    
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                }

            }
            .overlay(content: {
                Text("My Playlist").font(.title2).fontWeight(.light)
            })
            .padding(.horizontal)
            .foregroundColor(.black)
            
            
            GeometryReader{proxy in
                
                let size = proxy.size
                
                stackPlayerView(size: size)
                    .frame(width: size.width, height: size.height)
            }
            
            
            VStack(alignment: .leading, spacing: 15) {
                
                
                Text("Recently Played")
                    .font(.body)
                    .frame(maxWidth:.infinity,alignment: .leading)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    
                    HStack(spacing:15){
                        
                        
                        
                        ForEach(albums){album in
                            
                            
                            Image(album.albumImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 96, height: 96)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            
                        }
                        
                        
                    }
                    
                    
                    
                    
                    
                }
                
            }
            .padding([.horizontal,.top])
            
            
        }
        .padding(.vertical,15)
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
        .background{
            
            Color("BG")
                .ignoresSafeArea()
        }
        .overlay {
            
            if let currentCard = currentCard,showDetail {
                
                Color("BG").ignoresSafeArea()
                
                DetailView(currentCard: currentCard)
            }
        }
    }
    
    @ViewBuilder
    func DetailView(currentCard : Album)->some View{
        
        
        VStack(spacing : 0){
            
          
            
            Button {
                
                rotedCard = false
                
                withAnimation{
                    
                    animatedDetailView = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    
                    withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.7)){
                        
                        self.currentIndex = -1
                        self.currentCard = nil
                        showDetail = false
                        animatedDetailView = false
                        
                    }
                    
                    
                }
                
            } label: {
                
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundColor(.black)
            }
            .frame(maxWidth:.infinity,alignment: .leading)
            .padding([.horizontal,.top])

            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing:25){
                    
                    Image(currentCard.albumImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: cardSize.width, height: cardSize.height)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .rotation3DEffect(.init(degrees: animatedDetailView && showDetail ? -180 : 0), axis: (x: 1, y: 0, z: 0), anchor: .center, anchorZ: 1, perspective: 1)
                        .rotation3DEffect(.init(degrees: animatedDetailView && showDetail ? 180 : 0), axis: (x: 1, y: 0, z: 0), anchor: .center, anchorZ: 1, perspective: 1)
                    
                    
                        .matchedGeometryEffect(id: currentCard.id, in: animation)
                        .padding(.top,50)
                    
                    
                    VStack{
                        
                        Text(currentCard.albumName)
                            .font(.title3)
                            .padding(.top,10)
                        
                        
                        HStack(spacing:20){
                            
                            Button {
                                
                            } label: {
                                
                                Image(systemName: "shuffle")
                                    .font(.title2)
                            }

                            Button {
                                
                            } label: {
                                
                                Image(systemName: "pause.fill")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .frame(width: 55, height: 55)
                                    .background{
                                        
                                        
                                        Circle()
                                            .fill(Color("Blue"))
                                        
                                        
                                    }
                                    
                            }

                            Button {
                                
                            } label: {
                                
                                Image(systemName: "arrow.2.squarepath")
                                    .font(.title2)
                            }

                            
                            
                            
                            
                        }
                        .foregroundColor(.black)
                        .padding(.top,13)
                        
                        
                        
                        Text("Up Comming Soon")
                            .font(.title.weight(.semibold))
                            .foregroundColor(.gray)
                            .frame(maxWidth:.infinity,alignment: .leading)
                    }
                    .padding(.horizontal)
                    .offset(y: showDetailContent ? 0 : 300)
                    .opacity(showDetailContent ? 1 : 0)
                    
                    
                    ForEach(albums){alubum in
                        
                        albumCardView(album: alubum)
                        
                    }
                    
                    
                    
                    
                
                    
                    
                }
            }
         
            
            
            
            
        }
        .frame(maxHeight:.infinity,alignment: .top)
        .onAppear {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                
                
                withAnimation(.easeInOut){
                    
                    showDetailContent = true
                }
                
            }
        }
        
    }
    
    @ViewBuilder
    func albumCardView(album : Album) -> some View{
        
        VStack{
            
            
            HStack(spacing:10){
                
                
                Image(album.albumImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                
                
                VStack(alignment: .leading, spacing: 13) {
                    
                    
                    Text(album.albumName)
                        .font(.title2.weight(.semibold))
                        .foregroundColor(.black)
                    
                    HStack(spacing:13){
                        
                        
                        Label {
                            
                            Text("333,666,666")
                            
                        } icon: {
                            
                            Image(systemName: "headphones")
                        }
                        

                        
                        
                    }
                    
                    
                }
                    .frame(maxWidth:.infinity,alignment: .leading)
                    
                    
                    
                    
                    
                    Button {
                        
                    } label: {
                        
                        Image(systemName: album.isLiked ? "suit.heart.fill" : "suit.heart")
                            .foregroundColor(album.isLiked ? .red : .gray)
                        
                        
                        
                        
                    }
                    
                    Button {
                        
                    } label: {
                        
                        Image(systemName:"applelogo")
                            .foregroundColor(.gray)
                        
                        
                        
                        
                    }
                
                
              

                    
                 
                
                                             
                
            }
            .padding([.horizontal,.vertical])
            .background{
                
          
                Color.gray.opacity(0.1)
                    .cornerRadius(10)
             
            }
            .padding(.horizontal)
            
            Divider()
                .background(.black)
                .padding(.horizontal,10)
        }
        
        
    }
    
    @ViewBuilder
    func stackPlayerView(size : CGSize)->some View{
        let offsetHeight = size.height * 0.1
        
        ZStack{
            
            ForEach(stackAlbums.reversed()){alubum in
                
                let index = getIndex(album: alubum)
                let imageSize = (size.width - CGFloat(index * 20))

                Image(alubum.albumImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imageSize / 2, height: imageSize / 2)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .rotation3DEffect(.init(degrees: expandCard && currentIndex != index  ? -10 : 0), axis: (x: 1, y: 0, z: 0), anchor: .center, anchorZ: 1, perspective: 1)
                
                    .rotation3DEffect(.init(degrees: showDetail && currentIndex == index && rotedCard  ? 360 : 0), axis: (x: 1, y: 0, z: 0), anchor: .center, anchorZ: 1, perspective: 1)
                
                
                
                    .matchedGeometryEffect(id: alubum.id, in: animation)
                    .offset(y: CGFloat(index) * -20)
                    .offset(y: expandCard ? -CGFloat(index) * offsetHeight : 0)
                    .onTapGesture {
                        
                        
                        if expandCard{
                            
                            
                            
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.8)){
                                cardSize = CGSize(width: imageSize / 2, height: imageSize / 2)
                               currentCard = alubum
                                currentIndex = index
                                showDetail = true
                                
                                
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    
                                    withAnimation(.spring()){
                                        
                                        animatedDetailView = true
                                    }
                                    
                                    
                                }
                                
                            }
                            
                            
                            
                        }
                        else{
                            
                            
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.8)){
                                
                                expandCard = true
                            }
                            
                        }
                    
                    }
                    .offset(y: showDetail && currentIndex != index ? size.height * (currentIndex < index ? -1 : 1) : 0)
                    
                
                
                
        
                
                
                
            }
            
        }
        .offset(y: expandCard ? offsetHeight * 2 : 0)
        .frame(width: size.width, height: size.height)
        .clipShape(Rectangle())
        .onTapGesture {
            
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.8)){
                
                expandCard.toggle()
            }
            
        }
        
        
        
    }
    
    func getIndex(album : Album)->Int{
        
        
        return stackAlbums.firstIndex { currentAlubum in
            
            
            album.id == currentAlubum.id
        } ?? 0
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
