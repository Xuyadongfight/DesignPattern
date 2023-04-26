//
//  FactoryModel.swift
//  YDDesignModeDemo
//
//  Created by 徐亚东 on 2022/10/21.
//

import Foundation

protocol Sender {
    func send()
}

protocol Provider{
    func produce()->Sender
}



class MsgSenderFactory:Provider{
    func produce()->Sender {
        return MsgSender()
    }
}

class MailSenderFactory:Provider{
    func produce() -> Sender {
        return MailSender()
    }
}


class MsgSender:Sender{
    func send() {
        print("msg send")
    }
}
class MailSender:Sender{
    func send() {
        print("mail send")
    }
}

class SendFactory{
/*
    //普通简单工厂
  func produce(type:String?)->Sender?{
     guard let upType = type else {
         return nil
     }
     if upType == "msg" {
         return MsgSender()
     }else if upType == "mail"{
         return MailSender()
     }
     print("error type")
     return nil
 }
     //使用及问题: 依赖字符串硬编码，如果传递的字符串出错，则不能正确创建对象。
     /*
     let factory = SendFactory()
     let sender = factory.produce(type: "mail")
     sender?.send()
     */
 */
    
/*
    //多个方法简单工厂
     func produceMsg()->Sender{
         return MsgSender()
     }
     func produceMail()->Sender{
         return MailSender()
     }
     //使用及问题: 解决了字符串硬编码的问题。但是需要先创建工厂类的实例。
     /*
      let factory = SendFactory()
      let sender = factory.produceMail()
      sender.send()
      */
 
 */
    
    //静态方法简单工厂 不需要实例化工厂类
    static func produceMsg()->Sender{
        return MsgSender()
    }
    static func produceMail()->Sender{
        return MailSender()
    }
    //使用 凡是出现了大量的产品需要创建，并且具有共同的接口时，可以通过工厂方法模式进行创建。大多数情况下采用第三种。静态工厂方法模式
    /*
     let sender = SendFactory.produceMail()
     sender.send()
     */
    //装饰器模式 桥接模式 享元模式  组合模式 外观模式 适配器模式 代理模式
}

