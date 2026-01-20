//
//  ImageModel.swift
//  Pinterest
//
//  Created by Harpreet Singh on 20/01/26.
//


import Foundation

// MARK: - WelcomeElement
struct ImageModel: Codable, Identifiable {
    let id, author: String?
    let width, height: Int?
    let url, downloadURL: String?
    var onHover: Bool?

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}

typealias ImageList = [ImageModel]
