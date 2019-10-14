//
//  ViewController.swift
//  SocketTest
//
//  Created by Apple on 11/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import SocketIO

class ViewController: UIViewController {
    
    var manager:SocketManager!
    var socketIOClient: SocketIOClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConnectToSocket()
    }
    
    func ConnectToSocket() {
        
//        let headers = ["token": "x3OerE0MAkEk44fTbzGBbw=="]
//        manager = SocketManager(
//            socketURL: URL(string: "https://dev.krank.com:3000/auction")!,
//            config: [
//                .log(true),
//                .compress,
//                .forceNew(true),
////                .reconnectAttempts(10),
////                .reconnectWait(6000),
//                .secure(true),
//                .selfSigned(true),
//                .forcePolling(false),
//                .forceWebsockets(true),
//                .extraHeaders(headers),
//                .connectParams(headers)
//            ]
//        )
        
        
        manager = SocketManager(
            socketURL: URL(string: "https://dev.krank.com:3000/auction")!,
            config: [
                .log(true),
                .forceNew(true),
                .reconnectAttempts(10),
                .reconnectWait(6000),
                .connectParams(["token":"8KpFfNgdMs8vaPpufNYhyQ=="]),
                .forceWebsockets(true),
                .compress
            ]
        )
        
        
        
        socketIOClient = manager.socket(forNamespace: "/auction")
        
        socketIOClient.on(clientEvent: .connect) {data, ack in
            print(data)
            print("socket connected")
            //            self.socketIOClient.emit("chat message", "afwef")
        }
        
        socketIOClient.on("auction-177") { data, ack in
            print(data)
        }
        
        socketIOClient.on(clientEvent: .error) { (data, eck) in
            print(data)
            print("socket error")
        }
        
        socketIOClient.on(clientEvent: .disconnect) { (data, eck) in
            print(data)
            print("socket disconnect")
        }
        
        socketIOClient.on(clientEvent: SocketClientEvent.reconnect) { (data, eck) in
            print(data)
            print("socket reconnect")
        }
        
        socketIOClient.connect()
        
    }
    
}

