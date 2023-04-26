//
//  SwiftPointer.swift
//  YDDesignModeDemo
//
//  Created by 徐亚东 on 2023/4/17.
//

import Foundation
import UIKit


class ClassA{
    var num : Int
    init(_ num:Int){
        self.num = num
    }
    deinit {
        print("\(self) num = \(self.num) dealloc")
    }
}

class ClassB{
    var propertyInt : Int = 10
    var propertyString : String = "test"
    var propertyClass : ClassA = ClassA(10)
}




struct EmptyStruct {}
/*
MemoryLayout<EmptyStruct>.size      // returns 0
MemoryLayout<EmptyStruct>.alignment // returns 1
MemoryLayout<EmptyStruct>.stride    // returns 1
*/



/*
MemoryLayout<SampleStruct>.size       // returns 5
MemoryLayout<SampleStruct>.alignment  // returns 4
MemoryLayout<SampleStruct>.stride     // returns 8
*/

class SwiftPointer {
    
    static var testPointer : UnsafeMutableRawPointer?
    
    class func start(){
        let memLayoutInt = MemoryLayout<Int>.self
        let count = 2
        let byteCount = memLayoutInt.stride * count
        
        //raw pointer(匿名指针)
        do{
            print("raw pointer")
            let pointer = UnsafeMutableRawPointer.allocate(byteCount: byteCount, alignment: memLayoutInt.alignment)
            defer {
                pointer.deallocate()
            }
            
            pointer.storeBytes(of: 100, as: Int.self)
            pointer.advanced(by: memLayoutInt.stride).storeBytes(of: 1000, as: Int.self)
            let firstInt = pointer.load(as: Int.self)
            let secondInt = pointer.load(fromByteOffset: memLayoutInt.stride, as: Int.self)
            
            print("first = \(firstInt),second = \(secondInt)")
            
            let bufferPointer = UnsafeRawBufferPointer(start: pointer, count: byteCount)
            for (index,value) in bufferPointer.enumerated(){
                print("index = \(index), value = \(value)")
            }
        }

        //type pointer(类型指针)
        do{
            print("type pointer")
            let pointer = UnsafeMutablePointer<Int>.allocate(capacity: count)
            pointer.initialize(repeating: 0, count: count)
            defer {
                pointer.deinitialize(count: count)
                pointer.deallocate()
            }
            pointer.pointee = 100
            pointer.advanced(by: 1).pointee = 1000
            
            let firstInt = pointer.pointee
            let secondInt = pointer.advanced(by: 1).pointee
            print("first = \(firstInt),second = \(secondInt)")
            
            let bufferPointer = UnsafeBufferPointer(start: pointer, count: count)
            for (index,value) in bufferPointer.enumerated(){
                print("index = \(index), value = \(value)")
            }
        }
        
        // raw pointer convert to type pointer (匿名指针转换为类型指针)
        do{
            print("Converting raw pointers to typed pointers")
            
            let rawPointer = UnsafeMutableRawPointer.allocate(byteCount: byteCount, alignment: memLayoutInt.alignment)
            let typedPointer = rawPointer.bindMemory(to: Int.self, capacity: count)
            typedPointer.initialize(repeating: 0, count: count)
            defer{
                rawPointer.deallocate()
                typedPointer.deinitialize(count: count)
            }
            
            typedPointer.pointee = 100
            typedPointer.advanced(by: 1).pointee = 1000
            
            let bufferPointer = UnsafeBufferPointer(start: typedPointer, count: count)
            for (index,value) in bufferPointer.enumerated(){
                print("index = \(index), value = \(value)")
            }
        }
        
        do{
            var int_value = 123456789
            print("Getting the pointer of an instance")
            //获取不可变指针
            withUnsafePointer(to: &int_value) { p in
                print(p,p.pointee)
            }
            print(int_value)
            
            //获取可变指针
            withUnsafeMutablePointer(to: &int_value) { mp in
                mp.pointee = 100
                print(mp,mp.pointee)
            }
            print(int_value)
            
            print("Getting the bytes of an instance")
            //获取变量的的每个字节的值
            withUnsafeBytes(of: &int_value) { bufferp in
                for (index,value) in bufferp.enumerated(){
                    print("index = \(index),value = \(value)")
                }
            }
            
        }
        
