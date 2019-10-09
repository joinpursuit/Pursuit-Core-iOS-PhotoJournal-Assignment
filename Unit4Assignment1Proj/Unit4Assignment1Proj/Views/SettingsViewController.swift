//
//  SettingsViewController.swift
//  Unit4Assignment1Proj
//
//  Created by Kevin Natera on 10/6/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var scrollSlider: UISwitch!
    @IBOutlet weak var scrollDirectionLabel: UILabel!
    @IBOutlet weak var backgroundColorSlider: UISlider!
    
    @IBAction func scrollSliderPressed(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            self.verticalScroll = true
            self.scrollDirectionLabel.text = "Vertical"
            setVerticalScroll(setting: .on)
        case false:
            self.verticalScroll = false
            self.scrollDirectionLabel.text = "Horizontal"
            setVerticalScroll(setting: .off)
        }
    }
    
    @IBAction func backgroundColorSliderDragged(_ sender: UISlider) {
        
    }
    
    weak var delegate: SettingsDelegate?
    
    var verticalScroll = true
       
    
    override func viewWillAppear(_ animated: Bool) {
        setUpUI()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    enum VerticalScrollSetting : String {
        case on
        case off
    }
    
    private func setVerticalScroll(setting: VerticalScrollSetting) {
        switch setting {
        case .on:
            delegate?.verticalScrollOn()
        case .off:
            delegate?.verticalScrollOff()
        }
    }
    
    private func setUpUI() {
        scrollSlider.isOn = verticalScroll
               if verticalScroll {
                   scrollDirectionLabel.text = "Vertical"
               } else {
                   scrollDirectionLabel.text = "Horizontal"
               }
    }
}

