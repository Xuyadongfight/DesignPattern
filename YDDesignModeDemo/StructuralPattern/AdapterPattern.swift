//
//  AdapterPattern.swift
//  YDDesignModeDemo
//
//  Created by 徐亚东 on 2023/4/25.
//

import Foundation

enum PlugType:String{
    case China = "中国插头标准"
    case America = "美国插头标准"
    case Europe = "欧洲插头标准"
}

protocol ChargeProtocol{
    static var suitablePlug : PlugType {get}
    static func startCharge(plug:PlugType)
}

class ChargeInChina:ChargeProtocol{
    static var suitablePlug: PlugType {.China}
    static func startCharge(plug:PlugType) {
        if plug ==  suitablePlug{
            print("在中国开始充电")
        }else{
            print("\(plug.rawValue)在中国充电失败")
        }
    }
}

class ChargeInAmerica:ChargeProtocol{
    static var suitablePlug: PlugType {.America}
    static func startCharge(plug:PlugType) {
        if plug == suitablePlug {
            print("在美国开始充电")
        }else{
            print("\(plug.rawValue)在美国充电失败")
        }
    }
}

class ChargeInEurope:ChargeProtocol{
    static var suitablePlug: PlugType {.Europe}
    static func startCharge(plug:PlugType) {
        if plug == suitablePlug {
            print("在欧洲开始充电")
        }else{
            print("\(plug.rawValue)在欧洲充电失败")
        }
    }
}


class ChargeAdapter{
    static func superCharge(plug: inout PlugType,chargeLocation:ChargeProtocol.Type){
        var remind : String = "使用适配器转换:\(plug.rawValue)为"
        withUnsafeMutablePointer(to: &plug) { p in
            p.pointee = chargeLocation.suitablePlug
        }
        remind += "\(plug.rawValue)"
        print(remind)
    }
}

class AdapterPattern:StartProtocol{
    class func start(){
        print("适配器模式:")
        var myPlug : PlugType = .China
        ChargeInEurope.startCharge(plug: myPlug)
        ChargeAdapter.superCharge(plug: &myPlug, chargeLocation: ChargeInEurope.self)
        ChargeInEurope.startCharge(plug: myPlug)
    }
}
