//
//  ViewController.swift
//  ClimateChart
//
//  Created by sam on 01/12/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var chart: ShinobiChart!
  let datasource = ClimateDataSource()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    chart.licenseKey = ""
    
    configureChart()
  }
  
  func configureChart() {
    chart.datasource = datasource
    
    let firstAxis = SChartNumberAxis()
    firstAxis.title = "Temperature (C)"
    firstAxis.rangePaddingLow = 15
    let secondAxis = SChartNumberAxis()
    secondAxis.title = "Precipitation (mm)"
    secondAxis.rangePaddingHigh = 150
    secondAxis.axisPosition = SChartAxisPositionReverse
    chart.addYAxis(firstAxis)
    chart.addYAxis(secondAxis)
  }


}

