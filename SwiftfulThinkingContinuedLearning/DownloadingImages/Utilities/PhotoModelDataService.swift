//
//  PhotoModelDataService.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Lahiru Amarasooriya on 2025-09-28.
//

import Foundation
import Combine

class PhotoModelDataService {
    var cancellables = Set<AnyCancellable>()
    
    @Published var photoModels: [PhotoModel] = []
    
    static let instance = PhotoModelDataService()
    
    private init() {
        downloadData()
    }
    
    func downloadData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            // Transform each model BEFORE assigning to photoModels
            .map { models in
                models.map { model in
                    return PhotoModel(
                        albumId: model.albumId,
                        id: model.id,
                        title: model.title,
                        url: "https://picsum.photos/200",
                        thumbnailUrl: "https://picsum.photos/200"
                    )
                }
            }
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error downloading data. \(error)")
                }
            } receiveValue: { [weak self] (returnedPhotoModels) in
                self?.photoModels = returnedPhotoModels
            }
            .store(in: &cancellables)
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
