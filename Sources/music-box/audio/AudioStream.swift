import CPortAudio
import Foundation

typealias AudioStreamCallback = (UnsafeRawPointer?, 
    UnsafeMutableRawPointer?, 
    UInt, 
    UnsafePointer<PaStreamCallbackTimeInfo>?, 
    PaStreamCallbackFlags) -> Int32
 
func _streamCallback(
    inputBuffer: UnsafeRawPointer?, 
    outputBuffer: UnsafeMutableRawPointer?, 
    framesPerBuffer: UInt, 
    timeInfo: UnsafePointer<PaStreamCallbackTimeInfo>?, 
    flags: PaStreamCallbackFlags, 
    userData: UnsafeMutableRawPointer?) -> Int32 {

    if let userData = userData { 
        let handler = Unmanaged<AudioStream>.fromOpaque(userData).takeUnretainedValue()
        return handler._onDataReceived(inputBuffer: inputBuffer, outputBuffer: outputBuffer, framesPerBuffer: framesPerBuffer, timeInfo: timeInfo, flags: flags)
    }

    print("Callback called")

    return 0
}
    

class AudioStream { 
    var _stream: UnsafeMutableRawPointer? = nil
    
    // lets take afew thihgs as vars.
    var inputParameters: PaStreamParameters?
    var outputParameters: PaStreamParameters?
    let sampleRate: Double
    let framesPerBuffer: UInt
    let streamFlags: PaStreamFlags

    let callback: AudioStreamCallback?

    init(
        inputParameters: PaStreamParameters?,
        outputParameters: PaStreamParameters?,
        sampleRate: Double = 44100,
        framesPerBuffer: UInt = 512,
        streamFlags: PaStreamFlags = paNoFlag,
        callback: AudioStreamCallback?) { 
            self.inputParameters = inputParameters
            self.outputParameters = outputParameters
            self.sampleRate = sampleRate
            self.framesPerBuffer = framesPerBuffer
            self.streamFlags = streamFlags
            self.callback = callback
        }

    func open() {
        let opaquePtr = Unmanaged.passUnretained(self).toOpaque()

        // Prepare pointers expected by PortAudio. If parameters are nil, pass nil pointers.
        var inParams = inputParameters
        var outParams = outputParameters

        let inPtr: UnsafePointer<PaStreamParameters>? = inParams == nil ? nil : withUnsafePointer(to: &inParams!) { $0 }
        let outPtr: UnsafePointer<PaStreamParameters>? = outParams == nil ? nil : withUnsafePointer(to: &outParams!) { $0 }

        let err = Pa_OpenStream(
            &_stream,
            inPtr,
            outPtr,
            sampleRate,
            framesPerBuffer,
            streamFlags,
            _streamCallback,
            opaquePtr
        )

        print("open error\(err)")
    }

    func close() { 
        let err = Pa_CloseStream(_stream)
        print ("Close \(err)")
    }

    func start() { 
        let err = Pa_StartStream(_stream)

        if (err == paNullCallback.rawValue) { 
            print("null callback")
        }

        print("start err \(err)")
    }

    func stop() { 
        Pa_StopStream(_stream)
    }

    fileprivate func _onDataReceived(
        inputBuffer: UnsafeRawPointer?,
        outputBuffer: UnsafeMutableRawPointer?,
        framesPerBuffer: UInt,
        timeInfo: UnsafePointer<PaStreamCallbackTimeInfo>?,
        flags: PaStreamCallbackFlags
    ) -> Int32 {
        return callback?(inputBuffer, outputBuffer, framesPerBuffer, timeInfo, flags) ?? 0
    }
}

