//
//  AbstractFactoryPattern.swift
//  YDDesignModeDemo
//
//  Created by 徐亚东 on 2023/4/14.
//

import Foundation

protocol DefaultInit{
    init()
}

protocol ABPhone:DefaultInit{
    func phoneCall(number:String)
    func phoneAnswer()
}

protocol ABPhoneFactory:DefaultInit{
    func createPhone<T:Phone>(phoneType:T.Type)->Phone
    func testPhone(phone:Phone)
}

final class ABPhoneIphone : ABPhone{

    func phoneCall(number:String) {
        print("苹果手机拨打电话:\(number)")
    }
    func phoneAnswer() {
        print("苹果手机接电话")
    }
}

final class ABPhoneAndroid : ABPhone{

    func phoneCall(number:String) {
        print("安卓手机拨打电话:\(number)")
    }
    func phoneAnswer() {
        print("安卓手机接电话")
    }
}

final class ChinaPhoneFactory : ABPhoneFactory {
    @discardableResult
    func createPhone<T:Phone>(phoneType:T.Type)->Phone{
        print("中国工厂生产")
        let phone = phoneType.init()
        return phone
    }
    func testPhone(phone:Phone){
        print("中国工厂测试")
        phone.phoneCall(number: "110")
        phone.phoneAnswer()
    }
}

final class IndianPhoneFactory : ABPhoneFactory {
    @discardableResult
    func createPhone<T:Phone>(phoneType:T.Type)->Phone{
        print("印度工厂生产")
        let phone = phoneType.init()
        return phone
    }
    func testPhone(phone:Phone){
        print("印度工厂测试")
        phone.phoneCall(number: "110")
        phone.phoneAnswer()
    }
}


class AbstractFactoryPattern:StartProtocol{
    class func start(){
        print("抽象工厂模式:")
        let facotry : ABPhoneFactory = IndianPhoneFactory()
        let phone = facotry.createPhone(phoneType: PhoneAndroid.self)
        facotry.testPhone(phone: phone)
        print("\(facotry),\(phone)")
    }
}
