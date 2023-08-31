//
//  NetworkFetcher.swift
//  ShoppingList
//
//  Created by Elizabeth on 31.08.2023.
//

import Foundation

protocol NetworkMainScreen {
    func getAdvertisements() async throws -> AdvertisementsResponse
}

protocol NetworkDetailScreen {
    func getAdvertisement(id: String) async throws -> AdvertisementDetail
}

final class NetworkFetcher: NetworkMainScreen, NetworkDetailScreen {
    
    func getAdvertisements() async throws -> AdvertisementsResponse {
        let url = try RequestProcessor.makeURL()
        let (data, _) = try await RequestProcessor.performRequest(with: url)
        return try JSONDecoder().decode(AdvertisementsResponse.self, from: data)
    }
    
    func getAdvertisement(id: String) async throws -> AdvertisementDetail {
        let url = try RequestProcessor.makeURL(from: id)
        let (data, _) = try await RequestProcessor.performRequest(with: url)
        return try JSONDecoder().decode(AdvertisementDetail.self, from: data)
    }
}
