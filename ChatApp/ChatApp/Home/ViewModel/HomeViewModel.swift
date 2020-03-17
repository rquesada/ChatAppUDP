//
//  HomeViewModel.swift
//  ChatApp
//
//  Created by Roy Quesada on 3/16/20.
//  Copyright © 2020 Roy Quesada. All rights reserved.
//

import UIKit

class HomeViewModel: NSObject {

    func connectToServer(host: String?, port: String?){
        NetworkManager.shared.requestForConnection(host: host, port:port)
    }
}
