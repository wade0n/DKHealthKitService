//
//  HKStorageImp.swift
//  HKDataExport
//
//  Created by Dmitrii Kalashnikov on 10/01/2019.
//  Copyright © 2019 Dmitrii Kalashnikov. All rights reserved.
//

import Foundation
import HealthKit
import SQLite


class HKStorageImp {
  fileprivate let anchorStr = "anchor"
  
  fileprivate var db: Connection?
  let qSamples = Table("qSamples")
  let cSamples = Table("cSamples")
  let chSamples = Table("chSamples")
  let aSamples = Table("aSamples")
  let wSamples = Table("wSamples")
  
  let idC = Expression<String>("id")
  let typeC = Expression<String>("type")
  let valueC = Expression<Double>("value")
  let sourceC = Expression<String>("source")
  let unitC = Expression<String>("unit")
  let startDateC = Expression<Date>("start")
  let endDateC = Expression<Date>("end")
  let valueSC = Expression<String>("value")
  
  // activity
  let exTime = Expression<Double>("exTime")
  let standHour = Expression<Double>("standHours")
  let energyBG = Expression<Double>("energyBurned")
  let exTimeG = Expression<Double>("exTimeG")
  let standHourG = Expression<Double>("standHourG")
  
  // workout
  
  let wType = Expression<String>("workType")
  let duration = Expression<Double>("duration")
  let energyB = Expression<Double>("totalEnergyB")
  let tDistance = Expression<Double>("totalDistance")
  let tFlights = Expression <Double>("totalFlights")
  let tSwims = Expression<Double>("totalSwims")
  
  
  init() {
    let path = NSSearchPathForDirectoriesInDomains(
      .documentDirectory, .userDomainMask, true
      ).first!
    do {
      db = try Connection("\(path)/db.sqlite3")
      
      try db!.run(qSamples.create(ifNotExists: true) { t in
        t.column(idC, primaryKey: true)
        t.column(typeC, unique: false)
        t.column(valueC, unique: false)
        t.column(unitC, unique: false)
        t.column(sourceC, unique: false)
        t.column(startDateC, unique: false)
        t.column(endDateC, unique: false)
      })
      try db!.run(cSamples.create(ifNotExists: true) { t in
        t.column(idC, primaryKey: true)
        t.column(typeC, unique: false)
        t.column(valueSC, unique: false)
        t.column(sourceC, unique: false)
        t.column(startDateC, unique: false)
        t.column(endDateC, unique: false)
      })
      try db!.run(chSamples.create(ifNotExists: true) { t in
        t.column(typeC, unique: true)
        t.column(valueSC, unique: false)
      })
      try db!.run(aSamples.create(ifNotExists: true) { t in
        t.column(startDateC, unique: false)
        t.column(endDateC, unique: false)
        t.column(standHour, unique: false)
        t.column(exTime, unique: false)
        t.column(standHourG, unique: false)
        t.column(exTimeG, unique: false)
        t.column(energyBG, unique: false)
      })
      try db!.run(wSamples.create(ifNotExists: true) { t in
        t.column(idC, primaryKey: true)
        t.column(wType, unique: false)
        t.column(duration, unique: false)
        t.column(tDistance, unique: false)
        t.column(tFlights, unique: false)
        t.column(energyB, unique: false)
        t.column(tSwims, unique: false)
        t.column(startDateC, unique: true)
        t.column(endDateC, unique: true)
      })
      
    } catch {
      print("db error open")
      db = nil
    }
  }
  
}

extension HKStorageImp: HKStorage {
  func saveWorkoutDate(date: Date) {
    let filename = "workoutDate"
    let data = NSKeyedArchiver.archivedData(withRootObject: date)
    UserDefaults.standard.set(data, forKey: filename)
  }
  
  func saveActivityDate(date: Date) {
    let filename = "activityDate"
    let data = NSKeyedArchiver.archivedData(withRootObject: date)
    UserDefaults.standard.set(data, forKey: filename)
  }
  
