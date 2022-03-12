//
//  CryptoUtils.swift
//  currency
//
//  Created by Tanya Koldunova on 11.03.2022.
//

import Foundation
import CryptoSwift

func aesEncrypt(source:String, key: String, iv: String) throws -> String {
    let data = source.data(using: .utf8)!
    let encrypted = try! AES(key: key.bytes, blockMode: CBC(iv: iv.bytes), padding: .pkcs7).encrypt([UInt8](data))
    let encryptedData = Data(encrypted)
    return encryptedData.base64EncodedString()
}

func aesEncrypt(source:Data, key: String, iv: String) throws -> String {
    let encrypted = try! AES(key: key.bytes, blockMode: CBC(iv: iv.bytes), padding: .pkcs7).encrypt([UInt8](source))
    let encryptedData = Data(encrypted)
    return encryptedData.base64EncodedString()
}

private func decompressData(_ compressed: Data)->Data?{
    if let decompressed=try?(compressed as NSData).bbs_dataByInflating(){
        return decompressed
    }else{
        return nil;
    }
}

private func decompress(_ compressed: Data)->String{
    if let decompressed=try?(compressed as NSData).bbs_dataByInflating(){
        let result=String(data: decompressed, encoding: String.Encoding.utf8)
        return String(result!)
    }else{
        return "";
    }
}

func xDecryptData(_ crypted: Data?, key:String, iv:String)->Data?{
    if crypted==nil{
        return nil
    }
    if let compressed=try?crypted!.decrypt(cipher: AES(key: key, iv: iv, padding: Padding.zeroPadding)){
        return decompressData(compressed)
    }else{
        return nil;
    }
}

func xDecrypt(_ crypted: Data?, key:String, iv:String)->String{
    if crypted==nil{
        return ""
    }
    if let compressed=try?crypted!.decrypt(cipher: AES(key: key, iv: iv, padding: Padding.zeroPadding)){
        //if let compressed=try?crypted!.decrypt(cipher: AES(key: key, iv: iv)){
        return decompress(compressed)
    }else{
        return "";
    }
}





