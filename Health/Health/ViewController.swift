//
//  ViewController.swift
//  Health
//
//  Created by miaokii on 2020/1/11.
//  Copyright © 2020 ly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stateLabel: UILabel!
    private var healthManager = HealthManager.share
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateState()
    }

    @IBAction func requestAuth(_ sender: Any) {
        healthManager.request { [unowned self] () -> ()? in
            DispatchQueue.main.async {
                self.updateState()
            }
        }
    }
    
    private func updateState() {
        guard HealthManager.supportHealthKit else {
            stateLabel.text = "不支持"
            return
        }
        
        if healthManager.isAuthorized {
            stateLabel.text = "通过"
        } else {
            stateLabel.text = "拒绝"
        }
    }
}

