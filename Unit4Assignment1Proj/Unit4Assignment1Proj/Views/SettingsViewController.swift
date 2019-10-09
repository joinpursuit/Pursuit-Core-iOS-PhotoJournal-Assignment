//
//  SettingsViewController.swift
//  Unit4Assignment1Proj
//
//  Created by Kevin Natera on 10/6/19.
//  Copyright © 2019 Kevin Natera. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var scrollSwitch: UISwitch!
    @IBOutlet weak var scrollDirectionLabel: UILabel!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var darkModeLabel: UILabel!
    @IBOutlet weak var currentScrollDirectionLabel: UILabel!
    @IBOutlet weak var modeLabel: UILabel!
    
    @IBAction func scrollSwitchPressed(_ sender: UISwitch) {
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
    
    
    @IBAction func darkModeSwitchPressed(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            self.darkModeisOn = true
            formatColors(darkModeIsOn: darkModeisOn)
            setDarkMode(setting: .on)
        case false:
            self.darkModeisOn = false
            formatColors(darkModeIsOn: darkModeisOn)
            setDarkMode(setting: .off)
        }
    }
    
    weak var delegate: SettingsDelegate?
    
    var verticalScroll = true
    var darkModeisOn = false
    
    override func viewWillAppear(_ animated: Bool) {
        setUpUI()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    enum Setting : String {
        case on
        case off
    }
    
    private func setVerticalScroll(setting: Setting) {
        switch setting {
        case .on:
            delegate?.verticalScrollOn()
        case .off:
            delegate?.verticalScrollOff()
        }
    }
    
    private func setDarkMode(setting: Setting) {
        switch setting {
        case .on:
            delegate?.darkModeOn()
        case .off:
            delegate?.darkModeOff()
        }
    }
    
    private func formatColors(darkModeIsOn: Bool) {
        switch darkModeIsOn {
        case true:
            view.backgroundColor = .black
            currentScrollDirectionLabel.textColor = .white
            scrollDirectionLabel.textColor = .white
            darkModeLabel.textColor = .white
            darkModeLabel.text = "On"
            modeLabel.textColor = .white
        case false:
            view.backgroundColor = .white
            currentScrollDirectionLabel.textColor = .black
            scrollDirectionLabel.textColor = .black
            darkModeLabel.textColor = .black
            darkModeLabel.text = "Off"
            modeLabel.textColor = .black
        }
    }
    
    private func setUpUI() {
        scrollSwitch.isOn = verticalScroll
        darkModeSwitch.isOn = darkModeisOn
        formatColors(darkModeIsOn: darkModeisOn)
        if verticalScroll {
            scrollDirectionLabel.text = "Vertical"
        } else {
            scrollDirectionLabel.text = "Horizontal"
        }
    }
}

