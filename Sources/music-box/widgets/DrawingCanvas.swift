import CLVGL

class DrawingCanvas: Object {
    init(parent: Object, width: Int, height: Int) {
        super.init(object: lv_obj_create(parent.lvObject))
        setSize(width: width, height: height)
        registerEvent(event: LV_EVENT_DRAW_MAIN, handler: onDraw)
    }

    func onDraw(object: Object, event: Event) {

    }

}
