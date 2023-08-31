//
//  WebImageView.swift
//  ShoppingList
//
//  Created by Elizabeth on 31.08.2023.
//

import Foundation
import UIKit

class WebImageView: UIImageView {
    
    func setIcon(_ imageURL: String?) {
        guard let imageURL, let url = URL(string: imageURL) else { return }
        let session = URLSession(configuration: .default)
        let request = URLRequest(url: url)
        Task { @MainActor in
            let (data, response) = try await session.data(for: request)
            guard let httpURLResponse = response.httpURLResponse, httpURLResponse.isSuccessful else {
                self.image = UIImage(systemName: "questionmark")
                return
            }
            self.image = UIImage(data: data)
        }
    }
}
