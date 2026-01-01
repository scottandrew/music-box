import CLVGL
import Foundation

typealias EventHandler = (Object, Event) -> Void

class Object {
  internal let lvObject: OpaquePointer
  private var eventHandlerMap = [UInt32: EventHandler]()

  var coordinates: Area {
    var area: lv_area_t = lv_area_t()
    lv_obj_get_coords(lvObject, &area)

    return Area(lv_area: area)
  }

  var width: Int {
    return Int(lv_obj_get_width(lvObject))
  }

  var height: Int {
    get {
      return Int(lv_obj_get_height(lvObject))
    }
    set {
      lv_obj_set_height(lvObject, Int32(newValue))
    }
  }

  var isScrollbarEnabled: Bool {
    get {
      return lv_obj_has_flag(lvObject, LV_OBJ_FLAG_SCROLLABLE)
    }

    set(enableScrollbar) {
      if enableScrollbar {
        addFLag(flag: LV_OBJ_FLAG_SCROLLABLE)
      } else {
        removeFlag(flag: LV_OBJ_FLAG_SCROLLABLE)
      }
    }
  }

  internal init(object: OpaquePointer) {
    lvObject = object

    lv_obj_set_user_data(object, bridge(obj: self))

    // TODO: set this when we register for the first event..
    lv_obj_add_event_cb(
      object,
      { theEvent in
        let event = Event(event: theEvent!)
        let eventid = event.code

        if let object = event.target {
          object.eventHandlerMap[eventid.rawValue]?(object, event)
        }

      }, LV_EVENT_ALL, nil)

    // Lets setup our object to by default have no padding or borders for now. We can set those up
    // per object as needed.
    isScrollbarEnabled = false
    setBackgroundOpacity(opacity: 0)
    setBorderWidth(width: 0)
    removePadding()

  }

  deinit {
    lv_obj_delete(lvObject)
  }

  func registerEvent(event: lv_event_code_t, handler: @escaping EventHandler) {
    eventHandlerMap[event.rawValue] = handler
  }

  func setSize(width: Int, height: Int) {
    lv_obj_set_size(lvObject, lv_coord_t(width), lv_coord_t(height))
    lv_obj_update_layout(lvObject)
  }

  func setFlexFlow(flow: lv_flex_flow_t) {
    lv_obj_set_flex_flow(lvObject, flow)
  }

  func setPosition(x: Int, y: Int) {
    lv_obj_set_pos(lvObject, Int32(x), Int32(y))
    lv_obj_update_layout(lvObject)
  }

  func center() {
    lv_obj_center(lvObject)
  }

  func setFlexTrackAlginment(alignment: lv_flex_align_t, part: lv_style_selector_t = 0) {
    lv_obj_set_style_flex_main_place(lvObject, alignment, part)
    lv_obj_set_style_layout(lvObject, UInt16(LV_LAYOUT_FLEX.rawValue), 0)
  }

  func setPaddingLeft(padding: Int, part: lv_style_selector_t = 0) {
    lv_obj_set_style_pad_left(lvObject, Int32(padding), part)
  }

  func setPaddingRight(padding: Int, part: lv_style_selector_t = 0) {
    lv_obj_set_style_pad_right(lvObject, Int32(padding), part)
  }

  func setPaddingTop(padding: Int, part: lv_style_selector_t = 0) {
    lv_obj_set_style_pad_top(lvObject, Int32(padding), part)
  }

  func setPaddingBottom(padding: Int, part: lv_style_selector_t = 0) {
    lv_obj_set_style_pad_bottom(lvObject, Int32(padding), part)
  }

  func setUniformPadding(padding: Int, part: lv_style_selector_t = 0) {
    lv_obj_set_style_pad_all(lvObject, Int32(padding), part)
  }

  func removePadding(part: lv_style_selector_t = 0) {
    setUniformPadding(padding: 0)
  }

  func setBackgroundOpacity(opacity: lv_opa_t, part: lv_style_selector_t = 0) {
    lv_obj_set_style_bg_opa(lvObject, opacity, part)
  }

  func setBorderOpacity(opacity: lv_opa_t, part: lv_style_selector_t = 0) {
    lv_obj_set_style_border_opa(lvObject, opacity, part)
  }

  func setBorderWidth(width: Int, part: lv_style_selector_t = 0) {
    lv_obj_set_style_border_width(lvObject, Int32(width), part)
  }

  func setMarginUniform(margin: Int, part: lv_style_selector_t = 0) {
    lv_obj_set_style_margin_all(lvObject, Int32(margin), part)
  }

  func removeFlag(flag: lv_obj_flag_t) {
    lv_obj_remove_flag(lvObject, flag)
  }

  func addFLag(flag: lv_obj_flag_t) {
    lv_obj_add_flag(lvObject, flag)
  }

  func invalidate() {
    lv_obj_invalidate(lvObject)
  }
}
