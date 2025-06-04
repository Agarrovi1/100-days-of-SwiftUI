//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Angela Garrovillas on 5/12/25.
//

import SwiftUI

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { proxy in
                Text("Center")
                    .background(.blue)
                    .onTapGesture {
                        print("Global center: \(proxy.frame(in: .global).midX) x \(proxy.frame(in: .global).midY)")
                        print("Custom center: \(proxy.frame(in: .named("Custom")).midX) x \(proxy.frame(in: .named("Custom")).midY)")
                        print("Local center: \(proxy.frame(in: .local).midX) x \(proxy.frame(in: .local).midY)")
                    }
            }
            .background(.orange)
            Text("Right")
        }
    }
}

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        //MARK: Challenge
        GeometryReader { fullView in
                    ScrollView(.vertical) {
                        ForEach(0..<50) { index in
                            GeometryReader { proxy in
                                Text("Row #\(index)")
                                    .font(.title)
                                    .frame(maxWidth: .infinity)
                                    //.background(colors[index % 7])
                                    .background(colorBased(on: proxy))
                                    .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                                    .opacity(Double(proxy.frame(in: .global).minY) / 200)
                                    .scaleEffect(proxy.frame(in: .global).minY / proxy.frame(in: .global).height / 10)
                            }
                            .frame(height: 40)
                        }
                    }
                }
        //MARK: ScrollView effects using visualEffect() and scrollTargetBehavior()
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 0) {
//                ForEach(1..<20) { num in
//                    Text("Number \(num)")
//                        .font(.largeTitle)
//                        .padding()
//                        .background(.red)
//                        .frame(width: 200, height: 200)
//                        .visualEffect { content, proxy in
//                            content
//                                .rotation3DEffect(.degrees(-proxy.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
//                        }
//
//                }
//            }
//            .scrollTargetLayout()
//        }
//        .scrollTargetBehavior(.viewAligned)
        
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 0) {
//                ForEach(1..<20) { num in
//                    GeometryReader { proxy in
//                        Text("Number \(num)")
//                            .font(.largeTitle)
//                            .padding()
//                            .background(.red)
//                            .rotation3DEffect(.degrees(-proxy.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
//                            .frame(width: 200, height: 200)
//                    }
//                    .frame(width: 200, height: 200)
//                }
//            }
//        }
        
        //MARK: Understanding frames and coordinates inside GeometryReader
//        ScrollView(.horizontal, showsIndicators: false) {
//                    HStack(spacing: 0) {
//                        ForEach(1..<20) { num in
//                            GeometryReader { proxy in
//                                Text("Number \(num)")
//                                    .font(.largeTitle)
//                                    .padding()
//                                    .background(.red)
//                                    .rotation3DEffect(.degrees(-proxy.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
//                                    .frame(width: 200, height: 200)
//                            }
//                            .frame(width: 200, height: 200)
//                        }
//                    }
//                }
        
//        GeometryReader { fullView in
//                    ScrollView {
//                        ForEach(0..<50) { index in
//                            GeometryReader { proxy in
//                                Text("Row #\(index)")
//                                    .font(.title)
//                                    .frame(maxWidth: .infinity)
//                                    .background(colors[index % 7])
//                                    .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
//                            }
//                            .frame(height: 40)
//                        }
//                    }
//                }
        
//        ScrollView {
//                    ForEach(0..<50) { index in
//                        GeometryReader { proxy in
//                            Text("Row #\(index)")
//                                .font(.title)
//                                .frame(maxWidth: .infinity)
//                                .background(colors[index % 7])
//                                .rotation3DEffect(.degrees(proxy.frame(in: .global).minY / 5), axis: (x: 0, y: 1, z: 0))
//                        }
//                        .frame(height: 40)
//                    }
//                }
//        OuterView()
//                    .background(.red)
//                    .coordinateSpace(name: "Custom")
//        VStack {
//                    GeometryReader { proxy in
//                        Text("Hello, World!")
//                            .frame(width: proxy.size.width * 0.9, height: 40)
//                            .background(.red)
//                    }
//                    .background(.green)
//
//                    Text("More text")
//                        .background(.blue)
//                }
//        GeometryReader { proxy in
//                    Text("Hello, World!")
//                        .frame(width: proxy.size.width * 0.9)
//                        .background(.red)
//                }
        //MARK: Resizing images to fit the screen using GeometryReader
//        GeometryReader { proxy in
//            Image(.fugue)
//                .resizable()
//                .scaledToFit()
//                .frame(width: proxy.size.width * 0.8)
//                .frame(width: proxy.size.width, height: proxy.size.height)
//        }
//        HStack {
//            Text("IMPORTANT")
//                .frame(width: 200)
//                .background(.blue)
//
//            Image(.fugue)
//                .resizable()
//                .scaledToFit()
//                .containerRelativeFrame(.horizontal) { size, axis in
//                    size * 0.8
//                }
//        }
//        
//        GeometryReader { proxy in
//            Image(.fugue)
//                .resizable()
//                .scaledToFit()
//                .frame(width: proxy.size.width * 0.8)
//        }
        
        //MARK: Absolute positioning for SwiftUI views
//        Text("Hello, world!")
//                .offset(x: 100, y: 100)
//                .background(.red)
//        Text("Hello, world!")
//            .position(x: 100, y: 100)
//            .background(.red)
        
        //MARK: How to create custom alignment guides
//        HStack(alignment: .midAccountAndName) {
//            VStack {
//                Text("@twostraws")
//                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
//                Image(.fugue)
//                    .resizable()
//                    .frame(width: 64, height: 64)
//            }
//
//            VStack {
//                Text("Full name:")
//                Text("PAUL HUDSON")
//                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
//                    .font(.largeTitle)
//            }
//        }
//        HStack {
//                    VStack {
//                        Text("@twostraws")
//                        Image(.fugue)
//                            .resizable()
//                            .frame(width: 64, height: 64)
//                    }
//
//                    VStack {
//                        Text("Full name:")
//                        Text("PAUL HUDSON")
//                            .font(.largeTitle)
//                    }
//                }
        
        //MARK: Alignment and alignment guides
//        VStack(alignment: .leading) {
//                ForEach(0..<10) { position in
//                    Text("Number \(position)")
//                        .alignmentGuide(.leading) { _ in Double(position) * -10 }
//                }
//            }
//            .background(.red)
//            .frame(width: 400, height: 400)
//            .background(.blue)
        
//        VStack(alignment: .leading) {
//            Text("Hello, world!")
//                .alignmentGuide(.leading) { d in d[.trailing] }
//            Text("This is a longer line of text")
//        }
//        VStack(alignment: .leading) {
//                    Text("Hello, world!")
//                    Text("This is a longer line of text")
//                }
        //same as below
//        VStack(alignment: .leading) {
//            Text("Hello, world!")
//                .alignmentGuide(.leading) { d in d[.leading] }
//            Text("This is a longer line of text")
//        }
//                .background(.red)
//                .frame(width: 400, height: 400)
//                .background(.blue)
        
        //HStack(alignment: .bottom) {
//        HStack(alignment: .lastTextBaseline) {
//            Text("Live")
//                .font(.caption)
//            Text("long")
//            Text("and")
//                .font(.title)
//            Text("prosper")
//                .font(.largeTitle)
//        }
//        Text("Live long and prosper")
//            .frame(width: 300, height: 300, alignment: .topLeading)
        
        //MARK: How layout works in SwiftUI
        //Color.red
//        Text("Hello, World!")
//            .padding(20)
//            .background(.red)
//        Text("Hello, World!")
//            .background(.red)
//            .padding()
    }
    func colorBased(on proxy: GeometryProxy) -> Color {
        return Color(hue: min(1, 100 / proxy.frame(in: .global).minY), saturation: 1, brightness: 1)
        
    }
}

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

#Preview {
    ContentView()
}
