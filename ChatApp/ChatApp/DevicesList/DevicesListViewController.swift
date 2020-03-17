//
//  DevicesListViewController.swift
//  ChatApp
//
//  Created by Roy Quesada on 3/16/20.
//  Copyright © 2020 Roy Quesada. All rights reserved.
//

import UIKit

class DevicesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    var vm = DevicesListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DeviceTableViewCell")
        self.vm.getDevices {
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        }
    }
    
    // MARK - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.devicesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceTableViewCell", for: indexPath)
        cell.textLabel?.text = self.vm.devicesList[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    // MARK - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Sent message")
        self.performSegue(withIdentifier: "chatSegue", sender: nil)
    }
}
