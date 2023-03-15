//
//  SQLHelper.swift
//  DataBaseSqlite
//
//  Created by Bhautik Rajodiya on 11/03/23.

import Foundation

struct Model {
    var id: Int
    var name: String
}

class SQLHelper {
    
    static var file: FMDatabase!
    
    static func creatFlie() {
        var x = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        x.appendPathComponent("My FMDB File1.db")
        file = FMDatabase(url: x)
        file.open()
        print(x.path)
        creatTable()
    }
    
    static func creatTable() {
        let q = "Create Table if not exists Students (name text, id integer)"
        try? file.executeUpdate(q, values: nil)
    }
    static func addData(name: String , id: Int) {
        let q = "insert into students values (?, ?)"
       try? file.executeUpdate(q, values: [name,id])
    }
    static func retriveData()-> [Model]{
        var arr = [Model]()
        let q = "select * from Students"
        if let data = try? file.executeQuery(q, values: nil) {
            
            while data.next() {
                let nn = data.object(forColumnIndex: 0) as? String ?? ""
                let ii = data.object(forColumn: "id") as? Int ?? 0
                
                let obj = Model(id: ii, name: nn)
                arr.append(obj)
            }
        }
        return arr
    }
    static func deleteData(name:String,id : Int) {
        let q = "DELETE FROM Students WHERE id = \(id)"
        try? file.executeUpdate(q, values: nil)
        
    }
}
