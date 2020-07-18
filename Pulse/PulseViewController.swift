//
//  PulseViewController.swift
//  Pulse
//
//  Created by Athanasios Papazoglou on 18/7/20.
//  Copyright © 2020 Athanasios Papazoglou. All rights reserved.
//

import UIKit
import AVFoundation

class PulseViewController: UIViewController {
    
    @IBOutlet weak var previewLayerShadowView: UIView!
    @IBOutlet weak var previewLayer: UIView!
    
    private var heartRateManager: HeartRateManager!
    
    init() {
        super.init(nibName: "PulseViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVideoCapture()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupPreviewView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initCaptureSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deinitCaptureSession()
    }
    
    // MARK: - Setup Views
    private func setupPreviewView() {
        previewLayer.layer.cornerRadius = 10.0
        previewLayer.layer.masksToBounds = true
        
        previewLayerShadowView.backgroundColor = .clear
        previewLayerShadowView.layer.shadowColor = UIColor.black.cgColor
        previewLayerShadowView.layer.shadowOpacity = 0.25
        previewLayerShadowView.layer.shadowOffset = CGSize(width: 0, height: 3)
        previewLayerShadowView.layer.shadowRadius = 3
        previewLayerShadowView.clipsToBounds = false
    }
    
    // MARK: - Frames Capture Methods
    private func initVideoCapture() {
        let specs = VideoSpec(fps: 30, size: CGSize(width: 300, height: 300))
        heartRateManager = HeartRateManager(cameraType: .back, preferredSpec: specs, previewContainer: previewLayer.layer)
        heartRateManager.imageBufferHandler = { [unowned self] (_) in
            
        }
    }
    
    // MARK: - AVCaptureSession Helpers
    private func initCaptureSession() {
        heartRateManager.startCapture()
    }
    
    private func deinitCaptureSession() {
        heartRateManager.stopCapture()
    }
    
    private func toggleTorch(status: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        device.toggleTorch(on: status)
    }
}
