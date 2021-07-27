//
//  CaptureSession.swift
//  ObjectDetector
//
//  Created by Nikita Lizogubov on 27/07/2021.
//

import Foundation
import AVFoundation
import Vision

enum CaptureInputError: Error {
    case captureDevice
}

protocol CoreMLRequestProtocol {
    func getRequest() throws -> VNCoreMLRequest
}

protocol CaptureInputProtocol {
    func getInput() throws -> AVCaptureInput
}

protocol CaptureOutputProtocol {
    func getOutput() throws -> AVCaptureOutput
}

protocol CaptureSessionProtocol {
    var session: AVCaptureSession { get }
    
    func addInput(captureInput: CaptureInputProtocol) throws
    func addOutput(captureOutput: CaptureOutputProtocol) throws
    
    func run()
}

final class CaptureSession: CaptureSessionProtocol {
    
    // MARK: - Private protperties
    
    let session: AVCaptureSession
    
    // MARK: - Init
    
    init() {
        self.session = AVCaptureSession()
    }
    
    // MARK: - Public methods
    
    func addInput(captureInput: CaptureInputProtocol) throws {
        session.addInput(try captureInput.getInput())
    }
    
    func addOutput(captureOutput: CaptureOutputProtocol) throws {
        session.addOutput(try captureOutput.getOutput())
    }
    
    func run() {
        session.startRunning()
    }
    
}
