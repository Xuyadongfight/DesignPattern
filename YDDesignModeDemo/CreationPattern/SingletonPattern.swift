//
//  File.swift
//  YDDesignModeDemo
//
//  Created by 徐亚东 on 2023/4/13.
//

import Foundation

/*
// 饿汉式创建
class SingletonPattern{
    static let _share = SingletonPattern()
    public class func shared()->(SingletonPattern){
        return _share
    }
}
*/

/*
// 懒汉式创建 version-1
class SingletonPattern{
    static var _share : SingletonPattern?
    public class func shared()->(SingletonPattern){
        if _share == nil {//高并发多线程环境下，这里可能存在创建单例的过程中，下一个线程判断此处还是空
            _share = SingletonPattern()
        }
        return _share ?? SingletonPattern()
    }
}
*/

/*
// 懒汉式创建 version-2
class SingletonPattern{
    static var _share : SingletonPattern?
    static let lock = NSLock()
    public class func shared()->(SingletonPattern){
        lock.lock()//加锁解决了多线程的互斥访问，但是每次使用单例都要进行加锁解锁影响性能
        if _share == nil {
            _share = SingletonPattern()
        }
        lock.unlock()
        return _share ?? SingletonPattern()
    }
}
*/

// 懒汉式创建 version-3
class SingletonPattern:StartProtocol{
    
    static var _share : SingletonPattern?
    static let lock = NSLock()
    public class func shared()->(SingletonPattern){
        if _share == nil{//优化双层if只有第一次为空时候会加锁进行互斥访问。
            lock.lock()
            if _share == nil {
                _share = SingletonPattern()
            }
            lock.unlock()
        }
        return _share ?? SingletonPattern()
    }
    static func start() {
        let temp = self.shared()
        print("单例模式:",temp)
    }
}
