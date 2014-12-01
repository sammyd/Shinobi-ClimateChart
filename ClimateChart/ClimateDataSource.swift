//
//  ClimateDataSource.swift
//  ClimateChart
//
//  Created by sam on 01/12/2014.
//  Copyright (c) 2014 ShinobiControls. All rights reserved.
//

import Foundation

struct ClimateData {
  var month: String
  var avgHighTemp: Float
  var avgLowTemp: Float
  var meanTemp: Float
  var avgPrecipitation: Float
  
  init(dictionary: [String: AnyObject]) {
    self.month = dictionary["month"] as String
    self.avgHighTemp = dictionary["avgHighTemp"] as Float
    self.avgLowTemp = dictionary["avgLowTemp"] as Float
    self.meanTemp = dictionary["meanTemp"] as Float
    self.avgPrecipitation = dictionary["avgRainfall"] as Float
  }
}

extension ClimateData {
  func meanTemperatureDataPoint() -> SChartDataPoint {
    let dp = SChartDataPoint()
    dp.xValue = month
    dp.yValue = meanTemp
    return dp
  }
  
  func tempRangeDataPoint() -> SChartDataPoint {
    let dp = SChartMultiYDataPoint()
    dp.xValue = month
    dp.yValues = NSMutableDictionary(dictionary: [SChartBandKeyLow: avgLowTemp,
      SChartBandKeyHigh: avgHighTemp])
    return dp
  }
  
  func precipitationDatapoint() -> SChartDataPoint {
    let dp = SChartDataPoint()
    dp.xValue = month
    dp.yValue = avgPrecipitation
    return dp
  }
}


class ClimateDataSource: NSObject, SChartDatasource {
  
  var data: [ClimateData]!
  var series: [SChartSeries]!
  
  override init() {
    super.init()
    data = importClimateDataFromPlistNamed("ClimateData")
    series = [SChartLineSeries(), SChartBandSeries(), SChartColumnSeries()]
  }
  
  
  //MARK:- SChartDatasource methods
  func numberOfSeriesInSChart(chart: ShinobiChart!) -> Int {
    return 3
  }
  
  func sChart(chart: ShinobiChart!, seriesAtIndex index: Int) -> SChartSeries! {
    return series[index]
  }
  
  func sChart(chart: ShinobiChart!, numberOfDataPointsForSeriesAtIndex seriesIndex: Int) -> Int {
    return data.count
  }
  
  func sChart(chart: ShinobiChart!, dataPointAtIndex dataIndex: Int, forSeriesAtIndex seriesIndex: Int) -> SChartData! {
    let climateData = data[dataIndex]
    switch seriesIndex {
    case 0:
      return climateData.meanTemperatureDataPoint()
    case 1:
      return climateData.tempRangeDataPoint()
    case 2:
      return climateData.precipitationDatapoint()
    default:
      return SChartDataPoint()
    }
  }
  
  
  private func importClimateDataFromPlistNamed(plistName: String) -> [ClimateData] {
    let path = NSBundle.mainBundle().pathForResource(plistName, ofType: "plist")
    var rawArray = NSArray(contentsOfFile: path!) as [[String: AnyObject]]
    return rawArray.map { elt in ClimateData(dictionary: elt) }
  }
}