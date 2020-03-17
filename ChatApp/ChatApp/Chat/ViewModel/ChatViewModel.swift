//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Roy Quesada on 3/16/20.
//  Copyright © 2020 Roy Quesada. All rights reserved.
//

import UIKit

class ChatViewModel: NSObject {
    var selectedDevice = ""
    var messagesList = [String]()
    
    func getMessagefor(ip:String){
        var cacheMessages = UserDefaults.standard.array(forKey: ip) ?? [String]()
        self.messagesList = cacheMessages as! [String]
    }
    
    func sendMessage(message:String){
        //Save messages
        var cacheMessages = UserDefaults.standard.array(forKey: selectedDevice) ?? [String]()
        cacheMessages.append("sent: \(message)")
        UserDefaults.standard.set(cacheMessages, forKey : selectedDevice)
        self.getMessagefor(ip: selectedDevice)
        
        //Send Message
        NetworkManager.shared.sendUDP("sent:\(selectedDevice):\(message)")
    }
    
    func getMessage(completion: @escaping () -> ()){
        NetworkManager.shared.receiveUDP { message in
            self.decodeMessage(message)
            completion()
        }
    }
    
    func decodeMessage(_ message:String){
        if message.contains("sent:"){
            
        }
    }
}
