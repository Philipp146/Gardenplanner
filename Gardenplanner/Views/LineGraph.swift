//
//  LineGraph.swift
//  GraphDemo
//
//  Created by Bastian K. on 14.06.17.
//  Copyright © 2017 Bastian K. All rights reserved.
//
import UIKit

@IBDesignable
class LineGraph: UIView {
    
    @IBInspectable var startColor: UIColor = UIColor.red
    @IBInspectable var endColor: UIColor = UIColor.green
    @IBInspectable var margin:CGFloat = 20.0 {
        didSet{
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var topBorder : CGFloat = 60 {
        didSet{
            self.setNeedsDisplay()
        }
    }
    @IBInspectable var bottomBorder : CGFloat = 50 {
        didSet{
            self.setNeedsDisplay()
        }
    }
    
    private var width : CGFloat!
    private var height : CGFloat!
    private var graphHeight : CGFloat {
        get{
            return height - topBorder - bottomBorder
        }
    }
    private var context : CGContext!
    private var gradient : CGGradient!
    var dataSource : LineGraphDataSource!
    
    
    override func draw(_ rect: CGRect) {
        
        width = rect.width
        height = rect.height
        context = UIGraphicsGetCurrentContext()!
        
        
        
        setUpCorners(in: rect)
        
        drawBackground()
        
        
        
        context.saveGState()
        
        drawLineGraph()
        
        context.restoreGState()
        
        drawCircles()
        
        drawHorizontalLines()
        addTextLabels()
    }
    
    
    private func addTextLabels()
    {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .right
        label.text = "\(dataSource.minElement())"
        label.frame = CGRect(x: bounds.width-margin, y: bounds.height - topBorder - 5, width: 20, height: 10)
        self.addSubview(label)
        
        let maxLabel = UILabel()
        maxLabel.text = "\(dataSource.maxElement())"
        maxLabel.textColor = UIColor.white
        maxLabel.font = UIFont.boldSystemFont(ofSize: 10)
        maxLabel.textAlignment = .right
        maxLabel.frame = CGRect(x: bounds.width-margin, y: topBorder-5, width: 20, height: 10)
        addSubview(maxLabel)
    }
    
    
    private func setUpCorners(in rect: CGRect)
    {
        let path = UIBezierPath(roundedRect: rect,byRoundingCorners: UIRectCorner.allCorners,cornerRadii: CGSize(width: 8.0, height: 8.0))
        path.addClip()
    }
    
    private func drawBackground()
    {
        let colors = [startColor.cgColor, endColor.cgColor] as CFArray
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations:[CGFloat] = [0.0, 1.0]
        
        gradient = CGGradient.init(colorsSpace: colorSpace, colors: colors, locations: colorLocations)
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x:0, y:self.bounds.height)
        
        context.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: .drawsBeforeStartLocation)
        
    }
    
    private func drawLineGraph()
    {
        UIColor.white.setFill()
        UIColor.white.setStroke()
        
        let graphPath = UIBezierPath()
        
        graphPath.move(to: CGPoint(x:columnXPoint(0),
                                   y:columnYPoint(dataSource.lineGraph(self, dataForColumn: 0))))
        
        
        for i in 1..<dataSource.numberOfEntries(in: self) {
            let nextPoint = CGPoint(x:columnXPoint(i),
                                    y:columnYPoint(dataSource.lineGraph(self, dataForColumn: i)))
            graphPath.addLine(to: nextPoint)
        }
        drawGradient(under: graphPath)
    }
    
    private func drawGradient(under graphPath: UIBezierPath)
    {
        let clippingPath = graphPath.copy() as! UIBezierPath
        
        clippingPath.addLine(to: CGPoint(
            x: columnXPoint(dataSource.numberOfEntries(in: self) - 1),
            y:height))
        clippingPath.addLine(to: CGPoint(
            x:columnXPoint(0),
            y:height))
        clippingPath.close()
        
        clippingPath.addClip()
        
        let highestYPoint = columnYPoint(dataSource.maxElement())
        let startPoint = CGPoint(x:margin, y: highestYPoint)
        let endPoint = CGPoint(x:margin, y:self.bounds.height)
        
        context.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: .drawsBeforeStartLocation)
        graphPath.lineWidth = 2.0
        graphPath.stroke()
    }
    
    private func drawCircles()
    {
        UIColor.white.setFill()
        UIColor.white.setStroke()
        
        for i in 0..<dataSource.numberOfEntries(in: self) {
            var point = CGPoint(x:columnXPoint(i), y:columnYPoint(dataSource.lineGraph(self, dataForColumn: i)))
            point.x -= 5.0/2
            point.y -= 5.0/2
            
            let circle = UIBezierPath(ovalIn:
                CGRect(origin: point,
                       size: CGSize(width: 5.0, height: 5.0)))
            circle.fill()
        }
        
    }
    
    private func drawHorizontalLines()
    {
        let linePath = UIBezierPath()
        
        linePath.move(to: CGPoint(x:margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: width - margin,
                                     y:topBorder))
        
        linePath.move(to: CGPoint(x:margin,
                                  y: graphHeight/2 + topBorder))
        linePath.addLine(to: CGPoint(x:width - margin,
                                     y:graphHeight/2 + topBorder))
        
        linePath.move(to: CGPoint(x:margin,
                                  y:height - bottomBorder))
        linePath.addLine(to: CGPoint(x:width - margin,
                                     y:height - bottomBorder))
        let color = UIColor(white: 1.0, alpha: 0.3)
        color.setStroke()
        
        linePath.lineWidth = 1.0
        linePath.stroke()
        
    }
    
    private func columnXPoint(_ column : Int) -> CGFloat
    {
        let spacer = (width - margin*2 - 4) /
            CGFloat(dataSource.numberOfEntries(in: self) - 1)
        var x:CGFloat = CGFloat(column) * spacer
        x += self.margin + 2
        return x
    }
    
    private func columnYPoint(_ graphPoint : Int) -> CGFloat
    {
        print("Point: \(graphPoint)")
        let range = abs(dataSource.maxElement()) + abs(dataSource.minElement())
        var y : CGFloat = CGFloat(graphPoint) / CGFloat(range) * graphHeight
        y = graphHeight/2 + topBorder - y
        return y
    }
}

