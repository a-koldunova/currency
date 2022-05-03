//
//  CryptoUtils.swift
//  currency
//
//  Created by Tanya Koldunova on 11.03.2022.
//


import Foundation
import FMDB

class DBManager{
    static let sharedInstance=DBManager()
    static let dbVersion=1
    static let key="ca-app-pub-59440"
    static let iv="http://fxrates.f"
    var urlList : [Int:String]?
    var db: FMDatabase?
    
    fileprivate init(){
    }
    
    class func getInstance() -> DBManager
    {
        if sharedInstance.db == nil {
            sharedInstance.db = FMDatabase(path: FileUtils.getPath("rcurra.db"))
            if sharedInstance.db == nil{
                return sharedInstance
            }
            if !sharedInstance.db!.open(){
                sharedInstance.db = nil
                return sharedInstance
            }
        }
        return sharedInstance
    }
    
    
    
    class func prepareDB() {
        var version_no=0
        FileUtils.checkPath()
        print (FileUtils.getPath("rcurra.db"))
        var db=DBManager.getInstance().db!
        if let res=db.executeQuery("select VER_NO from VERS", withArgumentsIn: []){
            if res.next(){
                version_no=res.long(forColumnIndex: 0)
            }
            res.close()
        }
        if version_no != DBManager.dbVersion{
            DBManager.closeDB()
            print (FileUtils.copyFile("rcurra.db"))
            db=DBManager.getInstance().db!
        }
    }
    
    class func closeDB(){
        if sharedInstance.db != nil{
            sharedInstance.db?.close()
            sharedInstance.db=nil
        }
    }
    
}
