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
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var recordButton: RecordButtonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        captureSession = AVCaptureSession()

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

