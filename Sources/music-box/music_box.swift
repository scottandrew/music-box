// The Swift Programming Language
// https://docs.swift.org/swift-book
import CLVGL

@main
struct music_box {
    static func main() {
        var percentage: Float = 0.0;

        lv_init()
        let display = lv_sdl_window_create(800, 600)
        let mouse = lv_sdl_mouse_create()
        let mouse_wheel = lv_sdl_mousewheel_create()
        let keyboard = lv_sdl_keyboard_create()

        let screen = Screen()
        let button = Button(parent: screen)

        button.onClick(handler: { _, _ in 
        print("button clicked")
        })

        button.center()

        var meter = Meter(parent: screen, width: 200, height: 50)

        screen.load()


        while(true) { 
            lv_timer_handler()
            lv_delay_ms(5)
            
          percentage = Float.random(in: 0.0...1.0)
          meter.setPercentage(percentage: percentage)
        }


        return
    }
}
