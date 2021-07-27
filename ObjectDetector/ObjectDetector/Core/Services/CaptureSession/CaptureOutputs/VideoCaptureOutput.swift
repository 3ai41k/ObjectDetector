//
//  VideoCaptureOutput.swift
//  ObjectDetector
//
//  Created by Nikita Lizogubov on 27/07/2021.
//

import Foundation
import AVFoundation
import Vision

final class VideoCaptureOutput: NSObject {
    
    private let requests: [CoreMLRequestProtocol]
    private let queue: DispatchQueue
    
    // MARK: - Init
    
    init(requests: [CoreMLRequestProtocol]) {
        self.requests = requests
        self.queue = DispatchQueue(label: "VideoCaptureOutputQueue", qos: .utility)
    
        super.init()
    }
    
}

// MARK: - CaptureOutputProtocol

extension VideoCaptureOutput: CaptureOutputProtocol {
    
    func getOutput() throws -> AVCaptureOutput {
        let output = AVCaptureVideoDataOutput()
        output.setSampleBufferDelegate(self, queue: queue)
        
        return output
    }
    
}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate

extension VideoCaptureOutput: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let buffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        // TO DO: Add error handling
        
        try? VNImageRequestHandler(cvPixelBuffer: buffer, options: [:]).perform(requests.compactMap({ try? $0.getRequest() }))
    }
    
}
