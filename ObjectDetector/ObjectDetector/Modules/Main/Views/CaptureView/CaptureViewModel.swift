//
//  CaptureViewModel.swift
//  ObjectDetector
//
//  Created by Nikita Lizogubov on 27/07/2021.
//

import UIKit
import AVFoundation

protocol CaptureViewModelInputProtocol {
    var session: AVCaptureSession { get }
}

final class CaptureViewModel {
    
    // MARK: - Private properties
    
    private let captureSession: CaptureSessionProtocol
    
    // MARK: - Init
    
    init(captureSession: CaptureSessionProtocol) {
        self.captureSession = captureSession
    }
    
}

// MARK: - CaptureViewModelInputProtocol

extension CaptureViewModel: CaptureViewModelInputProtocol {
    
    var session: AVCaptureSession {
        captureSession.session
    }
    
}
