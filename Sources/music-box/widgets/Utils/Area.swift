import CLVGL

class Area {
    private var _area: lv_area_t = lv_area_t()

    var width: Int {
        Int(lv_area_get_width(&_area))
    }

    var height: Int {
        get {
            return Int(lv_area_get_height(&area))
        }
        set {
            bottom = top + newValue
        }
    }

    var top: Int {
        get {
            return Int(_area.y1)
        }

        set {
            _area.y1 = Int32(newValue)
        }
    }

    var bottom: Int {
        get {
            return Int(_area.y2)
        }
        set {
            _area.y2 = Int32(newValue)
        }
    }

    var area: lv_area_t {
        get {
            return _area
        }

        set(otherArea) {
            _area = otherArea
        }
    }

    init(lv_area: lv_area_t) {
        _area = lv_area
    }

    init(x: Int32 = 0, y: Int32 = 0, width: Int32, height: Int32) {
        _area.x1 = x
        _area.y1 = y
        _area.x2 = x + width
        _area.y2 = y + height

    }
}
