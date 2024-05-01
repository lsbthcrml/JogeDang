//
//  VideoCapture.swift
//  JogeDang
//
//  Created by Ibnu Nawawi on 30/04/24.
//

import Foundation
import AVFoundation

class VideoCapture: NSObject {
    static let shared = VideoCapture()
    let captureSession = AVCaptureSession()
    let videoOutput = AVCaptureVideoDataOutput()
    let predictor = Predictor()
    
    override init() {
        super.init()
        
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let input = try? AVCaptureDeviceInput(device: captureDevice) else {
            return
        }
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        captureSession.addInput(input)
        
        captureSession.addOutput(videoOutput)
        videoOutput.alwaysDiscardsLateVideoFrames = true
    }
    
    func starCaptureSession() {
        DispatchQueue.global().async {
            self.captureSession.startRunning()
            self.videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "viewDispatchQueue"))
        }
    }
}
extension VideoCapture: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        predictor.estimation(sampleBuffer: sampleBuffer)
    }
}
