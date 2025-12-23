import CLVGL

class Screen : Object { 
    init() { 
        super.init(object: lv_obj_create(OpaquePointer(bitPattern: 0)));
    }

    static func currentScren() -> Screen? { 


        guard let lvScreen = lv_screen_active(), let unsafeObject = lv_obj_get_user_data(lvScreen) else { 
            return nil
        }

        let object: Object = bridge(ptr: unsafeObject)

        guard let foundScreen = object as? Screen else { 
            return nil
        }

        return foundScreen
    }

    func load() { 
        lv_screen_load(lvObject)
    }
}