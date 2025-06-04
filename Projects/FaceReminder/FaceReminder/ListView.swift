//
//  ListView.swift
//  FaceReminder
//
//  Created by Angela Garrovillas on 5/1/25.
//

import SwiftUI

struct ListView: View {
    var pictures: [Picture]
    var body: some View {
        VStack {
            ForEach(pictures, id: \.name) { picture in
                NavigationLink {
                    DetailView(picture: picture)
                } label: {
                    HStack {
                        Text(picture.name)
                        if let uiImage = UIImage(data: picture.data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                    }
                    .padding()
                }
            }
        }
        .padding()
    }
}

#Preview {
    ListView(pictures: [])
}
