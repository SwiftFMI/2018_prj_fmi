//
//  GradientView.swift
//  FMI App
//
//  Created by Hristiyan Zahariev on 23.02.19.
//  Copyright © 2019 fmi-swift. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
public class GradientView: UIView {

    private struct Layout {
        static let invalidMidPoint: Double = -1

        static let defaultColors: [UIColor] = [UIColor.clear, UIColor.white]

        static let defaultDirectionStart = CGPoint(x: 0, y: 0.5)
        static let defaultDirectionEnd = CGPoint(x: 1, y: 0.5)
    }
    private var gradientLayer: CAGradientLayer? {
        return layer as? CAGradientLayer
    }

    @IBInspectable public var topGradientColor: UIColor = UIColor.clear {
        didSet {
            let colors = (gradientLayer?.colors as? [CGColor])?.map({ UIColor(cgColor: $0) }) ?? Layout.defaultColors
            let newColors = [topGradientColor] + colors.dropFirst()
            gradientLayer?.colors = newColors.map { $0.cgColor }
        }
    }
    @IBInspectable public var bottomGradientColor: UIColor = UIColor.white {
        didSet {
            let colors = (gradientLayer?.colors as? [CGColor])?.map({ UIColor(cgColor: $0) }) ?? Layout.defaultColors
            let newColors = colors.dropLast() + [bottomGradientColor]
            gradientLayer?.colors = newColors.map { $0.cgColor }
        }
    }

    @IBInspectable public var startPoint: CGPoint = Layout.defaultDirectionStart {
        didSet {
            gradientLayer?.startPoint = startPoint
        }
    }
    @IBInspectable public var endPoint: CGPoint = Layout.defaultDirectionEnd {
        didSet {
            gradientLayer?.endPoint = endPoint
        }
    }
    // this property dictates where the first color ends and the second starts (there may be more than two colors)
    @IBInspectable public var midPoint: Double = Layout.invalidMidPoint {
        didSet {
            guard midPoint != Layout.invalidMidPoint else {
                return
            }

            let locations = (gradientLayer?.locations as? [Double]) ?? []
            let newLocations = [0.0, midPoint] + locations.dropFirst(2)
            gradientLayer?.locations = newLocations.map { NSNumber(value: $0) }
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGradientLayer()
    }

    init(frame: CGRect, colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        super.init(frame: frame)
        setupGradientLayer(colors: colors, startPoint: startPoint, endPoint: endPoint)
    }

    // MARK: - Private
    private func setupGradientLayer(colors: [UIColor] = Layout.defaultColors,
                                    startPoint: CGPoint = Layout.defaultDirectionStart,
                                    endPoint: CGPoint = Layout.defaultDirectionEnd) {
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        isUserInteractionEnabled = false

        let newColors = colors.isEmpty ? [topGradientColor, bottomGradientColor] : colors
        gradientLayer?.colors = newColors.map { $0.cgColor }
        self.startPoint = startPoint
        self.endPoint = endPoint

        layer.frame = self.bounds
    }

    override public class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}
