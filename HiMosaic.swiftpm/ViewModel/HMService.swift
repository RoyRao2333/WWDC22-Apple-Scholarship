//
//  HMService.swift
//
//
//  Created by roy on 2022/4/18.
//

import UIKit
import Vision

class HMService: NSObject, ObservableObject {
    static let shared = HMService()
    
    @Published var alert: AlertInfo?
    @Published private(set) var rawTextItems: [TextItem] = []
    @Published private(set) var nameItems: [TextItem] = []
    @Published private(set) var numberItems: [TextItem] = []
    @Published private(set) var phoneNumberItems: [TextItem] = []
    @Published private(set) var emailItems: [TextItem] = []
    @Published private(set) var urlItems: [TextItem] = []
    @Published private(set) var creditCardNumberItems: [TextItem] = []
    @Published var onStartup = true
    
    private override init() {}
}

// MARK: Shared Methods -

extension HMService {
    func recognizeText(in uiImage: UIImage?) {
        guard
            let cgImage = uiImage?.cgImage,
            let orientation = uiImage?.imageOrientation
        else { return }
        
        rawTextItems.removeAll()
        nameItems.removeAll()
        numberItems.removeAll()
        phoneNumberItems.removeAll()
        emailItems.removeAll()
        urlItems.removeAll()
        creditCardNumberItems.removeAll()
        
        let handler = VNImageRequestHandler(cgImage: cgImage, orientation: .init(orientation))
        let textRequest = VNRecognizeTextRequest(completionHandler: onDetectedText)
        textRequest.recognitionLevel = .accurate
        
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([textRequest])
            } catch {
                print("DEBUG: Recognizing text failed with error: \(error)")
            }
        }
    }
    
    @objc func saveImage(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            alert = .init(
                id: .failure,
                title: "Failed!",
                message: "Save image to album failed with error: \(error.localizedDescription)"
            )
        } else {
            alert = .init(
                id: .success,
                title: "Success!",
                message: "Image saved to album."
            )
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
        
        observations.forEach { obs in
            DispatchQueue.main.async { [weak self] in
                self?.processObservation(obs: obs)
            }
        }
    }
    
    private func processObservation(obs: VNRecognizedTextObservation) {
        guard let candidate = obs.topCandidates(1).first else { return }
        
        let bottomToTopTransform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -1)
        let fullRange = candidate.string.startIndex ..< candidate.string.endIndex
        let rawBox = (try? candidate.boundingBox(for: fullRange)?.boundingBox) ?? .zero
        let rawRect = rawBox.applying(bottomToTopTransform)
        let rawItem = TextItem(text: candidate.string, normalizedRect: rawRect)
        rawTextItems.append(rawItem)
        
        for pattern in RegexPattern.allCases {
            if let range = candidate.string.range(of: pattern.rawValue, options: .regularExpression) {
                let matchedBox = (try? candidate.boundingBox(for: range)?.boundingBox) ?? .zero
                let matchedRect = matchedBox.applying(bottomToTopTransform)
                let matchedItem = TextItem(text: String(candidate.string[range]), normalizedRect: matchedRect)
                
                switch pattern {
                    case .number:
                        numberItems.append(matchedItem)
                    case .phoneNumber:
                        phoneNumberItems.append(matchedItem)
                    case .email:
                        emailItems.append(matchedItem)
                    case .url:
                        urlItems.append(matchedItem)
                    case .creditCardNumber:
                        creditCardNumberItems.append(matchedItem)
                }
            }
        }
    }
}
