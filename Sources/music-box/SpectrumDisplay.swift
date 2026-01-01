//
//  SpectrumDisplay.swift
//  music-box
//
//  Created by Scott Andrew on 12/30/25.
//
import CLVGL

class SpecturmDisplay: Object {
  var displays: [SpectrumFrequency] = []

  let numberOfChannels = 100

  init(parent: Object, width: Int, height: Int) {
    super.init(object: lv_obj_create(parent.lvObject))
    setSize(width: width, height: height)

    setFlexFlow(flow: LV_FLEX_FLOW_ROW)
    //setFlexTrackAlginment(alignment: LV_FLEX_ALIGN_SPACE_BETWEEN)
    // SpectrumFrequency(parent: self, width: 50, height: Int(lv_obj_get_content_height(lvObject)))

    // lets calucate the width of channels depending on the number.
    let area = coordinates
    let frequencyWidth = area.width / numberOfChannels

    for _ in 0..<numberOfChannels {
      displays.append(SpectrumFrequency(parent: self, width: frequencyWidth, height: area.height))
    }
  }

  func updateFrequencies(frequencies: [Double], startIndex: Int, spectroSize: Int) {
    guard !frequencies.isEmpty else {
      return
    }

    // lets give them data.
    for channel in 0..<numberOfChannels {
      let proportion = pow(Double(channel) / Double(numberOfChannels), 4)
      let frequencyIndex = Int((Double(startIndex) * proportion * Double(spectroSize)))
      var frequencyLevel = frequencies[frequencyIndex]

      if frequencyLevel < 0.125 {
        frequencyLevel = 0.0
      }

      print(frequencyLevel)

      displays[channel].volume = frequencyLevel
    }
  }
}
