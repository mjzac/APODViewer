//
//  ViewController.swift
//  APODViewer
//
//  Created by Melson Zacharias on 23/02/17.
//  Copyright © 2017 Perleybrook Labs LLC. All rights reserved.
//

import Cocoa
import Moya
import Moya_Argo

class ViewController: NSViewController {
    var apod:APODModel?
    let provider = MoyaProvider<NasaAPI>()
    
    @IBOutlet weak var apodImageView: AspectFitImageView!
    
    @IBOutlet var apodDescription: NSTextView!
    @IBOutlet weak var apodTitle: NSTextField!
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    @IBOutlet weak var visualEffectView: NSVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.intialSetup()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    override func viewDidAppear() {
        self.fetchAPOD()
    }
    
    private func intialSetup() {
        self.apodDescription.font = NSFont(name: "Courier", size: 14.0)
        self.visualEffectView.isHidden = true
        self.apodDescription.isHidden = true
        self.progressIndicator.startAnimation(nil)
    }
    
    private func fetchAPOD() {
        provider.request(NasaAPI.getAPODConfig()) { result in
            self.progressIndicator.stopAnimation(nil)
            switch result {
            case .success(let response):
                do {
                    try self.handleSuccess(response: response)
                } catch {
                    print("Error mapping Model: \(error)")
                }
                
            case .failure(let error):
                self.handleError(error: error)
            }
        }
    }
    
    private func handleSuccess(response: Response) throws {
        
        let aModel: APODModel = try response.mapObject()
        self.visualEffectView.isHidden = false
        self.apodDescription.isHidden = false
        self.updateUI(with: aModel)
    }
    
    private func handleError(error: MoyaError) {
        
    }
    
    private func updateUI(with aModel:APODModel) {
        DispatchQueue.global().async {
            let image = NSImage(contentsOf: aModel.hdURL)
            DispatchQueue.main.async {
                self.apodImageView.image = image
            }
        }
        self.apodImageView.invalidateIntrinsicContentSize()
        self.apodTitle.stringValue = aModel.title
        self.apodDescription.string = aModel.explanation
        
    }
    
}