  func getWorkoutDate() -> Date? {
    let filename = "workoutDate"
    
    if let data = UserDefaults.standard.value(forKey: filename) {
      return NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? Date
    }
    return nil
  }
  
  func getActivityDate() -> Date? {
    let filename = "activityDate"
    if let data = UserDefaults.standard.value(forKey: filename) {
      return NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? Date
    }
    return nil
  }
  
  func getCharacteristicSamples(completion: @escaping (Bool, [(String , String)], Error?) -> Swift.Void) {
    do {
      let results = Array(try db!.prepare(chSamples.select( typeC, valueSC)))
      let tuples = results.compactMap { (row) -> (String, String) in
        return (row[typeC], row[valueSC])
      }
      completion(true, tuples, nil)
    } catch let error {
      completion(false, [],error)
    }
  }
  
  
  func getQuantitySamples(type: HKQuantityType ,completion: @escaping (Bool, [(Date, Double, String)], Error?) -> Swift.Void) {
    do {
      let results = Array(try db!.prepare(qSamples.select(endDateC, valueC, unitC)
        .filter(typeC == "\(type)")
        .order(endDateC.desc)))
      let tuples = results.compactMap { (row) -> (Date, Double, String) in
        return (row[endDateC], row[valueC], row[unitC])
      }
      completion(true, tuples, nil)
    } catch let error {
      completion(false, [], error)
    }
  }
  
  func getWorkoutSamples(completion: @escaping (Bool, [(Date , String)], Error?) -> Swift.Void) {
    do {
      let results = Array(try db!.prepare(wSamples.select(startDateC, tDistance)
        .order(startDateC.desc)))
      let tuples = results.map { (row) -> (Date, String) in
        return (row[startDateC], "\(row[tDistance])")
      }
      completion(true, tuples, nil)
    } catch let error {
      completion(false, [] , error)
    }
  }
  
  func getActivitySamples(completion: @escaping (Bool, [(Date , String)], Error?) -> Swift.Void) {
    do {
      let results = Array(try db!.prepare(aSamples.select(startDateC, exTime)
        .order(startDateC.desc)))
      let tuples = results.map { (row) -> (Date, String) in
        return (row[startDateC], "\(row[exTime])")
      }
      completion(true, tuples, nil)
    } catch let error {
      completion(false, [] , error)
    }
  }
  
  func getCategorySamples(type: HKCategoryType ,completion: @escaping (Bool, [(Date, String)], Error?) -> Swift.Void) {
    do {
      let results = Array(try db!.prepare(cSamples.select(endDateC, valueSC)
        .filter(typeC == "\(type)")
        .order(endDateC.desc)))
      let tuples = results.map { (row) -> (Date, String) in
        return (row[endDateC], row[valueSC])
      }
      completion(true, tuples, nil)
    } catch let error {
      completion(false, [],error)
    }
  }
  
  
  
  func  saveCharacteristicSample(type: String, value: String, completion: @escaping (Bool, Error?) -> Swift.Void) {
    do {
      try db!.run(chSamples.insert(
        typeC <- type,
        valueSC <-  value
      ))
    } catch let error {
      completion(false, error)
    }
    completion(true, nil)
  }
  
  func saveCategorySamples(samples: [HKCategorySample], values: [String], completion: @escaping (Bool, Error?) -> Swift.Void) {
    do {
      try db!.transaction {
        for sample in samples {
          try db!.run( cSamples.insert(
            idC <- "\(sample.uuid)",
            typeC <- "\(sample.categoryType)",
            valueSC <- "\(values[sample.value])",
            sourceC <- sample.sourceRevision.source.name,
            startDateC <- sample.startDate,
            endDateC <- sample.endDate
          ))
        }
      }
    } catch let error  {
      completion(false, error)
      return
    }
    completion(true, nil)
  }
  
