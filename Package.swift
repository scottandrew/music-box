// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if os(Linux)
let SDLCFlags=["-I/usr/include/SDL2"]
#else
let SDLCFlags=["-I/usr/local/Cellar/sdl2/2.0.14_1/include/SDL2", "-I/opt/homebrew/include/SDL2"]
#endif

let package = Package(
    name: "music-box",
    targets: [
        .target(
            name: "CLVGL",
            dependencies: [],
            exclude: ["lvgl/Kconfig",
                      "lvgl/scripts",
                      "lvgl/tests",
                      "lvgl/examples",
                      "lvgl/docs",
                      "lv_drivers/docs",
                      "lvgl/CMakeLists.txt",
                      "lvgl/src/misc/lv_misc.mk",
                      "lvgl/librarly.json",
                      "lvgl/lvgl.mk",
                      "lvgl/component.mk",
                      "lvgl/README.md",
                      "lvgl/src/extra/extra.mk",
                      "lvgl/src/gpu/lv_gpu.mk",
                      "lvgl/src/hal/lv_hal.mk",
                      "main.txt",
                      "lvgl/src/draw/lv_draw.mk",
                      "lvgl/src/font/lv_font.mk",
                      "lvgl/library.json",
                      "lvgl/library.properties",
                      "lvgl/LICENCE.txt",
                      "lvgl/src/core/lv_core.mk",
                      "lvgl/src/font/korean.ttf",
                      "lvgl/src/widgets/lv_widgets.mk",
                      "lvgl/src/extra/README.md",
                      "lvgl/zephyr/module.yml",
                      "lv_drivers/LICENSE",
                      "lv_drivers/README.md",
                      "lv_drivers/gtkdrv/broadway.png",
                      "lv_drivers/wayland/README.md",
                      "lv_drivers/gtkdrv/README.md",
                      "lv_drivers/lv_drivers.mk",
                      "lv_drivers/CMakeLists.txt",
                      "lv_drivers/library.json"
            ],
            cSettings: [
                        .headerSearchPath("lvgl/src/*"),
                        .headerSearchPath("lvgl"),
                        .headerSearchPath("lvgl/src/misc"),
                        .headerSearchPath("lvgl/src/core"),
                        .unsafeFlags(SDLCFlags + ["-D THREAD_SAFE", "-D LV_LVGL_H_INCLUDE_SIMPLE"])
                        ],
        linkerSettings: [.unsafeFlags(["-L/opt/homebrew/lib","-lSDL2"])]),
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "music-box",
            dependencies: ["CLVGL"]
        ),
    ]
)
