//
//  File.swift
//  YDDesignModeDemo
//
//  Created by 徐亚东 on 2023/4/13.
//

import Foundation

class Car:CustomStringConvertible{
    var brand : String
    var engine : String
    var seats : String
    var computer : String
    var wheels : String
    var autopilot : String?
    
    init() {
        self.brand = ""
        self.engine = ""
        self.seats = ""
        self.computer = ""
        self.wheels = ""
        self.autopilot = nil
    }
}

protocol Builder{
    func setBrand(_ brand:String)
    func setEngine(_ engine:String)
    func setSeats(_ seats:String)
    func setComputer(_ computer:String)
    func setWheels(_ wheels:String)
    func setAutopilot(_ autopilot:String)
    func reset();
    func getProduct()->Car
    
}

class CarBuilder:Builder{
    private var car = Car()
    
    func setBrand(_ brand: String) {
        self.car.brand = brand
    }
    func setEngine(_ engine: String) {
        self.car.engine = engine
    }
    
    func setSeats(_ seats: String) {
        self.car.seats = seats
    }
    
    func setComputer(_ computer: String) {
        self.car.computer = computer
    }
    
    func setWheels(_ wheels: String) {
        self.car.wheels = wheels
    }
    
    func setAutopilot(_ autopilot: String) {
        self.car.autopilot = autopilot
    }
    
    func reset() {
        self.car = Car()
    }
    
    func getProduct() -> Car {
        return self.car
    }
}

class Director{
    class func constructBYDCar(builder:CarBuilder){
        builder.reset()
        builder.setBrand("比亚迪汽车")
        builder.setEngine("DMI混动动力")
        builder.setSeats("舒适座椅")
        builder.setWheels("4轮")
        builder.setComputer("14英寸电脑")
        builder.setAutopilot("博世辅助驾驶")
    }
    
    class func constructHuaWeiCar(builder:CarBuilder){
        builder.reset()
        builder.setBrand("华为汽车")
        builder.setEngine("电动动力")
        builder.setSeats("零重力座椅")
        builder.setWheels("4轮")
        builder.setComputer("14英寸电脑")
        builder.setAutopilot("华为辅助驾驶")
    }
    
    class func constructOldCar(builder:CarBuilder){
        builder.reset()
        builder.setBrand("老式汽车")
        builder.setEngine("蒸汽动力")
        builder.setWheels("4轮")
    }
}



class BuilderPattern:StartProtocol{
    class func start(){
        let builder = CarBuilder()
        
        Director.constructBYDCar(builder: builder)
        let carBYD = builder.getProduct()
        
        Director.constructHuaWeiCar(builder: builder)
        let carHW = builder.getProduct()
        
        Director.constructOldCar(builder: builder)
        let carOld = builder.getProduct()
        print("建造者模式:\(carBYD),\(carHW),\(carOld)")
    }
}
