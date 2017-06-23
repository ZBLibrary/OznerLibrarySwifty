//
//  OznerTools.swift
//  OznerLibrarySwiftyDemo
//
//  Created by 赵兵 on 2017/1/5.
//  Copyright © 2017年 net.ozner. All rights reserved.
//

import UIKit

class OznerTools: NSObject {
    class func dataFromInt(number:CLongLong,length:Int)->Data{
        var data=Data()
        if length<1 {
            return data
        }
        var tmpValue = CLongLong(0)
        for i in 0...(length-1) {
            let powInt = CLongLong(pow(CGFloat(256), CGFloat(i)))
            let needEle=(number-tmpValue)/powInt%256
            data.append(UInt8(needEle))
            tmpValue+=CLongLong(needEle)*powInt
        }
        return data
    }
    class func hexStringFromData(data:Data)->String{
        var hexStr=""
        for i in 0..<data.count {
            if Int(data[i])<16 {
                hexStr=hexStr.appendingFormat("0")
            }
            hexStr=hexStr.appendingFormat("%x",Int(data[i]))
        }
        return hexStr
    }
    class func hexStringToData(strHex:String)->Data{
        var data=Data()
        if strHex.characters.count%2 != 0 {
            return data
        }
        for i in 0..<strHex.characters.count/2 {
            let range1 = strHex.index(strHex.startIndex, offsetBy: i*2)
            let range2 = strHex.index(strHex.startIndex, offsetBy: i*2+2)
            let hexString = strHex.substring(with: Range(range1..<range2))
            var result1:UInt32 = 0
            Scanner(string: hexString).scanHexInt32(&result1)
            data.insert(UInt8(result1), at: i)
        }
        return data
    }
    class func publicString(payload:Data,deviceid:String,callback:((Int32)->Void)!){
        let payloadStr=OznerTools.hexStringFromData(data: payload)
        let params = ["username" : "bing.zhao@cftcn.com","password" : "l5201314","deviceid" : deviceid,"payload" : payloadStr]//设置参数
        print("2.0发送指令："+payloadStr)
        Helper.post("https://v2.fogcloud.io/enduser/sendCommandHz/", requestParams: params) { (response, data, error) in
            print(error ?? "")
        }
      
    }
    
}
