//
//  BarcodeViewController.swift
//  HopeathonAdmin
//
//  Created by Resky Javieri on 03/09/18.
//  Copyright © 2018 Jason Elian. All rights reserved.
//

import UIKit
import AVFoundation

class BarcodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var video = AVCaptureVideoPreviewLayer()
    
    @IBOutlet weak var backgroundTransparent: UIImageView!
    
    var cameraView : UIView!
    
    var isFirstCapture : Bool = true
    
    @IBOutlet weak var contentView: UIView!
    
    
    @IBAction func scanIDPasienButton(_ sender: Any) {
        performSegue(withIdentifier: "barcodeToID", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        isFirstCapture = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    self.navigationController?.navigationBar.prefersLargeTitles = true

        // Creating Session
        let session = AVCaptureSession()
        
        // Define Capture Device
        let captureDevice = AVCaptureDevice.default(for: .video)
        
        do
        {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        }
        catch
        {
            print("Error")
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        
        view.bringSubview(toFront: contentView)
        
        
        session.startRunning()
    }
    
    internal func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
      
        if metadataObjects.count != 0
        {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            {
                if object.type == AVMetadataObject.ObjectType.qr && isFirstCapture
                {
                    print("detect")
                    isFirstCapture = false
                    if object.stringValue == "1" {
                        performSegue(withIdentifier: "qrToDetail", sender: nil)
                    }
                    
                    else
                    {
                        isFirstCapture = true
                        
                        let alert = UIAlertController(title: "QR Code Salah", message: "Pastikan QR Code yang Di-Scan Sudah Benar", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Ulangi", style: .default, handler: nil))
                        
                        present(alert, animated: true, completion: nil)
                    }
                    
                    
//                    let alert = UIAlertController(title: "Scan QR Code", message: object.stringValue, preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
//                    alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: {(nil) in
//
//                        UIPasteboard.general.string = object.stringValue
//                    }))
                    
//                    present(alert, animated: true, completion: nil)
                }
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