        do{
            let mPointer = UnsafeMutableRawPointer.allocate(byteCount: 4*2, alignment: 4)
            

            mPointer.storeBytes(of: 10, as: Int32.self)
//            mPointer.storeBytes(of: 20, toByteOffset: 4, as: Int32.self)
            mPointer.advanced(by: 4).storeBytes(of: 20, as: Int32.self)

            let res = mPointer.advanced(by: 4).load(as: Int32.self)
            print("res = ",res)
            
            let newTypePointer = mPointer.bindMemory(to: Int32.self, capacity: 2)
            defer{
//                mPointer.deallocate()
                newTypePointer.deallocate()
            }
            print(newTypePointer.pointee,newTypePointer.advanced(by: 1).pointee)

        }
        
        do{
            let intPointer = UnsafeMutablePointer<Int>.allocate(capacity: 4)
            defer{
                intPointer.deallocate()
            }
            for i in 0..<4 {
//                (intPointer + i).initialize(to: i)
//                intPointer.advanced(by: i).initialize(to: i)
                intPointer.advanced(by: i).pointee = i
            }
            for i in 0..<4{
                print(intPointer.advanced(by: i).pointee)
            }
        }
        
    }
    
    class func memoryLayoutIntroduce(){
//        MemoryLayout<T>.size //当是具体类型时
//        MemoryLayout.size(ofValue: instance) //当是一个实例时
        let size1 = MemoryLayout<Int>.size
        let size2 = MemoryLayout.size(ofValue: Int())
        
        //        MemoryLayout<T>.alignment //当是具体类型时
        //        MemoryLayout.alignment(ofValue: instance) //当是一个实例时
        let alignment1 = MemoryLayout<Int>.alignment
        let alignment2 = MemoryLayout.alignment(ofValue: Int())
        
//        MemoryLayout<T>.stride //当是具体类型时
//        MemoryLayout.stride(ofValue: instance) //当是一个实例时
        let stride1 = MemoryLayout<Int>.stride
        let stride2 = MemoryLayout.stride(ofValue: Int())
        
        let strideA = MemoryLayout<ClassA>.stride
        print("strideA = \(strideA)")
        
        let arrInt = [Int]()
        let arrString = [String]()
        var arrClass = [ClassA(1),ClassA(2),ClassA(3)]
        var tempClass = ClassA(10)
        
        var a = ClassA(100)
        let aPointer = withUnsafeMutablePointer(to:&a,{$0})
        print(a)
        self.testPointer = .init(aPointer)
    }
    


}

struct SampleStruct {
    var number : Int
    var flag : Bool
    mutating func headPointerOfStruct()->UnsafeMutableRawPointer{
        withUnsafeMutablePointer(to: &self){UnsafeMutableRawPointer($0)}
    }
}

func Test_Struct(){
    var temp = SampleStruct(number: 32, flag: false)
    print("raw temp = \(temp)")
    let rawPointer = temp.headPointerOfStruct()
    rawPointer.assumingMemoryBound(to: Int.self).pointee = 101
    rawPointer.advanced(by: MemoryLayout<Int>.stride).assumingMemoryBound(to: Bool.self).pointee = true
    print("new temp = \(temp)")
}

class Human{
    var age : Int?
    var name : String?
    var nicknames : [String] = [String]()
    
    func headPointerOfStruct()->UnsafeMutableRawPointer{
        var temp = self
       return withUnsafeMutablePointer(to: &temp){UnsafeMutableRawPointer($0)}
    }
    func description() -> String {
        return "age = \(self.age ?? 0) , name = \(self.name ?? "") , nicknames = \(self.nicknames)"
    }
}

