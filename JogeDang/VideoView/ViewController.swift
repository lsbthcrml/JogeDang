//
//  ViewController.swift
//  JogeDang
//
//  Created by Ibnu Nawawi on 30/04/24.
//


//import UIKit
//import AVFoundation
//
//class ViewController: UIViewController {
//    
//    let videoCapture = VideoCapture()
//    var previewLayer: AVCaptureVideoPreviewLayer?
//
//    
//    var pointsLayer = CAShapeLayer()
//    
//
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        
//        setupVideoPreview()
//        
//        videoCapture.predictor.delegate = self
//    }
//    
//    private func setupVideoPreview() {
//        videoCapture.starCaptureSession()
//        previewLayer = AVCaptureVideoPreviewLayer(session: videoCapture.captureSession)
//    
//        
//        guard let previewLayer = previewLayer else { return }
//        
//        view.layer.addSublayer(previewLayer)
//        previewLayer.frame = view.frame
//        
//        view.layer.addSublayer(pointsLayer)
//        pointsLayer.frame = view.frame
//        pointsLayer.strokeColor = UIColor.green.cgColor
//    }
//}
//
//extension ViewController: PredictorDelegate {
//    func predictor(_ predictor: Predictor, didFindNewRecognizedPoints points: [CGPoint]) {
//        guard let previewLayer = previewLayer else { return }
//        
//        let convertedPoints = points.map {
//            previewLayer.layerPointConverted(fromCaptureDevicePoint: $0)
//        }
//        let combinePath = CGMutablePath()
//        
//        for point in convertedPoints {
//            let dotPath = UIBezierPath(ovalIn: CGRect(x: point.x, y: point.y, width: 10, height: 10))
//            combinePath.addPath(dotPath.cgPath)
//        }
//        
//        pointsLayer.path = combinePath
//        
//        DispatchQueue.main.async {
//            self.pointsLayer.didChangeValue(for: \.path)
//            
//        }
//        
//    }
//    
//}

//NEWWW -----


import UIKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController {

    let videoCapture = VideoCapture()
    var previewLayer: AVCaptureVideoPreviewLayer?

    var pointsLayer = CAShapeLayer()

    var isDanceDetected = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setupVideoPreview()

        videoCapture.predictor.delegate = self
    }

    private func setupVideoPreview() {
        videoCapture.starCaptureSession()
        previewLayer = AVCaptureVideoPreviewLayer(session: videoCapture.captureSession)


        guard let previewLayer = previewLayer else { return }

        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame

        view.layer.addSublayer(pointsLayer)
        pointsLayer.frame = view.frame
        pointsLayer.strokeColor = UIColor.green.cgColor
    }
}

extension ViewController: PredictorDelegate {
    func predictor(_ predictor: Predictor, didLabelAction action: String, with confidence: Double) {
        if action == "dance" && confidence > 0.90 && isDanceDetected == false {
            print("Dance detected")
            isDanceDetected = true

            DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                self.isDanceDetected = false
            }
            DispatchQueue.main.async {
                AudioServicesPlayAlertSound(SystemSoundID(1322))
            }
        }
    }

    func predictor(_ predictor: Predictor, didFindNewRecognizedPoints points: [CGPoint]) {
        guard let previewLayer = previewLayer else { return }

        let convertedPoints = points.map {
            previewLayer.layerPointConverted(fromCaptureDevicePoint: $0)
        }
        let combinePath = CGMutablePath()

        for point in convertedPoints {
            let dotPath = UIBezierPath(ovalIn: CGRect(x: point.x, y: point.y, width: 10, height: 10))
            combinePath.addPath(dotPath.cgPath)
        }

        pointsLayer.path = combinePath

        DispatchQueue.main.async {
            self.pointsLayer.didChangeValue(for: \.path)

        }

    }

}
