import CPortAudio

class PortAudio { 
    func startup() -> PaError { 
        return Pa_Initialize()
    }

    func shutdown() -> PaError { 
        return Pa_Terminate()
    }

    func devices() -> [AudioDeviceInfo] { 
        let count = Pa_GetDeviceCount()
        var devices: [AudioDeviceInfo] = []

        guard count > 0 else { 
            return devices;
        }

        for index in 0..<count { 
            let info = AudioDeviceInfo(deviceIndex: index);
            devices.append(info)
        }

        return devices
    }
}