// The Swift Programming Language
// https://docs.swift.org/swift-book
import CLVGL
import CPortAudio
import Darwin
import Foundation

class Application {
  let audio = PortAudio()
  var stream: AudioStream?
  var meterLeft: Meter?
  var meterRight: Meter?
  var screen: Screen?
  var leftSignal:Float = 0.0
  var rightSignal:Float = 0.0
  
  func start() {
    lv_init()
    let display = lv_sdl_window_create(800, 600)
    let mouse = lv_sdl_mouse_create()
    let mouse_wheel = lv_sdl_mousewheel_create()
    let keyboard = lv_sdl_keyboard_create()
    
    screen = Screen()
    
    meterLeft = Meter(parent: screen!, width: 200, height: 50)
    meterRight = Meter(parent: screen!, width: 200, height: 50)
    meterRight?.setPosition(x: 75, y: 0)
    
    startAudioCapture();
    
    screen?.load()
  }
  
  func run() {
    while(true) {
        lv_timer_handler()
        lv_delay_ms(5)
      
      meterLeft?.setPercentage(percentage: leftSignal)
      meterRight?.setPercentage(percentage: rightSignal)
    }
  }
  
  func startAudioCapture() {
    var error = audio.startup()
    
    guard error == paNoError.rawValue else {
      fatalError("Failed to iniitalize audio")
    }
            
    let devices = audio.devices()
    
    guard devices.count >= 0 else {
      fatalError("No devices found.")
    }
    
    let inputParameters = PaStreamParameters(
        device: 2,
        channelCount: 1,
        sampleFormat: paFloat32,
        suggestedLatency: devices[2].defaultLowInputLatency,
        hostApiSpecificStreamInfo: nil);

    var outputParameters = PaStreamParameters(
        device: 3,
        channelCount: 2,
        sampleFormat: paFloat32,
        suggestedLatency: devices[3].defaultLowInputLatency,
        hostApiSpecificStreamInfo: nil);
    
    stream = AudioStream(inputParameters: inputParameters, outputParameters: nil, callback: processAudioFrames)

    stream?.open()
    stream?.start()
  }
  
  func processAudioFrames(inputBuffer: UnsafeRawPointer?,
  outputBuffer: UnsafeMutableRawPointer?,
  framesPerBuffer: UInt,
  timeInfo: UnsafePointer<PaStreamCallbackTimeInfo>?,
                                 flags: PaStreamCallbackFlags) -> Int32 {
    guard let inputBuffer = inputBuffer else {
        return 0;
    }
    // lets get our floats.
    let typedPointer = inputBuffer.bindMemory(to: Float.self, capacity: Int(framesPerBuffer) * 2)
    let bufferPointer = UnsafeBufferPointer(start: typedPointer, count: Int(framesPerBuffer) * 2)
    let frames = Array(bufferPointer);
    
    var valLeft: Float = 0;
    var valRight: Float = 0;
    
    for index in stride(from: 0, to: Int(framesPerBuffer), by: 1) {
        valLeft = max(valLeft, abs(frames[index]))
        valRight = max(valRight, abs(frames[index]))
    }
    
    print("L: \(valLeft), R: \(valRight)")
   
    leftSignal = valLeft
    rightSignal = valRight
//    MainActor.run(body: {
//      
//    })
//    meterLeft?.setPercentage(percentage: valLeft)
//    meterRight?.setPercentage(percentage: valRight)

    return 0
  }
}

@main
class music_box {
//  let audio = PortAudio()
//  var stream: AudioStream?
//  var meter: Meter?
  
    static func main() {
      var app = Application()
      
      app.start()
      
      app.run()

//        return
    }
}
