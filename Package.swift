// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if os(Linux)
let SDLCFlags=["-I/usr/include/SDL2"]
#else
let SDLCFlags=["-I/opt/homebrew/include"]
#endif

let package = Package(
    name: "music-box",
    platforms: [.macOS(.v26)],
    targets: [
        .systemLibrary(name: "CPortAudio", pkgConfig: "portaudio", providers: [.brew(["portaudio"]), .apt(["portaudio19-dev"])]),
        .systemLibrary(name: "CFFTW", pkgConfig: "fftw3", providers: [.brew(["fftw"]), .apt(["fftw3-dev"])]),
        .target(
            name: "CLVGL",
            dependencies: [],
            exclude: ["lvgl/Kconfig",
                      "lvgl/scripts",
                      "lvgl/tests",
                      "lvgl/examples",
                      "lvgl/docs",
                      "lvgl/CMakeLists.txt",
                      "lvgl/lvgl.mk",
                      "lvgl/component.mk",
                      "lvgl/README.md",
                      "lvgl/library.properties",
                      "lvgl/LICENCE.txt",
                      "lvgl/zephyr/module.yml",
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
            dependencies: ["CFFTW", "CPortAudio", "CLVGL"]
        ),
    ]
)
