//
//  WeatherGraphViewController.swift
//  Gardenplanner
//
//  Created by Bastian Kusserow on 22.01.18.
//  Copyright © 2018 Philipp. All rights reserved.
//

import UIKit

class WeatherGraphViewController: UIViewController {

    //@IBOutlet var lineGraph: LineGraph!
    var bed : BedsStruct!
    override func viewDidLoad() {
        super.viewDidLoad()
        var weather : [WeatherStruct] = [WeatherStruct(id: 0, date: "0", rainfall: 0, sunHours: 0, temperature: 0, locationId: 0)]
        if bed.location.weather.count > 0 {
            weather = bed.location.weather
        }
        //let dataSource = DataSource(weather:weather)
        //
        //lineGraph.dataSource = dataSource

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
