//
//  DesignPatternSupport.swift
//  YDDesignModeDemo
//
//  Created by 徐亚东 on 2023/4/26.
//

import Foundation

protocol StartProtocol{
    static func start()
}

protocol DesignPatternProtocol:CaseIterable {
    func getClass() -> StartProtocol.Type?
    func start()
    static func testAll()
}
extension DesignPatternProtocol{
    static func testAll(){
        self.allCases.forEach{$0.start();print("\n")}
    }
    func getClass() -> StartProtocol.Type?{
        let strOfDesignClass = (String(reflecting: self).components(separatedBy: ".").last ?? "") + "Pattern"
        let bundleName = (Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "")
        if let upClass = Bundle.main.classNamed(bundleName + "." + strOfDesignClass) as? StartProtocol.Type{
            return upClass
        }
        return nil
    }
    
    func start() {
        self.getClass()?.start()
    }
}

enum DesignPattern {

    enum Creational:String,DesignPatternProtocol{
        case Singleton = "单例模式"
        case Prototype = "原型模式"
        case Builder = "建造者模式"
        case Factory = "工厂模式"
        case AbstractFactory = "抽象工厂模式"
    }
    
    enum Structural:String,DesignPatternProtocol,CaseIterable{
        case Adapter = "适配器模式"
        case Bridge = "桥接模式"
        case Composite = "组合模式"
        case Decorator = "装饰器模式"
        case Facade = "外观模式"
        case Flyweight = "享元模式"
        case Proxy = "代理模式"
    }
    
    enum Behavioral:String,DesignPatternProtocol,CaseIterable{
        case ChainOfResponsibility = "责任链模式"
        case Command = "命令模式"
        case Iterator = "迭代器模式"
        case Mediator = "中介者模式"
        case Memento = "备忘录模式"
        case Observer = "观察者模式"
        case State = "状态模式"
        case Strategy = "策略模式"
        case TemplateMethod = "模板模式"
        case Visitor = "访问者模式"
        case Interpreter = "解释器模式"
    }
}


extension CustomStringConvertible{
    var description : String{
        let mirror = Mirror(reflecting: self)
        let selfres = String(reflecting: mirror.subjectType)
        let res = mirror.children.map{"\($0.label ?? "") = \(String(reflecting: $0.value))"}.joined(separator: "\n")
        return [selfres,res].joined(separator: "\n")
    }
}
