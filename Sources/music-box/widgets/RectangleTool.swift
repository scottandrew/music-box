import CLVGL

class RecatangleTool { 
    private var descriptor: lv_draw_rect_dsc_t = lv_draw_rect_dsc_t()

    init() { 
        lv_draw_rect_dsc_init(&descriptor)
    }

    var bgColor: Color {
        get { 
            return Color(lvColor: descriptor.bg_color)
        }

        set (otherColor) { 
            descriptor.bg_color = otherColor.lvColor
        }
    }

    func draw(layer: Layer, area: Area) { 
        lv_draw_rect(&layer.layer, &descriptor, &area.area)
    }
}