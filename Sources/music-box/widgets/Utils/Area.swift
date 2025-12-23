import CLVGL

class Area { 
    private var _area: lv_area_t = lv_area_t()

    var area: lv_area_t { 
        get { 
            return _area
        }

        set(otherArea) { 
            _area = otherArea
        }
    }

    init(x: Int32 = 0, y: Int32 = 0, width: Int32, height: Int32) { 
        _area.x1 = x
        _area.y1 = y
        _area.x2 = x + width
        _area.y2 = y + height

    }
}