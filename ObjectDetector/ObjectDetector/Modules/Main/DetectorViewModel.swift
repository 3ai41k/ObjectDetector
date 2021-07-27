//
//  DetectorViewModel.swift
//  ObjectDetector
//
//  Created by Nikita Lizogubov on 28/07/2021.
//

import Foundation

protocol DetectorViewModelInputProtocol {
    var captureViewModel: CaptureViewModelInputProtocol { get }
}

protocol DetectorViewModelOutputProtocol {
    func startSession()
    func numberOfRowsInSection(_ section: Int) -> Int
    func textLabel(forRowAt indexPath: IndexPath) -> String
}

protocol DetectorViewModelBindiableProtocol {
    var reloadData: (() -> Void)? { get set }
}

final class DetectorViewModel: DetectorViewModelBindiableProtocol {
    
    // MARK: - Public properties
    
    var reloadData: (() -> Void)?
    
    // MARK: - Private properties
    
    private let captureSession: CaptureSessionProtocol
    private var captureInput: CaptureInputProtocol?
    private var captureOutput: CaptureOutputProtocol?
    
    private var detectedObjects: [DetectedObject] = [] {
        didSet {
            reloadData?()
        }
    }
    
    // MARK: - Init
    
    init() {
        self.captureSession = CaptureSession()
    }
    
}

// MARK: - DetectorViewModelInputProtocol

extension DetectorViewModel: DetectorViewModelInputProtocol {
    
    var captureViewModel: CaptureViewModelInputProtocol {
        CaptureViewModel(captureSession: captureSession)
    }
    
}

// MARK: - DetectorViewModelOutputProtocol

extension DetectorViewModel: DetectorViewModelOutputProtocol {
    
    func startSession() {
        let captureInput = VideoCaptureInput()
        let captureOutput = VideoCaptureOutput(requests: [
            MLRequest(modelURL: Resnet50.urlOfModelInThisBundle) { [weak self] in
                if $0.confidence >= Constants.minConfidence {
                    self?.detectedObjects.append($0)
                }
            }
        ])
        
        do {
            try captureSession.addInput(captureInput: captureInput)
            try captureSession.addOutput(captureOutput: captureOutput)
        
            captureSession.run()
            
            self.captureInput = captureInput
            self.captureOutput = captureOutput
        } catch {
            // TO DO: - Add error handling
            print(error.localizedDescription)
        }
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        detectedObjects.count
    }
    
    func textLabel(forRowAt indexPath: IndexPath) -> String {
        let object = detectedObjects.reversed()[indexPath.row]
        
        return String(format: "Name: %@; Confidence: %.2f", object.label, object.confidence)
    }
    
}

// MARK: - Constants

extension DetectorViewModel {
    
    private enum Constants {
        static let minConfidence: Float = 0.5
    }
    
}
 
