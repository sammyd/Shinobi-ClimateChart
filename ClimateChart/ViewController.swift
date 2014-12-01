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
    
    chart.datasource = datasource
  }


}

