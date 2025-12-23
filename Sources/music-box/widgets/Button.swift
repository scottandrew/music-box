import CLVGL

class Button: Object { 
    init(parent: Object) { 
        super.init(object: lv_button_create(parent.lvObject));
    }

    func onClick(handler: @escaping EventHandler) { 
        registerEvent(event: LV_EVENT_CLICKED, handler: handler)
    }
}