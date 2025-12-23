import CLVGL

class DrawingCanvas : Object { 
    init(parent: Object, width: Int, height: Int) { 
        super.init(object: lv_obj_create(parent.lvObject))
        
        lv_obj_set_style_border_opa(lvObject, UInt8(LV_OPA_TRANSP.rawValue), LV_PART_MAIN.rawValue)
        lv_obj_set_style_bg_opa(lvObject, UInt8(LV_OPA_TRANSP.rawValue), LV_PART_MAIN.rawValue)
        setSize(width: width, height: height)
        registerEvent(event: LV_EVENT_DRAW_MAIN, handler: onDraw)
    }


    func onDraw(object: Object, event: Event) { 

    }

}