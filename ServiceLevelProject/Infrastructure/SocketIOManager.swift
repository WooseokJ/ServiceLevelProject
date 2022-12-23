//
//  SocketIOManager.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/07.
//

import Foundation
import SocketIO
//
class SocketIOManager {
    static let shared = SocketIOManager()
    var manager: SocketManager!
    var socket: SocketIOClient!
    
    let repository = Repository()

    private init(){

        manager = SocketManager(socketURL: URL(string: APISeSac.baseURL)!, config: [.log(true), .forceWebsockets(true)])
                                                        

        socket = manager.defaultSocket
        
        //MARK: on 은 서버 -> app으로 전달받음
        /// 연결
        socket.on(clientEvent: .connect) { data, ack in
            print("SOCKET IS CONNECTED", data, ack)
//            self.socket.emit("socketID",UserDefaults.standard.string(forKey: "Myuid")!)

        }
        /// 연결해제
        socket.on(clientEvent: .disconnect) { data, ack in
            print("SOCKET IS DISCONNECTED", data, ack)
        }
        /// 이벤트 수신
        socket.on("chat") { dataArray, ack in
            print("SESAC RECEIVED", dataArray, ack)
            // 타입캐슽팅
            let data = dataArray[0] as! NSDictionary
            let chat = data["chat"] as! String
            let to = data["to"] as! String
            let from = data["from"] as! String
            let createdAt = data["createdAt"] as! String
            print("@@@@check:", chat, createdAt)
            UserDefaults.standard.set(createdAt, forKey: "createdAt")
            let chatContent = ChatData(to: to, from: from, chat: chat, createdAt: createdAt)
            self.repository.addChat(item: chatContent)
        }
    }
    func establishConnetion() {
        socket.connect() // 실시간으로 서버와 연결통신한다
    }

    func closeConnection() {
        socket.disconnect()
    }

}


