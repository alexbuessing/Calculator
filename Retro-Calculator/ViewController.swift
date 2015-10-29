//
//  ViewController.swift
//  Retro-Calculator
//
//  Created by Alexander Buessing on 10/28/15.
//  Copyright © 2015 AppFish. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var buttonSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValSideString = ""
    var rightValSideString = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("ButtonPress", ofType: "wav")
        
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do {
            try buttonSound = AVAudioPlayer(contentsOfURL: soundURL)
            buttonSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func buttonPressed(btn: UIButton) {
        
        buttonSound.play()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
        
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onPlusPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }

    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }

    func processOperation (op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            //Run Math
            
            if runningNumber != "" {
            rightValSideString = runningNumber
            runningNumber = ""
            
            switch currentOperation {
                case Operation.Multiply:
                    result = "\(Double(leftValSideString)! * Double(rightValSideString)!)"
                case Operation.Divide:
                    result = "\(Double(leftValSideString)! / Double(rightValSideString)!)"
                case Operation.Subtract:
                    result = "\(Double(leftValSideString)! - Double(rightValSideString)!)"
                case Operation.Add:
                    result = "\(Double(leftValSideString)! + Double(rightValSideString)!)"
                
            default:
                break
            }
            
            leftValSideString = result
            outputLbl.text = result
            }
            
            currentOperation = op
            
        } else {
            //This is the first time an operator was pressed
            leftValSideString = runningNumber
            runningNumber = ""
            currentOperation = op
        }
        
    }
    
    func playSound () {
        
        if buttonSound.playing {
            buttonSound.stop()
        }
        
        buttonSound.play()
        
    }
    
}

