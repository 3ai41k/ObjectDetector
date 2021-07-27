//
//  MLRequest.swift
//  ObjectDetector
//
//  Created by Nikita Lizogubov on 28/07/2021.
//

import Foundation
import Vision

struct MLRequest {
    
    // MARK: - Private methods
    
    private let modelURL: URL
    private let completion: (DetectedObject) -> Void
    
    // MARK: - Init
    
    init(modelURL: URL, completion: @escaping (DetectedObject) -> Void) {
        self.modelURL = modelURL
        self.completion = completion
    }
}

// MARK: - CoreMLRequestProtocol

extension MLRequest: CoreMLRequestProtocol {
    
    func getRequest() throws -> VNCoreMLRequest {
        let model = try VNCoreMLModel(for: MLModel(contentsOf: modelURL))
        
        return VNCoreMLRequest(model: model) { (request, error) in
            guard
                let results = request.results as? [VNClassificationObservation],
                let result = results.first
            else {
                return
            }
            
            DispatchQueue.main.async {
                completion(DetectedObject(result))
            }
        }
    }
    
}
