//
//  SocketIOManager.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/07.
//

import Foundation
//import SocketIO
//
//class SocketIOManager {
//    static let shared = SocketIOManager()
//    var manager: SocketManager!
//    var socket: SocketIOClient!
//
//    private init(){
//        
//        manager = SocketManager(socketURL: URL(string: APIKey.baseURL+"chat/{to}")!, config: [
//            .log(true),
//            .extraHeaders(["auth": APIKey.header])])
//
//        socket = manager.defaultSocket // https: api.sesac.co.kr:2022/
//
//        //MARK: on 은 서버 -> app으로 전달받음
//        /// 연결
//        socket.on(clientEvent: .connect) { data, ack in
//            print("SOCKET IS CONNECTED", data, ack)
//        }
//        /// 연결해제
//        socket.on(clientEvent: .disconnect) { data, ack in
//            print("SOCKET IS DISCONNECTED", data, ack)
//        }
//        /// 이벤트 수신
//        socket.on("sesac") { dataArray, ack in
//            print("SESAC RECEIVED", dataArray, ack)
//
//            // 타입캐슽팅
//            let data = dataArray[0] as! NSDictionary
//            let chat = data["text"] as! String
//            let name = data["name"] as! String
//            let userId = data["userId"] as! String
//            let createdAt = data["createdAt"] as! String
//            print("@@@@check:", chat, name, createdAt)
//
//            NotificationCenter.default.post(name: Notification.Name("getMessage"), object: self, userInfo:["chat":chat, "name":name, "userId":userId, "createdAt" : createdAt])
//
//        }
//    }
//    func establishConnetion() {
//        socket.connect() // 실시간으로 서버와 연결통신한다
//    }
//
//    func closeConnection() {
//        socket.disconnect()
//    }
//
//}
//