func Test_Class(){
    let temp = Human()
    temp.age = 10
    temp.name = "raw name"
    temp.nicknames = ["nick_a,nick_b"]
    print(temp.description())
    
    //获取对象的基础地址
    let base_class_pointer = temp.headPointerOfStruct().assumingMemoryBound(to: UnsafeMutableRawPointer.self).pointee

    //修改age
    let type_size = 8 //类型所占8字节(64位机器上)
    let refcount_size = 8 //引用计数占8字节
    let base_age = base_class_pointer.advanced(by: type_size).advanced(by: refcount_size).assumingMemoryBound(to: Optional<Int>.self)
    base_age.pointee? = 20
    
    //修改name
    let stride_age = MemoryLayout<Optional<Int>>.stride
    let base_name = UnsafeMutableRawPointer(base_age).advanced(by: stride_age).assumingMemoryBound(to: Optional<String>.self)
    base_name.pointee? = "new name"
    
    //修改nicknames
    let stride_name = MemoryLayout<Optional<String>>.stride
    let base_nicknames = UnsafeMutableRawPointer(base_name).advanced(by: stride_name).assumingMemoryBound(to: Array<String>.self)
    let newNicknames = ["new_nick_a,new_nick_b"]
    base_nicknames.pointee = newNicknames
    
    print(temp.description())
}

class Test{
    let str : String?
    var num = 10
    init(num:Int) {
        self.num = num
        self.str = ""
    }
    deinit {
        print("deinit \(self) \(self.num)")
    }
}

func Test_unmanaged1(){
    let instance = Test(num: 10)
    
    //将对象转为Unmanaged结构。并且unmanaged_auto不负责管理对象内存。还是由系统自动管理对象内存
    let unmanaged_auto = Unmanaged.passUnretained(instance)
    
    //将对象转为Unmanaged结构。由unmanaged_no_auto管理对象内存,要想正确释放对象内存需要调用release方法
    let unmanaged_no_auto = Unmanaged.passRetained(instance)
    /*
     本质上
     let unmanaged_no_auto = Unmanaged.passRetained(instance)
     等价于
         let unmanaged_auto = Unmanaged.passUnretained(instance)
         unmanaged_auto.retain()
     所以要想unmanaged_no_auto正确管理内存，需要它调用release方法
     unmanaged_no_auto.release()
     */
    unmanaged_no_auto.release()
}

func Test_unmanaged2(){
    let instance = Test(num: 20)
    let unmanaged_auto = Unmanaged.passUnretained(instance)
    
    /*
     swift对象还是使用引用计数管理内存。当讲对象管理从自动管理移交到手动管理时候，retain,release必须成对出现
     */
    unmanaged_auto.retain()//
    unmanaged_auto.release()
}

func Test_unmanaged3(){
    let instance = Test(num: 30)
    let unmanaged_auto = Unmanaged.passUnretained(instance)
    /*
     获取对象指针,因为并没有retain操作。所以只在方法内部使用指针。否则当方法结束，对象释放后，指针会指向已回收的内存
     */
    let pointer = unmanaged_auto.toOpaque()
    print(pointer)
}

func Test_unmanaged4(){
    let instance = Test(num: 40)
    let unmanaged_auto = Unmanaged.passUnretained(instance)
    let instance_origin = unmanaged_auto.takeUnretainedValue()
    print(instance_origin)
}

func Test_unmanaged5(){
    let instance = Test(num: 50)
    
    /*自动管理内存到手动管理内存*/
    //没有破坏管理内存平衡。等价于即没有retain也没有release
    let unmanaged_auto = Unmanaged.passUnretained(instance)
    
    //破坏了管理内存平衡。此时相当于主动给unmanaged_no_auto调用了一次retain方法。
    let unmanaged_no_auto = Unmanaged.passRetained(instance)
    
    
    /*手动管理内存到自动管理内存*/
    //没有破坏管理内存平衡。等价于即没有retain也没有release
    let instance_auto = unmanaged_auto.takeUnretainedValue()
    
    //破坏了管理内存的平衡，相当于主动给unmanaged_no_auto调用了一次release方法
    let instance_no_auto = unmanaged_no_auto.takeRetainedValue()

}
