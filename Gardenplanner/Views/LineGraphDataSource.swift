//
//  LineGraphDataSource.swift
//  GraphDemo
//
//  Created by Bastian K. on 14.06.17.
//  Copyright © 2017 Bastian K. All rights reserved.
//
import Foundation

protocol LineGraphDataSource
{
    func numberOfEntries(in lineGraph: LineGraph) -> Int
    func lineGraph(_ lineGraph: LineGraph, dataForColumn: Int) -> Int
    func maxElement() -> Int
    func minElement() -> Int
}

public class DataSource : LineGraphDataSource {
    
    private var graphPoints : [WeatherStruct] = []
    
    init(weather : [WeatherStruct]) {
        graphPoints = weather
    }
    
    internal func lineGraph(_ lineGraph: LineGraph, dataForColumn: Int) -> Int {
        if graphPoints.count <= 0 {
            return 0
        }
        let value = Int(graphPoints[dataForColumn].temperature)
        return value
    }
    
    internal func numberOfEntries(in lineGraph: LineGraph) -> Int {
        return graphPoints.count
    }
    
    internal func maxElement() -> Int
    {
        var max = 0
        for weather in graphPoints{
            if max < Int(abs(weather.temperature)) {
                max = Int(abs(weather.temperature))
            }
        }
        print("MAX: \(max)")
        return max
    }
    
    internal func minElement() -> Int {
        var min = 0
        for weather in graphPoints{
            if min > Int(weather.temperature) {
                min = Int(weather.temperature)
            }
        }
        print("Min: \(min)")
        return min
    }
}
