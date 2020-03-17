//
//  NetworkManager.swift
//  ChatApp
//
//  Created by Roy Quesada on 3/16/20.
//  Copyright © 2020 Roy Quesada. All rights reserved.
//

import UIKit
import Network
class NetworkManager: NSObject {

    static let shared = NetworkManager()
    private var connection: NWConnection?
    private var hostUDP: NWEndpoint.Host = "localhost"
    private var portUDP: NWEndpoint.Port = 9876
    
    var devicesList = [String]()
    
    //Initializer access level change now
    private override init(){}
    
    func requestForConnection(host: String?, port:String?){
        
        if let ipHost = host, ipHost != ""{
            self.hostUDP = NWEndpoint.Host(ipHost)
        }
        
        if let portN = port, portN != "" {
            self.portUDP = NWEndpoint.Port(portN) ?? 9876
        }
        
        self.connectToUDP(self.hostUDP, self.portUDP)
    }

    
    func connectToUDP(_ hostUDP: NWEndpoint.Host, _ portUDP: NWEndpoint.Port) {
        self.connection = NWConnection(host: hostUDP, port: portUDP, using: .udp)

        self.connection?.stateUpdateHandler = { (newState) in
            print("This is stateUpdateHandler:")
            switch (newState) {
                case .ready:
                    print("State: Ready\n")
                case .setup:
                    print("State: Setup\n")
                case .cancelled:
                    print("State: Cancelled\n")
                case .preparing:
                    print("State: Preparing\n")
                default:
                    print("ERROR! State not defined!\n")
            }
        }

        self.connection?.start(queue: .global())
    }
    
    func sendUDP(_ content: Data) {
        self.connection?.send(content: content, completion: NWConnection.SendCompletion.contentProcessed(({ (NWError) in
            if (NWError == nil) {
                print("Data was sent to UDP")
            } else {
                print("ERROR! Error when data (Type: Data) sending. NWError: \n \(NWError!)")
            }
        })))
    }

    func sendUDP(_ content: String) {
        let contentToSendUDP = content.data(using: String.Encoding.utf8)
        self.connection?.send(content: contentToSendUDP, completion: NWConnection.SendCompletion.contentProcessed(({ (NWError) in
            if (NWError == nil) {
                print("Data was sent to UDP")
            } else {
                print("ERROR! Error when data (Type: Data) sending. NWError: \n \(NWError!)")
            }
        })))
    }
    
    func receiveUDP(completion: @escaping (String) -> ()) {
        self.connection?.receiveMessage { (data, context, isComplete, error) in
            if (isComplete) {
                print("Receive is complete")
                if (data != nil) {
                    let messageString = String(decoding: data!, as: UTF8.self)
                    completion(messageString)
                    /*print("Received message: \(backToString)")
                    self.decodeMessage(message: backToString)*/
                } else {
                    completion("")
                }
            }else{
                completion("")
            }
        }
    }
    
    func decodeMessage(message:String){
        if message.contains("connections:"){
            print("Parse List")
            var alldevices:[String] = message.components(separatedBy: ":")
            alldevices.removeFirst(1)
            self.devicesList = alldevices
        }
    }
    
}
