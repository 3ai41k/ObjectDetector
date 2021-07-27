//
//  DetectorViewController.swift
//  ObjectDetector
//
//  Created by Nikita Lizogubov on 27/07/2021.
//

import UIKit

typealias DetectorViewModelType =
    DetectorViewModelInputProtocol &
    DetectorViewModelOutputProtocol &
    DetectorViewModelBindiableProtocol

final class DetectorViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var captureView: CaptureView!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            
            tableView.layer.cornerRadius = 30.0
            tableView.layer.borderWidth = 1.0
            tableView.layer.borderColor = UIColor.systemGray6.cgColor
        }
    }
    
    // MARK: - Private properties
    
    private var viewModel: DetectorViewModelType?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializComponents()
    }
    
    // MARK: - Private methods
    
    private func initializComponents() {
        viewModel = DetectorViewModel()
        viewModel?.reloadData = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel?.startSession()
        
        captureView.viewModel = viewModel?.captureViewModel
    }
    
}

// MARK: - UITableViewDataSource

extension DetectorViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRowsInSection(section) ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel?.textLabel(forRowAt: indexPath)
        cell.textLabel?.numberOfLines = .zero
        
        return cell
    }
    
}

