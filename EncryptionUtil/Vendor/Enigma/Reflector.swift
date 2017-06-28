// The MIT License (MIT)
//
// Copyright (c) 2015 Joakim Gyllström
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the foll Patowing conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

/**
 Enigma reflector
*/
open class Reflector: Rotor { }

public extension Reflector {
    public convenience init(name: String, wiring: String) {
        self.init(name: name, wirings: Array(wiring.characters), notches: [])
    }
    
    public static var A: Reflector {
        return Reflector(name: "A", wiring: "EJMZALYXVBWFCRQUONTSPIKHGD")
    }
    
    public static var B: Reflector {
        return Reflector(name: "B (wide)", wiring: "YRUHQSLDPXNGOKMIEBFZCWVJAT")
    }
    
    public static var C: Reflector {
        return Reflector(name: "C (wide)", wiring: "FVPJIAOYEDRZXWGCTKUQSBNMHL")
    }
    
    public static var BThin: Reflector {
        return Reflector(name: "B (thin)", wiring: "ENKQAUYWJICOPBLMDXZVFTHRGS")
    }
    
    public static var CThin: Reflector {
        return Reflector(name: "C (thin)", wiring: "RDOBJNTKVEHMLFCWZAXGYIPSUQ")
    }
}
