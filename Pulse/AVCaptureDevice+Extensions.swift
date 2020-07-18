//
//  AVCaptureDevice+Extensions.swift
//  Pulse
//
//  Created by Athanasios Papazoglou on 18/7/20.
//  Copyright © 2020 Athanasios Papazoglou. All rights reserved.
//

import Foundation
import AVFoundation

extension AVCaptureDevice {
    func toggleTorch(on: Bool) {
        guard hasTorch, isTorchAvailable else {
            print("Torch is not available")
            return
        }
        do {
            try lockForConfiguration()
            torchMode = on ? .on : .off
            unlockForConfiguration()
        } catch {
            print("Torch could not be used \(error)")
        }
    }
}
