//
//  DetectorViewController.swift
//  ObjectDetector
//
//  Created by Nikita Lizogubov on 27/07/2021.
//

import UIKit
import AVFoundation

final class DetectorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = CaptureSession()
        
        try? session.addInput(captureInput: VideoCaptureInput())
        
        session.run()
        
        let layer = AVCaptureVideoPreviewLayer(session: session.session)
        
        view.layer.addSublayer(layer)
        
        layer.frame = view.frame
    }


}

