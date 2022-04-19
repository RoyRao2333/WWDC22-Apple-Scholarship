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
        let textRequest = VNDetectTextRectanglesRequest(completionHandler: onDetectedText)
        textRequest.reportCharacterBoxes = true
        
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
            let observations = request?.results as? [VNTextObservation],
            error == nil
        else { return }
        
//        let items = observations.compactMap { obs -> TextItem? in
//
//            if let str = obs.topCandidates(1).first?.string {
//                return TextItem(text: str)
//            }
//            return nil
//        }
        print("Observations are \(observations)")
        
//        textItems = items
    }
}
