import Foundation
import CLVGL

typealias EventHandler = (Object, Event) -> Void


class Object { 
    internal let lvObject: OpaquePointer
    private var eventHandlerMap = [UInt32: EventHandler]()

    internal init(object: OpaquePointer) { 
        lvObject = object;

        lv_obj_set_user_data(object, bridge(obj: self))

        lv_obj_add_event_cb(object, { theEvent in 
            let event = Event(event: theEvent!)
            let eventid = event.code

            
            if let object = event.target { 
                object.eventHandlerMap[eventid.rawValue]?(object, event);
            }
            
        }, LV_EVENT_ALL, nil);
    }

    deinit { 
        lv_obj_delete(lvObject)
    }

    func registerEvent(event: lv_event_code_t, handler: @escaping EventHandler) { 
        eventHandlerMap[event.rawValue] = handler;
    }

    func setSize(width: Int, height: Int) { 
        lv_obj_set_size(lvObject, lv_coord_t(width), lv_coord_t(height))
    }

    func center() { 
        lv_obj_center(lvObject)
    }

}