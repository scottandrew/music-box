import CFFTW
import Foundation

class SpectrumAnalyzer {
  // we need to create an incoming buffer of audio to analyze.
  let plan: fftw_plan
  let frequencyStart: Int
  let frequencyEnd: Int
  let framesPerBuffer: Int
  let startIndex: Int
  let spectrumSize: Int

  let inBuffer: UnsafeMutablePointer<Double>
  let outBuffer: UnsafeMutablePointer<Double>

  init(
    frequencyStart: Int = 20, frequencyEnd: Int = 20000, sampleRate: Double, framesPerBuffer: Int
  ) {
    self.frequencyStart = frequencyStart
    self.frequencyEnd = frequencyEnd
    self.framesPerBuffer = framesPerBuffer

    inBuffer = fftw_alloc_real(framesPerBuffer)
    outBuffer = fftw_alloc_real(framesPerBuffer)

    let ratio = Double(framesPerBuffer) / sampleRate

    startIndex = Int((ratio * Double(frequencyStart)).rounded(.up))
    spectrumSize =
      min(
        Int((ratio * Double(frequencyEnd)).rounded(.up)),
        framesPerBuffer / 2
      ) - startIndex

    plan = fftw_plan_r2r_1d(Int32(framesPerBuffer), inBuffer, outBuffer, FFTW_R2HC, FFTW_ESTIMATE)
  }

  func calculate(input: [Float], frameCount: Int) -> [Double] {

    // we want to copy our data to our other buffer.
    //let rawBufferPointer = UnsafeRawBufferPointer(start: input, count: frameCount)
    let inBufferPointer: UnsafeMutableBufferPointer<Double> = UnsafeMutableBufferPointer(
      start: inBuffer, count: frameCount)

    for index in stride(from: 0, to: Int(frameCount), by: 1) {
      inBufferPointer[index] = Double(input[index])
    }

    fftw_execute(plan)

    let outBufferPtr = UnsafeBufferPointer(start: outBuffer, count: framesPerBuffer)

    return Array(outBufferPtr)
  }

  deinit {
    fftw_destroy_plan(plan)
    fftw_free(inBuffer)
    fftw_free(outBuffer)
  }

}
