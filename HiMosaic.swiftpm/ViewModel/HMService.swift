//
//  HMService.swift
//  
//
//  Created by roy on 2022/4/18.
//

import UIKit
import Vision

class HMService: ObservableObject {
    static let shared = HMService()
    
    @Published var textItems: [TextItem] = []
    var presets: Set<RegexPattern> = []
    
    private init() {}
}

// MARK: Shared Methods -
extension HMService {
    
    func recognizeText(in uiImage: UIImage?) {
        guard
            let cgImage = uiImage?.cgImage,
            let orientation = uiImage?.imageOrientation
        else { return }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, orientation: .init(orientation))
        let textRequest = VNRecognizeTextRequest(completionHandler: onDetectedText)
        textRequest.recognitionLevel = .accurate
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let weakSelf = self else { return }
            
            do {
                try handler.perform([textRequest])
            } catch {
                weakSelf.textItems = []
                print("DEBUG: Recognizing text failed with error: \(error)")
            }
        }
    }
}

// MARK: Private Methods -
extension HMService {
    
    private func onDetectedText(request: VNRequest?, error: Error?) {
        guard
            let observations = request?.results as? [VNRecognizedTextObservation],
            error == nil
        else { return }
        
        let items = observations.map {
            TextItem(
                text: $0.topCandidates(1).first?.string,
                normalizedRect: observation2Rect(obs: $0),
                type: .name
            )
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.textItems = items
        }
    }
    
    private func observation2Rect(obs: VNRecognizedTextObservation) -> CGRect {
        guard let candidate = obs.topCandidates(1).first else { return .zero }
        
        let stringRange = candidate.string.startIndex ..< candidate.string.endIndex
        let boxObs = try? candidate.boundingBox(for: stringRange)
        let boundingBox = boxObs?.boundingBox ?? .zero
        let bottomToTopTransform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -1)
        let rect = boundingBox.applying(bottomToTopTransform)
        
        return rect
    }
}
