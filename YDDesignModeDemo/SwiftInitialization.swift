//
//  SwiftInitialization.swift
//  YDDesignModeDemo
//
//  Created by 徐亚东 on 2023/4/23.
//

import Foundation

struct Struct_1 {
    var name = ""
    var age : Int?
}

struct Struct_2 {
    var name = ""
    var age : Int
}

struct Struct_3 {
    var name = ""
    var age : Int
    init(delegate:Int){
        self.age = delegate
    }
}

class Class_default{
    var name : String?
    var age : Int = 10
}

class Class_1{
    var name : String?
    var age : Int?
    
    func test(){
        print("test")
    }
    convenience init(name:String){
        self.init()
        self.name = name
    }
}

class Class_2:Class_1{
    var sex : Int
    override init() {
        self.sex = 0
        super.init()
        self.name = "test"
    }
    override func test() {
        print("sub test")
    }
    convenience init(name:String){
        self.init()
        self.name = name
    }
}

class SwiftInitialization {
    class func start(){
        let temp = Class_2(name: "test")
        temp.test()
    }
}
