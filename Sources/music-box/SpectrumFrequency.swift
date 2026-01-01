//
//  SpectrumFrequency.swift
//  music-box
//
//  Created by Scott Andrew on 12/30/25.
//
import Foundation

class SpectrumFrequency: DrawingCanvas {
  var _volume = 0.0

  var volume: Double {
    get {
      return _volume
    }

    set {
      _volume = newValue
      invalidate()
    }
  }
  override init(parent: Object, width: Int, height: Int) {
    super.init(parent: parent, width: width, height: height)
  }

  override func onDraw(object: Object, event: Event) {
    let layer = event.layer
    let rectange = Recatangle()
    rectange.bgColor = Color.black
    let drawArea = coordinates

    drawArea.top = drawArea.bottom - Int(Double(drawArea.height) * _volume)

    rectange.draw(layer: layer, area: drawArea)
  }
}
