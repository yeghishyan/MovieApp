//
//  GlassMorphicView.swift
//

import SwiftUI

struct GlassMorphicView: UIViewRepresentable {
    var effect: UIBlurEffect.Style
    var onChange: (UIVisualEffectView)->()
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: effect))
        view.gaussianBlurValue = 4
        view.saturationAmount = 8
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        DispatchQueue.main.async {
            onChange(uiView)
        }
    }
}

extension UIVisualEffectView {
    private var backDrop: NSObject? {
        return subView(forClass: NSClassFromString("_UIVisualEffectBackdropView"))
    }

    private var gaussianBlur: NSObject? {
        return backDrop?.value(key: "filters", filter: "gaussianBlur")
    }
    
    private var saturation: NSObject? {
        return backDrop?.value(key: "filters", filter: "colorSaturate")
    }
    
    private func applyNewEffects() {
        backDrop?.perform(Selector(("applyRequestedFilterEffects")))
    }

    public var gaussianBlurValue: CGFloat {
        get {
            return gaussianBlur?.values?["inputRadiug"] as? CGFloat ?? 0
        }
        set {
            gaussianBlur?.values?["inputRadius"] = newValue
            applyNewEffects()
        }
    }
    
    public var saturationAmount: CGFloat {
        get {
            return saturation?.values?["inputRadiug"] as? CGFloat ?? 0
        }
        set {
            saturation?.values?["inputRadius"] = newValue
            applyNewEffects()
        }
    }
}

extension UIView{
    func subView(forClass: AnyClass?)->UIView?{
        return subviews.first { view in
            type(of: view) == forClass
        }
    }
}

extension NSObject {
    var values: [String:Any]? {
        get {
            return value(forKeyPath: "requestedValues") as? [String: Any]
        }
        set {
            setValue(newValue, forKeyPath: "requestedValues")
        }
    }
    
    
    func value(key: String,filter: String)->NSObject?{
        (value(forKey: key) as? [NSObject])?.first(where: { obj in
            return obj.value(forKeyPath: "filterType") as? String == filter
        })
    }
}

