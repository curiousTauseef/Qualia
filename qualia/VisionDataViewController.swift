//
//  FirstViewController.swift
//  qualia
//
//  Created by Kirk Roerig on 3/25/18.
//  Copyright © 2018 Kirk Roerig. All rights reserved.
//

import UIKit
import AVFoundation

class VisionDataViewController: UIViewController {

    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var visionDS : VisionDataset?
    var captureOutput : AVCaptureVideoDataOutput?
    
    var cropTouchces : Array<UITouch>?;
    var cropRegion : CGRect?;
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var recordButton: RecordButtonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        captureSession = AVCaptureSession()
        
        cropTouchces = []

        do {
            let captureDevice = AVCaptureDevice.default(for: .video)
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            
            captureSession?.addInput(input)
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = .resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            cameraView.layer.addSublayer(videoPreviewLayer!)
            
            captureOutput = AVCaptureVideoDataOutput()
            captureSession?.addOutput(captureOutput!);
            
            captureSession?.startRunning()
        } catch {
            print(error.localizedDescription)
        }
        

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var i = 0
        for touch in touches {
            if cropTouchces!.count < 2 {
                cropTouchces?.append(touch)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        var corners : Array<CGPoint> = [];
        
//        for touch in touches {
//            if cropTouchces!.contains(touch) {
//                corners.append(touch.location(in: self.view))
//
//                if corners.count >= 2 {
//                    break
//                }
//            }
//        }
//
//        if cropTouchces!.count < 2 { return }
        
        let c0 = cropTouchces![0].location(in: view)
        let c1 = cropTouchces![1].location(in: view)
        
        cropRegion = CGRect(x: c0.x, y: c0.y, width: c1.x - c0.x, height: c1.y - c0.y)
        
        print(cropRegion)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if cropTouchces!.contains(touch) {
                cropTouchces!.removeAll()
            }
        }
    }
    
    @IBAction func recordTouched(_ sender: Any) {
        recordButton.isRecording = !recordButton.isRecording
        
        if visionDS == nil {
            visionDS = VisionDataset()
        }
        
        if recordButton.isRecording {
            captureOutput?.setSampleBufferDelegate(visionDS, queue: DispatchQueue.init(label: "videoQueue"))
        }
        else {
            captureOutput?.setSampleBufferDelegate(nil, queue: DispatchQueue.init(label: "videoQueue"))
        }
    }
}