  func saveWorkoutSamples(samples: [HKWorkout], completion: @escaping (Bool, Error?) -> Swift.Void) {
    do {
      try db!.transaction {
        for sample in samples {
          try db!.run( wSamples.insert(
            idC <- "\(sample.uuid)",
            wType <- "\(sample.workoutActivityType.rawValue)",
            tDistance <- (sample.totalDistance?.doubleValue(for: HKUnit.meter())) ?? 0,
            duration <- sample.duration,
            tFlights <- (sample.totalFlightsClimbed?.doubleValue(for: HKUnit.count())) ?? 0,
            energyB <- (sample.totalEnergyBurned?.doubleValue(for: HKUnit.kilocalorie())) ?? 0,
            tSwims <- (sample.totalSwimmingStrokeCount?.doubleValue(for: HKUnit.count())) ?? 0,
            startDateC <- sample.startDate,
            endDateC <- sample.endDate
          ))
        }
      }
    } catch let error  {
      completion(false, error)
      return
    }
    completion(true, nil)
  }
  
  func saveActivitySamples(samples: [HKActivitySummary], completion: @escaping (Bool, Error?) -> Swift.Void) {
    do {
      try db!.transaction {
        for sample in samples {
          try db!.run( aSamples.insert(
            startDateC <- sample.dateComponents(for: Calendar.current).date!,
            endDateC <- sample.dateComponents(for: Calendar.current).date!,
            standHour <- sample.appleStandHours.doubleValue(for: HKUnit.count()),
            exTime <- sample.appleStandHours.doubleValue(for: HKUnit.count()),
            energyBG <- sample.activeEnergyBurned.doubleValue(for: HKUnit.kilocalorie()),
            standHourG <- sample.appleStandHoursGoal.doubleValue(for: HKUnit.percent()),
            exTimeG <- sample.appleExerciseTimeGoal.doubleValue(for: HKUnit.minute())
          ))
        }
      }
    } catch let error {
      completion(false, error)
    }
    completion(true, nil)
  }
  
  func saveQuantitySamples(samples: [HKQuantitySample], unit: HKUnit,completion: @escaping (Bool, Error?) -> Swift.Void) {
    print(samples.first?.quantityType)
    print(unit)
    
    do {
      try db!.transaction {
        for sample in samples {
          
          try db!.run( qSamples.insert(
            idC <- "\(sample.uuid)",
            typeC <- "\(sample.quantityType)",
            valueC <- sample.quantity.doubleValue(for: unit),
            unitC <- unit.unitString,
            sourceC <- sample.sourceRevision.source.name,
            startDateC <- sample.startDate,
            endDateC <- sample.endDate
          ))
        }
      }
    } catch let error  {
      completion(false, error)
      return
    }
    completion(true, nil)
  }
  
  func saveAnchor(anchor: HKQueryAnchor, forType: String) {
    let filename = forType + anchorStr
    let data = NSKeyedArchiver.archivedData(withRootObject: anchor)
    UserDefaults.standard.set(data, forKey: filename)
  }
  
  func getAnchor(type: String) -> HKQueryAnchor? {
    let filename = type + anchorStr
    
    if let data = UserDefaults.standard.value(forKey: filename) {
      return NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? HKQueryAnchor
    }
    return nil
  }
  
  func getCountForCharacteristicType(_ type: String) -> Int {
    do {
      return try db!.scalar(cSamples.filter(typeC == "\(type)").count)
    } catch {
      return 0
    }
    
  }
  
  func getCountForQuantityType(_ type: String) -> Int {
    do {
      return try db!.scalar(qSamples.filter(typeC == "\(type)").count)
    } catch {
      return 0
    }
  }
  
  func getCountForWorkoutType() -> Int {
    do {
      return try db!.scalar(wSamples.count)
    } catch {
      return 0
    }
  }
  
  func getCountforActivityType() -> Int {
    do {
      return try db!.scalar(aSamples.count)
    } catch {
      return 0
    }
  }
}

