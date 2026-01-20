//
//  Home.swift
//  Pinterest
//
//  Created by Harpreet Singh on 13/01/26.
//

import SwiftUI
import SDWebImageSwiftUI

struct Home: View {
    var window = NSScreen.main?.visibleFrame
    @State var search: String = ""
    var columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 15), count: 4)
    
    @StateObject var imageViewModel = ImageViewModel()
    var body: some View {
        HStack {
            
            SideBar()
            
            VStack {
                HStack(spacing: 12) {
                    //Search Bar
                    HStack(spacing: 15) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: $search)
                            .textFieldStyle(PlainTextFieldStyle())
                           
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(BlurWindow())
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                       
                    Button {
                        
                    } label: {
                        Image(systemName: "slider.vertical.3")
                            .foregroundStyle(.black)
                            .padding(10)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: -5, y: -5)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                            .padding(10)
                            .background(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .buttonStyle(PlainButtonStyle())

                }
                
                //ScrollView with Images...
                GeometryReader { reader in
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 15) {
                            // Getting Images...
                            ForEach(imageViewModel.images, id: \.id) { image in
                                
                                ZStack {
                                    WebImage(url: URL(string: image.downloadURL ?? "")) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle())
                                    }
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: (reader.frame(in: .global).width - 45) / 4, height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    
                                    Color.black.opacity(image.onHover ?? false ? 0.2 : 0)
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                    
                                    VStack {
                                        HStack {
                                            Spacer(minLength: 0)
                                            
                                            Button {
                                                
                                            } label: {
                                                Image(systemName: "hand.thumbsup.fill")
                                                    .foregroundStyle(.yellow)
                                                    .padding(8)
                                                    .background(.white)
                                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                            
                                            Button {
                                                saveImage(image: image)
                                            } label: {
                                                Image(systemName: "folder.fill")
                                                    .foregroundStyle(.blue)
                                                    .padding(8)
                                                    .background(.white)
                                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                            }
                                            .buttonStyle(PlainButtonStyle())

                                        }
                                        .padding(10)
                                        .opacity(image.onHover ?? false ? 1 : 0)
                                        Spacer()
                                    }
                                }
                                .onHover { hovering in
                                    withAnimation {
                                        if let index = imageViewModel.images.firstIndex(where: { $0.id == image.id }) {
                                            imageViewModel.images[index].onHover = hovering
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                }
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea(.all, edges: .all)
        .frame(width: (window?.width ?? 400) / 1.5,
               height: (window?.height ?? 400) - 50)
        .background(Color.white.opacity(0.6))
        .background(BlurWindow())
    }
    
    //MARK: Save Image
    func saveImage(image: ImageModel) {
        
        let manager = SDWebImageDownloader(config: .default)
        manager.downloadImage(with: URL(string: image.downloadURL ?? "")!) { result,_,_,_  in
            guard let originalImage = result else { return }
            
            let data = originalImage.sd_imageData(as: .JPEG)
            
            let panel = NSSavePanel()
            panel.canCreateDirectories = true
            panel.nameFieldStringValue = "\(image.id ?? "image").jpg"
            panel.begin { response in
                if response == NSApplication.ModalResponse.OK {
                    do {
                        try data?.write(to: panel.url!, options: .atomic)
                        print("Success")
                    }catch {
                        print("Failed to save \(error.localizedDescription)")
                    }
                }
            }
        }
        
        
    }
}


#Preview {
    Home()
}

extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get{.none}
        set{}
    }
}
