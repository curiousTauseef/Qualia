//
//  RecordButton.swift
//  qualia
//
//  Created by Kirk Roerig on 3/25/18.
//  Copyright © 2018 Kirk Roerig. All rights reserved.
//

import UIKit

class RecordButtonView: UIButton {

    private var _isRecording = false;
    var isRecording : Bool {
        get {
            return _isRecording;
        }
        set {
            _isRecording = newValue
            
            UIView.animate(withDuration: 0.25) {
                if self._isRecording {
                    self.cornerRadius = 0
                    self.backgroundColor = .red
                }
                else {
                    self.cornerRadius = 32
                    self.backgroundColor = .green
                }
            }
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
