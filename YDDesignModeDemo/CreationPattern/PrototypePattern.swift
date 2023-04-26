//
//  File.swift
//  YDDesignModeDemo
//
//  Created by 徐亚东 on 2023/4/13.
//

import Foundation

class PrototypePattern:StartProtocol,CustomStringConvertible{
    var x : Int = 16
    init() {
        //模仿初始化时候需要的耗时操作
        sleep(1)
    }
    func copy() -> PrototypePattern {
        let pointer_self = Unmanaged.passUnretained(self).toOpaque()
        
        let pointer_new = UnsafeMutableRawPointer.allocate(byteCount: 32, alignment: 8)
        pointer_new.copyMemory(from: pointer_self, byteCount: 32)
        
        let unmanaged = Unmanaged<PrototypePattern>.fromOpaque(pointer_new)
        let managedValue = unmanaged.takeRetainedValue()
        return managedValue
    }
    deinit {
        print("deinit:\(self.x)")
    }
    
    static func start() {
        let temp = PrototypePattern()
        let newTemp = temp.copy()
        newTemp.x = 100
        print("原型模式:\(temp),\(newTemp)")
    }
}
