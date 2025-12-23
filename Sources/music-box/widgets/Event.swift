import CLVGL

class Event { 
    private let event: OpaquePointer

    var code: lv_event_code_t { 
        get { 
            return lv_event_get_code(event)
        }
    }

    var layer: Layer { 
        get { 
            return Layer(layer: lv_event_get_layer(event).pointee)
        }
    }

    var target: Object? { 
        get { 
            let obj = lv_event_get_target_obj(event)
            
            if obj != nil { 
                let theObject: Object = bridge(ptr: lv_obj_get_user_data(obj))
                return theObject;
            }

            return nil
        }
    }

    init(event: OpaquePointer) { 
        self.event = event
    }


}