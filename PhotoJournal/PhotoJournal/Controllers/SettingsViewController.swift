//
//  SettingsViewController.swift
//  PhotoJournal
//
//  Created by Sunni Tang on 10/3/19.
//  Copyright © 2019 Sunni Tang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    weak var delegate: SettingsDelegate?
    @IBOutlet weak var scrollSwitch: UISwitch!
    
    var isVerticalScroll = true
    
    enum ScrollDirection {
        case vertical
        case horizontal
    }
    
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
    }
    
    @IBAction func switchScrollDirectionChanged(_ sender: UISwitch) {
        switch sender.isOn {
        case true:
            setVerticalScroll(setting: .vertical)
        case false:
            setVerticalScroll(setting: .horizontal)
        }
    }
    
    private func setVerticalScroll(setting: ScrollDirection) {
        switch setting {
        case .vertical:
            delegate?.setVerticalScroll()
        case .horizontal:
            delegate?.setHorizontalScroll()
        }
    }
    
}

