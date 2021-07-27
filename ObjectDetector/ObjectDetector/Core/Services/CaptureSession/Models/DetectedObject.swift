//
//  DetectedObject.swift
//  ObjectDetector
//
//  Created by Nikita Lizogubov on 28/07/2021.
//

import Foundation
import Vision

struct DetectedObject {
    let label: String
    let confidence: Float
    
    init(_ classificationObservation: VNClassificationObservation) {
        self.label = classificationObservation.identifier
        self.confidence = classificationObservation.confidence
    }
}
