//
//  VideoCaptureInput.swift
//  ObjectDetector
//
//  Created by Nikita Lizogubov on 27/07/2021.
//

import Foundation
import AVFoundation

struct VideoCaptureInput: CaptureInputProtocol {
    
    func getInfo() throws -> AVCaptureInput {
        guard let device = AVCaptureDevice.default(for: .video) else { throw CaptureInputError.captureDevice }
        
        return try AVCaptureDeviceInput(device: device)
    }
    
}
