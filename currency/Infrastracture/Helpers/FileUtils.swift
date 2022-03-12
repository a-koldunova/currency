//
//  FileUtils.swift
//  currency
//
//  Created by Tanya Koldunova on 11.03.2022.
//

import UIKit

class FileUtils {
    
    class func getPath(_ fileName: String) -> String {
        let documentsURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(fileName)
        return fileURL.path
    }
    
    class func checkPath() {
        let fm=FileManager.default
        let documentsURL = fm.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        if !fm.fileExists(atPath: documentsURL.path){
            
            do {
                try  fm.createDirectory(at: documentsURL, withIntermediateDirectories: true, attributes: nil)
            }
            catch let error as NSError{
                print (error.localizedDescription)
            }
        }
    }
    
    // get url which refer on directory
    class func getDirectoryUrl(_ directoryName: String)->URL{
        let fileManager = FileManager.default
        let cacheURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        //return cacheURL.appendingPathComponent(imoNo.description, isDirectory: true)
        return cacheURL.appendingPathComponent(directoryName, isDirectory: true)
    }
    
    class func deleteDirectoryByImo(_ directoryName:String){
        let fileManager = FileManager.default
        let dirUrl=getDirectoryUrl(directoryName)
        if let lst=try?fileManager.contentsOfDirectory(atPath: dirUrl.path){
            for item in lst{
                let fileUrl=dirUrl.appendingPathComponent(item)
                try?fileManager.removeItem(at: fileUrl)
            }
        }
        try?fileManager.removeItem(at: dirUrl)
    }
    
    // create folder whith imo
    class func createDirectoryByImo (_ name: String) {
        let cacheUrl=getDirectoryUrl(name)
        do {
            try  FileManager.default.createDirectory(atPath: cacheUrl.path, withIntermediateDirectories: true, attributes: nil)
        }
        catch let error {
            print (error.localizedDescription)
        }
    }
    
    
    class func writeToFile<T>(directoryName: String, fileName: String, model: T)-> Bool where T: Codable {
        let fileName=FileUtils.getDirectoryUrl(directoryName).appendingPathComponent(fileName)
        do {
            let json = try JSONEncoder().encode(model)
            let jsonString = String(data: json, encoding: .utf8)!
            try jsonString.write(toFile: fileName.path, atomically: true, encoding: .utf8)
            return true
        } catch let error {
            return false
        }
        
    }
    
    class func writeToFile(directoryName: Int, fileName: String, image: UIImage)->Bool {
        let fileName=FileUtils.getDirectoryUrl(directoryName.description).appendingPathComponent(fileName)
       
        if let data = image.jpegData(compressionQuality: 0.8) {
            do {
            try data.write(to: URL(fileURLWithPath: fileName.path), options: [.atomic])
                return true
            } catch  {
                return false
            }
        }
        return false
    }
    
    class func writeToFile(directoryName: Int, fileName: String, text: String)->Bool {
        let fileName=FileUtils.getDirectoryUrl(directoryName.description).appendingPathComponent(fileName)
        do {
        try text.write(toFile: fileName.path, atomically: true, encoding: .utf8)
            return true
        } catch  {
           return false
        }
        
    }
    
    class func getImageFromFile(directoryName: Int, fileName: String)->UIImage? {
        let fileName=FileUtils.getDirectoryUrl(directoryName.description).appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: fileName.path){
            return UIImage(contentsOfFile: fileName.path)
        }
        return nil
    }
    
    class func getStructFromFile<T>(directoryName: String, fileName: String)->T? where T: Codable {
        let fileName=FileUtils.getDirectoryUrl(directoryName).appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: fileName.path){
            do {
                 let jsonString = try String(contentsOfFile: fileName.path, encoding: String.Encoding.utf8)
                    let result = try JSONDecoder().decode(T.self, from: Data(jsonString.utf8))
                return result as! T
            } catch let error {
                print(error.localizedDescription)
                return nil
            }
        }
        return nil
    }
    
    class func getTextFromFile(directoryName: String, fileName: String)-> String? {
        let filename = FileUtils.getDirectoryUrl(directoryName).appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: filename.path){
            do {
               let res = try String(contentsOfFile: filename.path, encoding: .utf8)
                return res
            } catch let error {
                print(error.localizedDescription)
                return nil
            }
        }
        return nil
        
    }
        
        class func copyFile(_ fileName: NSString)-> String {
            let dbPath: String = getPath(fileName as String)
            var error : NSError?
            let fileManager = FileManager.default
            var result=""
            if fileManager.fileExists(atPath: dbPath) {
                do {
                    try fileManager.removeItem(atPath: dbPath)
                }
                catch let error1 as NSError {
                    error = error1
                    print (error!.localizedDescription)
                }
            }
            let documentsURL = Bundle.main.resourceURL
            let fromPath = documentsURL!.appendingPathComponent(fileName as String)
            
            
            do {
                try fileManager.copyItem(atPath: fromPath.path, toPath: dbPath)
            } catch let error1 as NSError {
                error = error1
            }
            // let alert: UIAlertView = UIAlertView()
            if (error != nil) {
                result=(error?.localizedDescription)!
                
            } else {
                result = "Successfully Copy"
            }
            return result
        }
        
        class func fileExists(_ directoryName:String, fileName:String)->Bool{
            let fm=FileManager.default
            let fn=getDirectoryUrl(directoryName).appendingPathComponent(fileName)
            return fm.fileExists(atPath: fn.path)
        }
        
        class func deleteFile(_ directoryName:String, fileName:String){
            let fm=FileManager.default
            let fn=getDirectoryUrl(directoryName).appendingPathComponent(fileName)
            if fm.fileExists(atPath: fn.path){
                do{
                    try fm.removeItem(at: fn)
                }
                catch let error as NSError {
                    print (error.localizedDescription)
                }
            }
        }
        
        class func renameFile(_ directoryName:String, fromFileName:String, toFileName:String ){
            let fm=FileManager.default
            let fromPath=getDirectoryUrl(directoryName).appendingPathComponent(fromFileName)
            if fm.fileExists(atPath: fromPath.path){
                let toPath=getDirectoryUrl(directoryName).appendingPathComponent(toFileName)
                do {
                    try  fm.copyItem(at: fromPath, to: toPath)
                }
                catch let error as NSError {
                    print (error.localizedDescription)
                }
                do{
                    try fm.removeItem(at: fromPath)
                }
                catch let error as NSError {
                    print (error.localizedDescription)
                }
                
            }
        }
        
        class func lastVessels()->[String]{
            var fleet=[String]()
            let DocumentsDirectory = FileManager().urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
            let HISTORY_URL=DocumentsDirectory.appendingPathComponent("history")
            let MY_FLEET_URL=DocumentsDirectory.appendingPathComponent("my_fleet")
            
            do{
                let data=try Data(contentsOf: HISTORY_URL)
                if let history=try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String]{
                    fleet.append(contentsOf: history)
                }
            }catch{
                print ("error")
            }
            
            do{
                let data=try Data(contentsOf: MY_FLEET_URL)
                if let myFleet=try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String]{
                    fleet.append(contentsOf: myFleet)
                }
            }catch{
                print ("error")
            }
            
            /*if let  history = NSKeyedUnarchiver.unarchiveObject(withFile: HISTORY_URL.path) as? [String]{
             fleet.append(contentsOf: history)
             }
             if let myFleet = NSKeyedUnarchiver.unarchiveObject(withFile: MY_FLEET_URL.path) as? [String]{
             fleet.append(contentsOf: myFleet)
             }*/
            return fleet
        }
    }

