//
//  FactoryPattern.swift
//  YDDesignModeDemo
//
//  Created by 徐亚东 on 2023/4/14.
//

import Foundation

protocol Phone{
    init()
    func phoneCall(number:String)
    func phoneAnswer()
    func phoneName()
}
extension Phone{
    func phoneName(){}
}

class PhoneIphone : Phone{
    required init(){}
    func phoneCall(number:String) {
        print("苹果手机拨打电话:\(number)")
    }
    func phoneAnswer() {
        print("苹果手机接电话")
    }
}

class PhoneAndroid : Phone{
    required init(){}
    func phoneCall(number:String) {
        print("安卓手机拨打电话:\(number)")
    }
    func phoneAnswer() {
        print("安卓手机接电话")
    }
}

class PhoneFactory {
    @discardableResult
    class func createPhone<T:Phone>(phoneType:T.Type)->Phone{
        let phone = phoneType.init()
        return phone
    }
    class func testPhone(phone:Phone){
        phone.phoneCall(number: "110")
        phone.phoneAnswer()
    }
}

class FactoryPattern:StartProtocol{
    class func start(){
       print("工厂模式:")
       let phone1 = PhoneFactory.createPhone(phoneType: PhoneIphone.self)
       let phone2 = PhoneFactory.createPhone(phoneType: PhoneAndroid.self)
        PhoneFactory.testPhone(phone: phone1)
        PhoneFactory.testPhone(phone: phone2)
        print(phone1,phone2)
    }
}
