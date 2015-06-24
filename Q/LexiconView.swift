//
//  LexiconView.swift
//  TableViewTest
//
//  Created by Matt Levan on 2/14/15.
//  Copyright (c) 2015 Matt Levan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var timer = NSTimer()
    var LexiconArray: [Letter] = [Letter]() // Array of Lexicon objects 0 (a) thru 25 (z)
    var ButtonAudioDot = AVAudioPlayer()
    var ButtonAudioDash = AVAudioPlayer()
    let ButtonAudioDotURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("dot100", ofType: "wav")!)
    let ButtonAudioDashURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("dash300", ofType: "wav")!)
    let morseDict: [Character: [String]] = ["A": ["dot", "dash"], "B": ["dash", "dot", "dot", "dot"], "C": ["dash", "dot", "dash", "dot"], "D": ["dash", "dot", "dot"], "E": ["dot"], "F": ["dot", "dot", "dash", "dot"], "G": ["dash", "dash", "dot"], "H": ["dot", "dot", "dot", "dot"], "I": ["dot", "dot"], "J": ["dot", "dash", "dash", "dash"], "K": ["dot", "dash", "dot", "dash"], "L": ["dot", "dash", "dot", "dot"], "M": ["dash", "dash"], "N": ["dash", "dot"], "O": ["dash", "dash", "dash"], "P": ["dot", "dash", "dash", "dot"], "Q": ["dash", "dash", "dot", "dash"], "R": ["dot", "dash", "dot"], "S": ["dot", "dot", "dot"], "T": ["dash"], "U": ["dot", "dot", "dash"], "V": ["dot", "dot", "dot", "dash"], "W": ["dot", "dash", "dash"], "X": ["dash", "dot", "dot", "dash"], "Y": ["dash", "dot", "dash", "dash"], "Z": ["dash", "dash", "dot"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: (51/255.0), green: (51/255.0), blue: (51/255.0), alpha: 1.0)
        self.initLexicon()
        ButtonAudioDot = AVAudioPlayer(contentsOfURL: ButtonAudioDotURL, error: nil)
        ButtonAudioDash = AVAudioPlayer(contentsOfURL: ButtonAudioDashURL, error: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initLexicon() {
        // Initialize lexicon of letters with images
        // Append Letter objects to LexiconArray
        // Add Morse code values for each Lexicon object a-z (0-25)
        for i in "ABCDEFGHIJKLMNOPQRSTUVWXYZ" {
            LexiconArray.append(Letter(letter: i, imageName: "Lexicon-\(i)", morseCode: morseDict[i]!))
        }
        
    }
    
    func elementDelay(delay: Double, closure:()->()) { // Inter-element delay for between dots and dashes
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func playMorseChar(var x: Int) {
        var delayTime = 0.0 // Delay time in sec
        let dotTime = 0.1 // Dot time in sec
        let dashTime = 0.3 // Dash time in sec
        let gapTime = 0.1 // Time gap between dots and dashes in sec
        for (var i = 0; i < self.LexiconArray[x].morseCode.count; i++) { // Subsequent dots/dashes, spaced by 0.1s, if applicable
            if (self.LexiconArray[x].morseCode[i] == "dot") {
                self.elementDelay(delayTime) {
                    self.ButtonAudioDot.play()
                    return
                }
                delayTime += (dotTime + gapTime)
            }
            if (self.LexiconArray[x].morseCode[i] == "dash") {
                self.elementDelay(delayTime) {
                    self.ButtonAudioDash.play()
                    return
                }
                delayTime += (dashTime + gapTime)
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LexiconArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: LexiconCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! LexiconCell
        let letter = LexiconArray[indexPath.row]
        cell.setCell(letter.imageName)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        playMorseChar(indexPath.row)
    }
    
}

