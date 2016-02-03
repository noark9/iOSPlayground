//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

var str = "Hello, playground"

infix operator <^> { associativity left }
func <^><T, U>(f: T -> U, a: T?) -> U? {
    return a.map(f)
}


infix operator >>- { associativity left }
func >>-<T, U>(a: T?, f: T -> U?) ->U? {
    return a.flatMap(f)
}

func plus3(addend: Int) -> Int? {
    if addend > 4 {
        return addend + 3
    } else {
        return nil
    }
}

func plus5(addend: Int) -> Int? {
    if addend > 6 {
        return addend + 5
    } else {
        return nil
    }
}

plus3 <^> Optional(5)



Optional.Some(5).map(plus3)

Optional.None.map(plus3)

Optional.Some(3)

class DrawView: UIView {
    override func drawRect(rect: CGRect) {
        //// PaintCode Trial Version
        //// www.paintcodeapp.com
        
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Rectangle Drawing
        CGContextSaveGState(context)
//        CGContextTranslateCTM(context, 25, 14)
//        CGContextScaleCTM(context, 1.4, 1)
        
        let rectanglePath = UIBezierPath(rect: CGRectMake(0, 0, 25, 29))
        UIColor.grayColor().setFill()
        rectanglePath.fill()
        
        CGContextRestoreGState(context)
        CGContextSaveGState(context)
        CGContextSetBlendMode(context, .Clear)
        let clearRectanglePath = UIBezierPath(rect: CGRectMake(10, 0, 5, 29))
        UIColor.grayColor().setFill()
        clearRectanglePath.fill()
        CGContextRestoreGState(context)
    }
}


let frameOfView = CGRectMake(0, 0, 50, 50)
let testView = DrawView(frame: frameOfView)
XCPlaygroundPage.currentPage.liveView = testView


































