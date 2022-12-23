//
//  Repository.swift
//  ServiceLevelProject
//
//  Created by useok on 2022/12/17.
//

import Foundation
import RealmSwift

protocol RepositoryType {
    func fetch() -> Results<ChatData>
    func addChat(item: ChatData)
}


class Repository: RepositoryType {
    let localRealm = try! Realm()
    
    func fetch() -> Results<ChatData> {
        return localRealm.objects(ChatData.self)
    }
    
    func addChat(item: ChatData) {
        do {
            try localRealm.write {
                localRealm.add(item)
            }
        } catch let error{
            print(error)
        }
    }
    
}
