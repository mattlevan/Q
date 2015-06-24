//
//  Lexicon.swift
//  TableViewTest
//
//  Created by Matt Levan on 2/14/15.
//  Copyright (c) 2015 Matt Levan. All rights reserved.
//

import Foundation

class Letter {
    var letter: Character
    var imageName = "blank"
    var morseCode: [String] = [""]
    
    init(letter: Character, imageName: String, morseCode: [String]) {
        self.letter = letter
        self.imageName = imageName
        self.morseCode = morseCode
    }
}
