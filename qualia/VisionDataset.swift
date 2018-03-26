//
//  VisionDataset.swift
//  qualia
//
//  Created by Kirk Roerig on 3/25/18.
//  Copyright © 2018 Kirk Roerig. All rights reserved.
//

import UIKit
import AVFoundation

class VisionDataset: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
  
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        connection.videoOrientation = .portrait
        getFrame(from: sampleBuffer)
    }
    
    func getFrame(from sampleBuffer : CMSampleBuffer) -> UIImage {
//        let imgBuf = CMSampleBufferGetImageBuffer(sampleBuffer)!
//
//        CVPixelBufferLockBaseAddress(imgBuf, .readOnly)
//
//        let baseAddress = CVPixelBufferGetBaseAddress(imgBuf)
//        let bytesPerRow = CVPixelBufferGetBytesPerRow(imgBuf)
//        let width = CVPixelBufferGetWidth(imgBuf) / 2
//        let height = CVPixelBufferGetHeight(imgBuf)
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//
//        let context = CGContext.init(data: baseAddress,
//                                     width: width,
//                                     height: height,
//                                     bitsPerComponent: 8,
//                                     bytesPerRow: bytesPerRow,
//                                     space: colorSpace,
//                                     bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue)
//
//        // Create a Quartz image from the pixel data in the bitmap graphics context
//        let quartzImage = CGContext.makeImage(context!) as! CGImage
//
//        // Unlock the pixel buffer
//        CVPixelBufferUnlockBaseAddress(imgBuf, .readOnly);
//
//        // Free up the context and color space
//        let frame = UIImage.init(cgImage: quartzImage)
//
//        return frame
        let imageBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
        let ciimage : CIImage = CIImage(cvPixelBuffer: imageBuffer)
        let context : CIContext = CIContext.init(options: nil)
        let cgImage : CGImage = context.createCGImage(ciimage, from: ciimage.extent)!
        let image : UIImage = UIImage.init(cgImage: cgImage)
        return image
    }
}
