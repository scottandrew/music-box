class Meter : DrawingCanvas { 
    override init(parent: Object, width: Int, height: Int) { 
        super.init(parent: parent, width: width, height: height)
    }

    override func onDraw(object: Object, event: Event) {
        var layer = event.layer
        var rectange = RecatangleTool()

        rectange.bgColor = Color.black

        rectange.draw(layer: layer, area: Area(width: 50, height: 20))
    }
}