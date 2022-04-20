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
        
        if !textItems.isEmpty { textItems = [] }
        
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
        
        let items = observations.map { obs -> TextItem in
            let result = processObservation(obs: obs)
            return TextItem(
                text: obs.topCandidates(1).first?.string,
                normalizedRect: result.rect,
                type: result.type
            )
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.textItems = items
        }
    }
    
    private func processObservation(obs: VNRecognizedTextObservation) -> (type: RegexPattern?, rect: CGRect) {
        guard let candidate = obs.topCandidates(1).first else { return (nil, .zero) }
        
        var stringRange = candidate.string.startIndex ..< candidate.string.endIndex
        var stringType: RegexPattern?
        for pattern in RegexPattern.allCases {
            if let range = candidate.string.range(of: pattern.rawValue, options: .regularExpression) {
                stringRange = range
                stringType = pattern
                break
            }
        }
        
        let boxObs = try? candidate.boundingBox(for: stringRange)
        let boundingBox = boxObs?.boundingBox ?? .zero
        let bottomToTopTransform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -1)
        let rect = boundingBox.applying(bottomToTopTransform)
        
        return (stringType, rect)
    }
}
