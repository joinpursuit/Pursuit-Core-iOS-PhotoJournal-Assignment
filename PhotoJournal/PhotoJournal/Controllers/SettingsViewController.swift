//
//  SettingsViewController.swift
//  PhotoJournal
//
//  Created by Sunni Tang on 10/3/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var scrollSwitch: UISwitch!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    // MARK: - Internal Properties
    var isVerticalScroll = true
    var darkModeOn = false

    weak var delegate: SettingsDelegate?
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        switch isVerticalScroll {
        case true:
            scrollSwitch.isOn = true
        case false:
            scrollSwitch.isOn = false
        }
        
        switch darkModeOn {
        case true:
            darkModeSwitch.isOn = true
        case false:
            darkModeSwitch.isOn = false
        }
    }
    
    // MARK: - IBActions
    @IBAction func switchScrollDirectionChanged(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            setVerticalScroll(setting: .vertical)
        case false:
            setVerticalScroll(setting: .horizontal)
        }
    }
    
    @IBAction func switchDarkModeChanged(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            setDarkMode(setting: .on)
        case false:
            setDarkMode(setting: .off)
        }
    }
    // MARK: - Private Methods
    private func setVerticalScroll(setting: ScrollDirection) {
        switch setting {
        case .vertical:
            delegate?.setVerticalScroll()
        case .horizontal:
            delegate?.setHorizontalScroll()
        }
    }
    
    private func setDarkMode(setting: DarkMode) {
        switch setting {
        case .on:
            delegate?.darkModeOn()
        case .off:
            delegate?.darkModeOff()
        }
    }
    
}

