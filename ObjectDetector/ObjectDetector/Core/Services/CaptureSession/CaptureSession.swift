//
//  CaptureSession.swift
//  ObjectDetector
//
//  Created by Nikita Lizogubov on 27/07/2021.
//

import Foundation
import AVFoundation

enum CaptureInputError: Error {
    case captureDevice
}

protocol CaptureInputProtocol {
    func getInfo() throws -> AVCaptureInput
}

final class CaptureSession {
    
    // MARK: - Private protperties
    
    let session: AVCaptureSession
    
    // MARK: - Init
    
    init() {
        self.session = AVCaptureSession()
    }
    
    // MARK: - Public methods
    
    func addInput(captureInput: CaptureInputProtocol) throws {
        session.addInput(try captureInput.getInfo())
    }
    
    func run() {
        session.startRunning()
    }
    
}
