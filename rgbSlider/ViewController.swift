//
//  ViewController.swift
//  rgbSlider
//
//  Created by Rameses Resuena on 2017-05-20.
//  Copyright © 2017 Rameses Resuena. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rLabel: UILabel!
    @IBOutlet weak var r2Label: UILabel!
    @IBOutlet weak var gLabel: UILabel!
    @IBOutlet weak var g2Label: UILabel!
    @IBOutlet weak var bLabel: UILabel!
    @IBOutlet weak var b2Label: UILabel!
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    @IBOutlet weak var redValue: UILabel!
    @IBOutlet weak var greenValue: UILabel!
    @IBOutlet weak var blueValue: UILabel!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBAction func numberKeypadDismiss(_ sender: UITapGestureRecognizer) {
        redTextField.resignFirstResponder()
        greenTextField.resignFirstResponder()
        blueTextField.resignFirstResponder()
    }
    
    private var red = Double()
    private var green = Double()
    private var blue = Double()
    private let alpha: CGFloat = 1.0
    private let maxRGBValue = 255.0
    
    func getRedValue(cleared: Bool) {
        switch cleared {
        case false:
            if redTextField.text != redValue.text {
                if redTextField.text!.isEmpty {
                    red = Double(redSlider.value)
                } else {
                    red = Double(redTextField.text!)!
                    redSlider.value = Float(red)
                }
            } else {
                red = Double(redSlider.value)
            }
        default:
            red = 0.0
            redSlider.value = Float(red)
        }
        redValue.text = String(Int(red))
        redTextField.text = String(Int(red))
    }
    
    func getGreenValue(cleared: Bool) {
        switch cleared {
        case false:
            if greenTextField.text != greenValue.text{
                if greenTextField.text!.isEmpty {
                    green = Double(greenSlider.value)
                } else {
                    green = Double(greenTextField.text!)!
                    greenSlider.value = Float(green)
                }
            } else {
                green = Double(greenSlider.value)
            }
        default:
            green = 0.0
            greenSlider.value = Float(red)
        }
        greenValue.text = String(Int(green))
        greenTextField.text = String(Int(green))
    }
    
    func getBlueValue(cleared: Bool) {
        switch cleared {
        case false:
            if blueTextField.text != blueValue.text{
                if blueTextField.text!.isEmpty {
                    blue = Double(blueSlider.value)
                } else {
                    blue = Double(blueTextField.text!)!
                    blueSlider.value = Float(blue)
                }
            } else {
                blue = Double(blueSlider.value)
            }
        default:
            blue = 0.0
            blueSlider.value = Float(blue)
        }
        blueValue.text = String(Int(blue))
        blueTextField.text = String(Int(blue))
    }
    
    func changeTextToWhite() {
        titleLabel.textColor = UIColor.white
        rLabel.textColor = UIColor.white
        gLabel.textColor = UIColor.white
        bLabel.textColor = UIColor.white
        r2Label.textColor = UIColor.white
        g2Label.textColor = UIColor.white
        b2Label.textColor = UIColor.white
        redValue.textColor = UIColor.white
        greenValue.textColor = UIColor.white
        blueValue.textColor = UIColor.white
    }
    
    func changeTextToBlack() {
        titleLabel.textColor = UIColor.black
        rLabel.textColor = UIColor.black
        gLabel.textColor = UIColor.black
        bLabel.textColor = UIColor.black
        r2Label.textColor = UIColor.black
        g2Label.textColor = UIColor.black
        b2Label.textColor = UIColor.black
        redValue.textColor = UIColor.black
        redValue.backgroundColor = UIColor.clear
        greenValue.textColor = UIColor.black
        blueValue.textColor = UIColor.black
    }
    
    func changeBackgroundColor() {
        if red <= 150.0 && green <= 150.0 && blue <= 150.0 {
            changeTextToWhite()
        } else {
            changeTextToBlack()
        }
        
        view.backgroundColor = UIColor(red: CGFloat(red/maxRGBValue), green: CGFloat(green/maxRGBValue), blue: CGFloat(blue/maxRGBValue), alpha: alpha)
    }
    
    func displayError(_ message: String) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        let controller = UIAlertController(title: "Invalid Value", message: message, preferredStyle: .alert)
        
        controller.addAction(okAction)
        
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func redSliderChanged(_ sender: UISlider) {
        getRedValue(cleared: false)
        changeBackgroundColor()
    }
    
    @IBAction func greenSliderChanged(_ sender: UISlider) {
        getGreenValue(cleared: false)
        changeBackgroundColor()
    }
    
    @IBAction func blueSliderChanged(_ sender: UISlider) {
        getBlueValue(cleared: false)
        changeBackgroundColor()
    }
    
    @IBAction func changeButtonTapped(_ sender: UIButton) {
        if redTextField.text!.isEmpty || greenTextField.text!.isEmpty || blueTextField.text!.isEmpty {
            displayError("Please enter a number")
        } else if Int(redTextField.text!)! < 0 || Int(redTextField.text!)! > 255 ||
            Int(greenTextField.text!)! < 0 || Int(greenTextField.text!)! > 255 ||
            Int(blueTextField.text!)! < 0 || Int(blueTextField.text!)! > 255 {
            displayError("Please enter a value between 0 and 255")
        } else {
            getRedValue(cleared: false)
            getGreenValue(cleared: false)
            getBlueValue(cleared: false)
            changeBackgroundColor()
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        let yesAction = UIAlertAction(title: "YES", style: .destructive, handler: { action in
            self.redSlider.value = 0
            self.greenSlider.value = 0
            self.blueSlider.value = 0
            
            self.getRedValue(cleared: true)
            self.getGreenValue(cleared: true)
            self.getBlueValue(cleared: true)
            
            self.changeBackgroundColor()
        })
        
        let noAction = UIAlertAction(title: "NO", style: .cancel, handler: nil)
        
        let controller = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)
        
        controller.addAction(yesAction)
        controller.addAction(noAction)
        
        present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRedValue(cleared: false)
        getGreenValue(cleared: false)
        getBlueValue(cleared: false)
        
        changeBackgroundColor()
    }
}
