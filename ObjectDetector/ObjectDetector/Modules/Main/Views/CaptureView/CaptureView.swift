//
//  CaptureView.swift
//  ObjectDetector
//
//  Created by Nikita Lizogubov on 27/07/2021.
//

import UIKit
import AVFoundation

final class CaptureView: XibView {
    
    // MARK: - Private properties
    
    private var videoLayer: CALayer!
    
    // MARK: - Public properties
    
    var viewModel: CaptureViewModelInputProtocol? {
        didSet {
            bindViewModel()
        }
    }
    
    // MARK: - Override
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        videoLayer.frame = containerView.layer.frame
    }
    
    // MARK: - Private methods
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        videoLayer = AVCaptureVideoPreviewLayer(session: viewModel.session)
        
        containerView.layer.addSublayer(videoLayer)
    }
    
}
