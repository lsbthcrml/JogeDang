//
//  Predictor.swift
//  JogeDang
//
//  Created by Ibnu Nawawi on 30/04/24.
//
//
//  Predictor.swift
//  JogeDang
//
//  Created by Graciella Adriani Seciawanto on 29/04/24.
//

//import Foundation
//import Vision
//
//protocol PredictorDelegate : AnyObject {
//    func predictor(_ predictor: Predictor, didFindNewRecognizedPoints points: [CGPoint])
//}
//
//class Predictor {
//    
//    weak var delegate: PredictorDelegate?
//    
//    func estimation(sampleBuffer: CMSampleBuffer) {
//        let requestHandler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer, orientation: .up)
//        
//        let request = VNDetectHumanBodyPoseRequest(completionHandler: bodyPoseHandler)
//        
//        do {
//            try requestHandler.perform([request])
//        } catch {
//            print("Unable to perform the request, with error: \(error)")
//        }
//    }
//    func bodyPoseHandler(request: VNRequest, error: Error?){
//        guard let observation = request.results as? [VNHumanBodyPoseObservation] else {
//            return }
//        
//        observation.forEach {
//            processObservation($0)
//        }
//    }
//    
//    func processObservation(_ observation: VNHumanBodyPoseObservation) {
//        do {
//            let recognizedPoints = try observation.recognizedPoints(forGroupKey: .all)
//            
//            let displayedPoints = recognizedPoints.map {
//                CGPoint(x: $0.value.x, y: 1 - $0.value.y)
//                
//            }
//            delegate?.predictor(self, didFindNewRecognizedPoints: displayedPoints)
//        } catch {
//            print("error finding recognizedPoints")
//        }
//    }
//}

//NEWWWWW------

import Foundation
import Vision

typealias DanceClassifier = DanceModel

protocol PredictorDelegate : AnyObject {
    func predictor(_ predictor: Predictor, didFindNewRecognizedPoints points: [CGPoint])
    func predictor(_ predictor: Predictor,didLabelAction action: String, with confidence: Double)
}

class Predictor {

    weak var delegate: PredictorDelegate?

    let predictionWindowSize = 38
    var posesWindow: [VNHumanBodyPoseObservation] = []

    init() {
        posesWindow.reserveCapacity(predictionWindowSize)
    }

    func estimation(sampleBuffer: CMSampleBuffer) {
        let requestHandler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer, orientation: .up)
//        let requestHandler = VNSequenceRequestHandler()

        let request = VNDetectHumanBodyPoseRequest(completionHandler: bodyPoseHandler)

        do {
            try requestHandler.perform([request])
//            try requestHandler.perform([request], on: sampleBuffer, orientation: .up)
        } catch {
            print("Unable to perform the request, with error: \(error.localizedDescription)")
        }
    }
    
    func bodyPoseHandler(request: VNRequest, error: Error?){
        guard let observations = request.results as? [VNHumanBodyPoseObservation] else { return }

//        observations.first?.recognizedPoints(.all)
        observations.forEach {
            processObservation($0)
        }
        
        if let result = observations.first {
            storeObservation(result)
            labelActionType()
        }

    }
    
    func labelActionType() {
        guard let danceClassifier = try? DanceClassifier(configuration: MLModelConfiguration()),
              let poseMultiArray = prepareInputWithObservations(posesWindow),
              let predictions = try? danceClassifier.prediction(poses: poseMultiArray) else {
            return
        }
        let label = predictions.label
        let confidence = predictions.labelProbabilities[label] ?? 0

        delegate?.predictor(self, didLabelAction: label, with: confidence)
    }
    
    func prepareInputWithObservations(_ observation: [VNHumanBodyPoseObservation]) -> MLMultiArray? {
        let numAvailableFrames = observation.count
        let observationsNeeded = 60
        var multiArrayBuffer = [MLMultiArray]()

        for frameIndex in 0 ..< min(numAvailableFrames, observationsNeeded) {
            let pose = observation[frameIndex]
            do {
                let oneFrameMultiArray = try pose.keypointsMultiArray()
                multiArrayBuffer.append(oneFrameMultiArray)
            } catch {
                continue
            }
        }
        if numAvailableFrames < observationsNeeded {
            for _ in 0..<(observationsNeeded - numAvailableFrames) {
                do {
                    let oneFrameMultiArray = try MLMultiArray(shape: [1,3,18], dataType: MLMultiArrayDataType.double)
                    try resetMultiArray(oneFrameMultiArray)
                    multiArrayBuffer.append(oneFrameMultiArray)
                } catch {
                    continue
                }
            }
        }
        return MLMultiArray(concatenating: [MLMultiArray](multiArrayBuffer), axis: 0, dataType: .float)
    }
    
    func resetMultiArray(_ predictionWindow: MLMultiArray, with value: Double = 0.0) throws {
        let pointer = try UnsafeMutableBufferPointer<Double>(predictionWindow)
        pointer.initialize(repeating: value)

    }

    func storeObservation(_ observation: VNHumanBodyPoseObservation) {
        if posesWindow.count >= predictionWindowSize {
            posesWindow.removeFirst()
        }
        posesWindow.append(observation)
    }

    func processObservation(_ observation: VNHumanBodyPoseObservation) {
        do {
            let recognizedPoints = try observation.recognizedPoints(forGroupKey: .all)

            let displayedPoints = recognizedPoints.map {
                CGPoint(x: $0.value.x, y: 1 - $0.value.y)

            }
            delegate?.predictor(self, didFindNewRecognizedPoints: displayedPoints)
        } catch {
            print("error finding recognizedPoints")
        }
    }




}
