//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Roy Quesada on 3/16/20.
//  Copyright © 2020 Roy Quesada. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var messageTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DeviceTableViewCell")
    }
    
    // MARK - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NetworkManager.shared.devicesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceTableViewCell", for: indexPath)
        cell.textLabel?.text = NetworkManager.shared.devicesList[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    // MARK - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Sent message")
        self.performSegue(withIdentifier: "chatSegue", sender: nil)
    }

}
