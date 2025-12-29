import CPortAudio

class AudioDeviceInfo {
    let index: Int
    let name: String
    let maxInputChannels: Int
    let maxOutputChannels: Int 
    let defaultSampleRate: Double
    let defaultLowInputLatency: PaTime;

    init(deviceIndex: Int32) { 
        self.index = Int(deviceIndex);
        let deviceInfo = Pa_GetDeviceInfo(PaDeviceIndex(index))
    guard let deviceInfo = deviceInfo else { 
        fatalError("Failed to get device info for device index \(deviceIndex)")
    }
        self.name = String(cString: deviceInfo.pointee.name)
        self.maxInputChannels = Int(deviceInfo.pointee.maxInputChannels)
        self.maxOutputChannels = Int(deviceInfo.pointee.maxOutputChannels)
        self.defaultSampleRate = deviceInfo.pointee.defaultSampleRate
        self.defaultLowInputLatency = deviceInfo.pointee.defaultLowInputLatency
    }
}
