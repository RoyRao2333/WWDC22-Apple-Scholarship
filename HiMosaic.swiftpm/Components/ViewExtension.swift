//
//  ViewExtension.swift
//
//  Created by Roy Rao on 2021/4/12.
//

import SwiftUI
import Combine

// MARK: Common -
extension View {
    
    /**
     * Display your `View` conditionally.
     *
     * - Parameters:
     *      - conditional: The condition you wanna check.
     *      - ifTure: What you wanna do if checked true.
     *      - ifFalse: What you wanna do if checked false.
     */
    @ViewBuilder
    func `if`<Content: View>(_ conditional: Bool, if ifTure: ((Self) -> Content)?, else ifFalse: ((Self) -> Content)?) -> some View {
        if conditional {
            if ifTure != nil {
                ifTure!(self)
            } else {
                self
            }
        } else {
            if ifFalse != nil {
                ifFalse!(self)
            } else {
                self
            }
        }
    }
    
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .isHidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder
    func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            } else {
                EmptyView()
            }
        } else {
            self
        }
    }
    
    /// A backwards compatible wrapper for iOS 14 `onChange`.
    @ViewBuilder
    func valueChanged<T: Equatable>(value: T, onChange: @escaping (T) -> Void) -> some View {
        if #available(iOS 14.0, *) {
            self.onChange(of: value, perform: onChange)
        } else {
            self.onReceive(Just(value)) { (value) in
                onChange(value)
            }
        }
    }

    @ViewBuilder
    func adaptedOverlay<Content: View>(alignment: Alignment = .center, @ViewBuilder content: () -> Content) -> some View {
        if #available(iOS 15.0, *) {
            self.overlay(alignment: alignment, content: content)
        } else {
            self.overlay(content(), alignment: alignment)
        }
    }
}


// MARK: iOS -
#if canImport(UIKit)

import UIKit

extension View {

    /// Set if enable the scroll function in `List`s.
    func scrollEnabled(_ value: Bool) -> some View {
        self.onAppear {
            UITableView.appearance().isScrollEnabled = value
        }
    }
    
    /// Hide keyboard when tap outside the TextField
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
    
    var screenRect: CGRect {
        UIScreen.main.bounds
    }

    var snapshot: UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

extension UIView {
    
    /// Hide keyboard when tap outside the TextField
    @objc func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }

    /// Load the view from nib (xib) file.
    static func loadFromNib(bundle: Bundle? = nil) -> Self {
        let named = String(describing: Self.self)
        guard
            let view = UINib(nibName: named, bundle: bundle)
                .instantiate(withOwner: nil, options: nil)
                .first as? Self
        else {
            fatalError("First element in xib file \(named) is not of type \(named)")
        }
        
        return view
    }
    
    var snapshot: UIImage {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        return renderer.image { [weak self] _ in
            self?.drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }

    /// ???????????? draw ???????????? UILabel ???????????????
    /// - Parameters:
    ///   - corners: ???????????????
    ///   - cornerRadius: ??????
    func addLayerCornerRadius(
        _ corners: CACornerMask = [.layerMinXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner],
        cornerRadius: CGFloat
    ) {
        if self is UILabel {
            layer.masksToBounds = true
        }
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = corners
    }
    
    /// View ?????? border ??????
    /// - Parameters:
    ///   - borderWidth: ??????
    ///   - borderColor: ??????
    func layerBorderStyles(with borderWidth: CGFloat, borderColor: UIColor?) {
        layer.borderWidth = borderWidth
        if let bColor = borderColor {
            layer.borderColor = bColor.cgColor
        }
    }

    /// ????????????
    func addLayerShadowPath(
        cornerRadius: CGFloat,
        shadowOffset: CGSize = CGSize(width: 0, height: 2),
        shadowOpacity: Float = 0.2,
        shadowRadius: CGFloat = 2.0,
        shadowColor: UIColor = UIColor.black
    ) {
        addLayerShadowPath(
            cornerRadius: cornerRadius,
            rect: bounds,
            shadowOffset: shadowOffset,
            shadowOpacity: shadowOpacity,
            shadowRadius: shadowRadius,
            shadowColor: shadowColor,
            path: nil
        )
    }
    
    /// ????????????
    /// - Parameters:
    ///   - cornerRadius: ??????
    ///   - rect: CGRect
    ///   - shadowOffset: // width -> x height -> y
    ///   - shadowOpacity: ???????????????
    ///   - shadowRadius: ????????????
    ///   - shadowColor: ??????
    ///   - corners: ??????
    ///   - path: ??????
    func addLayerShadowPath(
        cornerRadius: CGFloat,
        rect: CGRect,
        shadowOffset: CGSize = CGSize(width: 0, height: 2),
        shadowOpacity: Float = 0.2,
        shadowRadius: CGFloat = 2.0,
        shadowColor: UIColor = UIColor.black,
        corners: UIRectCorner? = nil,
        path: UIBezierPath? = nil
    ) {
        let shadowPath: UIBezierPath
        if let `path` = path {
            shadowPath = path
        } else {
            if let `corners` = corners, cornerRadius != 0 {
                shadowPath = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            } else if cornerRadius != 0 {
                shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
            } else {
                shadowPath = UIBezierPath(rect: rect)
            }
        }
        
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowPath = shadowPath.cgPath
    }
}

#endif
