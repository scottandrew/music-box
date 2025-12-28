import CLVGL

class Meter : DrawingCanvas {
  var percentage: Float = 0.0;
  
  func setPercentage(percentage: Float) {
    self.percentage = percentage
    lv_obj_invalidate(self.lvObject)
  }
    override init(parent: Object, width: Int, height: Int) {
        super.init(parent: parent, width: width, height: height)
    }

    override func onDraw(object: Object, event: Event) {
        let layer = event.layer
        let rectange = Recatangle()

        rectange.bgColor = Color.black


      rectange.draw(layer: layer, area: Area(width: Int32(floor(Float(lv_obj_get_width(lvObject)) * percentage)), height: lv_obj_get_height(lvObject)))
    }
}
