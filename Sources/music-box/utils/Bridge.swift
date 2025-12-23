// code to halpe manage wrapping and unwrapping of objects.
import Foundation

func bridge<T: AnyObject>(obj: T) -> UnsafeMutableRawPointer { 
    return UnsafeMutableRawPointer(Unmanaged.passUnretained(obj).toOpaque())
}

func bridge<T: AnyObject>(ptr: UnsafeRawPointer) -> T { 
    return Unmanaged<T>.fromOpaque(ptr).takeUnretainedValue();
}

func unbridge<T: AnyObject>(ptr: UnsafeRawPointer) -> T { 
    return Unmanaged<T>.fromOpaque(ptr).takeUnretainedValue();
}