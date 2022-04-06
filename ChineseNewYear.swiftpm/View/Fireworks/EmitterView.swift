//
//  EmitterView.swift
//
//  Created by roy on 2022/2/25.
//

import SwiftUI

struct EmitterView: UIViewRepresentable {
    var frameSize: CGSize
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterPosition = CGPoint(x: frameSize.width / 2, y: frameSize.height - 100)
        emitterLayer.renderMode = .additive
        emitterLayer.emitterCells = createEmitterCells()
        
        view.layer.addSublayer(emitterLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
    
    private func createEmitterCells() -> [CAEmitterCell] {
        // Launch Point
        let baseCell = CAEmitterCell()
        baseCell.color = UIColor.systemOrange.withAlphaComponent(0.8).cgColor
        baseCell.emissionLongitude = -.pi / 2
        baseCell.emissionLatitude = 0
        baseCell.emissionRange = .pi / 5
        baseCell.lifetime = 2
        baseCell.birthRate = 1
        baseCell.velocity = 400
        baseCell.velocityRange = 50
//        baseCell.yAcceleration = 80
        baseCell.redRange   = 0.5
        baseCell.greenRange = 0.5
        baseCell.blueRange  = 0.5
        baseCell.alphaRange = 0.5
        baseCell.scale = 0.2
        
        // Rising Animation
        let risingCell = CAEmitterCell()
        risingCell.contents = UIImage(named: "particle")?.cgImage
        risingCell.emissionLongitude = (.pi * 4) / 2
        risingCell.emissionRange = .pi / 7
        risingCell.scale = 0.4
        risingCell.velocity = 100
        risingCell.birthRate = 50
        risingCell.lifetime = 1.49
//        risingCell.yAcceleration = 350
        risingCell.alphaSpeed = -0.7
        risingCell.scaleSpeed = -0.1
        risingCell.scaleRange = 0.1
        risingCell.beginTime = 0.01
        risingCell.duration = 1.5
        
        // Spark Animation
        let sparkCell = CAEmitterCell()
        sparkCell.contents = UIImage(named: "particle")?.cgImage
        sparkCell.emissionRange = .pi * 2
        sparkCell.birthRate = 8000
        sparkCell.scale = 0.5
        sparkCell.velocity = 130
        sparkCell.lifetime = 3
        sparkCell.yAcceleration = 80
        sparkCell.beginTime = 1.5
        sparkCell.duration = 0.1
        sparkCell.alphaSpeed = -0.1
        sparkCell.scaleSpeed = -0.1
        
        baseCell.emitterCells = [risingCell, sparkCell]
        
        return [baseCell]
    }
}
