//
//  ViewController.swift
//  ChatApp
//
//  Created by Roy Quesada on 3/16/20.
//  Copyright © 2020 Roy Quesada. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var connectBtn: UIButton!
    @IBOutlet weak var ipTxt: UITextField!
    @IBOutlet weak var portTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.ipTxt.text = "192.168.100.55"
        self.portTxt.text = "9876"
    }
    
    @IBAction func connectHandler(_ sender: Any) {
        NetworkManager.shared.requestForConnection(host: self.ipTxt.text, port:self.portTxt.text)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.performSegue(withIdentifier: "showDevicesSegue", sender: nil)
        }
    }
}

