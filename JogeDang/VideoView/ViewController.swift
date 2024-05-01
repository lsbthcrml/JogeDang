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

protocol ViewControllerDelegate {
    func addDanceTime(danceTime: TimeInterval)
}


class ViewController: UIViewController {

    let videoCapture = VideoCapture()
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    var delegate: ViewControllerDelegate?
    
    var pointsLayer = CAShapeLayer()

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
        if action == "Goyang" && confidence > 0.80 || action == "None" && confidence < 0.20 {
            print("Dance detected")
            delegate?.addDanceTime(danceTime: 0.1)
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
