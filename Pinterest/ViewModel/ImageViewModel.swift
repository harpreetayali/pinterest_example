//
//  ImageViewModel.swift
//  Pinterest
//
//  Created by Harpreet Singh on 20/01/26.
//

import Combine
import SwiftUI

class ImageViewModel: ObservableObject {
    @Published var images: ImageList = []
    
    init() {
        let url = "https://picsum.photos/v2/list"
        let session = URLSession(configuration: .default)
        session.dataTask(with: URLRequest(url: URL(string: url)!)) { [weak self] data, response, error in
            guard let self else { return }
            guard let data = data, error == nil else { return }
            
            do {
                let images = try JSONDecoder().decode(ImageList.self, from: data)
                print(images)
                DispatchQueue.main.async { [weak self] in
                    self?.images = images
                }
            }catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
            
        }.resume()
    }
}

