//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Angela Garrovillas on 3/25/25.
//

import SwiftUI

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(.capsule)
    }
}
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding()
            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(.capsule)
    }
}
struct Watermark: ViewModifier {
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}
struct BlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fontWeight(.bold)
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    @State private var useRedText = false
    var motto1: some View {
        Text("Gotta catch 'em all")
    }
    let motto2 = Text("Pokemon!")
    var sounds: some View {
        VStack {
            Text("Pika")
            Text("Char")
        }
    }
    var sounds2: some View {
        Group {
            Text("Pika")
            Text("Bulba")
        }
    }
    @ViewBuilder var sounds3: some View {
        Text("Pika")
        Text("Squirtle")
    }
    
    
    //var body: Text { <- can compile
    //var body: View { <- can't compile, needs "some"
    var body: some View {
        VStack {
            Text("Grid")
                .blueTitle()
            GridStack(rows: 4, columns: 4) { row, column in
                //            HStack {
                Image(systemName: "\(row * 4 + column).circle")
                Text("R\(row) C\(column)")
                //            }
            }
        }
        
//        VStack(spacing: 10) {
//            CapsuleText(text: "First")
//            CapsuleText(text: "Second")
//            Text("Third")
//                .modifier(Title())
//            Text("Forth")
//                .titleStyle()
//        }
//        Color.blue
//            .frame(width: 300, height: 200)
//            .watermarked(with: "Hacking with Swift")
        
//        VStack {
//            motto1
//                .foregroundStyle(.red)
//            motto2
//                .foregroundStyle(.blue)
//        }
        
//        VStack {
//            Text("Ash")
//                .font(.largeTitle)
//                //.blur(radius: 0)
//            Text("Pikachu")
//            Text("Misty")
//            Text("Brock")
//        }
//        .font(.title)
        //.blur(radius: 5)
        
//        Button("Hello World") {
//            useRedText.toggle()
//        }
//        .foregroundStyle(useRedText ? .red : .blue)
        
//        Text("Hello World")
//            .padding()
//            .background(.red)
//            .padding()
//            .background(.blue)
//            .padding()
//            .background(.green)
//            .padding()
//            .background(.yellow)
        
//        Button("Hello world button") {
//            print(type(of: self.body))
//        }
//        .frame(width: 200, height: 200)
//        .background(.red)
        
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(.green)
    }
}
extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
    func blueTitle() -> some View {
        modifier(BlueTitle())
    }
}

#Preview {
    ContentView()
}
