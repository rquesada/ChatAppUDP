//
//  DevicesListViewModel.swift
//  ChatApp
//
//  Created by Roy Quesada on 3/16/20.
//  Copyright © 2020 Roy Quesada. All rights reserved.
//

import UIKit

class DevicesListViewModel: NSObject {
    
    var devicesList = [String]()
    
    func getDevices(completion: @escaping () -> ()){
        let util = Utilities()
        let message = "connect:\(util.getIPAddress())"
        NetworkManager.shared.sendUDP(message)
        NetworkManager.shared.receiveUDP { message in
            self.decodeMessage(message)
            completion()
        }
    }
    
    
    func decodeMessage(_ message:String){
        if message.contains("connections:"){
            print("Parse List")
            var alldevices:[String] = message.components(separatedBy: ":")
            alldevices.removeFirst(1)
            self.devicesList = alldevices
        }
    }

}
