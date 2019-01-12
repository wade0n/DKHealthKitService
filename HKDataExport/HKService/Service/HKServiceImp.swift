//
//  HKServiceImp.swift
//  HKDataExport
//
//  Created by Dmitrii Kalashnikov on 10/01/2019.
//  Copyright © 2019 Dmitrii Kalashnikov. All rights reserved.
//

import Foundation
import HealthKit

enum HKServiceError: Error {
  case AuthorizationDenied(String)
  case serviceIsNil
}


let dateOfBirth = HKObjectType.characteristicType(forIdentifier: .dateOfBirth)! // req | get
let bloodType = HKObjectType.characteristicType(forIdentifier: .bloodType)! // req | get
let biologicalSex = HKObjectType.characteristicType(forIdentifier: .biologicalSex)! // req | get
let skinType = HKObjectType.characteristicType(forIdentifier: .fitzpatrickSkinType)! // req | get
let activity = HKObjectType.activitySummaryType()

let pressureS = HKObjectType.quantityType(forIdentifier: .bloodPressureSystolic)!
let pressureD = HKObjectType.quantityType(forIdentifier: .bloodPressureDiastolic)!
let heartRate = HKObjectType.quantityType(forIdentifier: .heartRate)! // req | get
let bodyTemperature = HKObjectType.quantityType(forIdentifier: .bodyTemperature)! //req | get
let respiratoryRate = HKObjectType.quantityType(forIdentifier: .respiratoryRate)! // req | get
let bodyMassIndex = HKObjectType.quantityType(forIdentifier: .bodyMassIndex)! //req | get
let height = HKObjectType.quantityType(forIdentifier: .height)! //req | get
let bodyMass = HKObjectType.quantityType(forIdentifier: .bodyMass)! //req | get
let leanBodyMass = HKObjectType.quantityType(forIdentifier: .leanBodyMass)! //req | get
let bodyFatPercentage = HKObjectType.quantityType(forIdentifier: .bodyFatPercentage)! // req | get
let exersizeTime = HKObjectType.quantityType(forIdentifier: .appleExerciseTime)! // req | get
let standHour = HKObjectType.categoryType(forIdentifier: .appleStandHour)!
let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount)! // req | get
let distanceCycling = HKObjectType.quantityType(forIdentifier: .distanceCycling)! // req | get
let distanceWalk = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)! // req | get
let distanceWheelchair = HKObjectType.quantityType(forIdentifier: .distanceWheelchair)! // req | get
let distanceSwimming = HKObjectType.quantityType(forIdentifier: .distanceSwimming)! // req | get
let basalEnergyBurned = HKObjectType.quantityType(forIdentifier: .basalEnergyBurned)! // req | get
let activeEnergyBurned = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)! // req | get
let flightsClimbed = HKObjectType.quantityType(forIdentifier: .flightsClimbed)! // req | get
let nikeFuel = HKObjectType.quantityType(forIdentifier: .nikeFuel)!
let workout = HKObjectType.workoutType()

// food
let protein = HKObjectType.quantityType(forIdentifier: .dietaryProtein)! // req | get
let vitaminsA = HKObjectType.quantityType(forIdentifier: .dietaryVitaminA)! // req | get
let vitaminsB6 = HKObjectType.quantityType(forIdentifier: .dietaryVitaminB6)! // req | get
let vitaminsB12 = HKObjectType.quantityType(forIdentifier: .dietaryVitaminB12)! // req | get
let vitaminsC = HKObjectType.quantityType(forIdentifier: .dietaryVitaminC)! // req | get
let vitaminsD = HKObjectType.quantityType(forIdentifier: .dietaryVitaminD)! // req | get
let vitaminsK = HKObjectType.quantityType(forIdentifier: .dietaryVitaminK)! // req | get
let vitaminsE = HKObjectType.quantityType(forIdentifier: .dietaryVitaminE)! // req | get
let water = HKObjectType.quantityType(forIdentifier: .dietaryWater)!
let fatIn = HKObjectType.quantityType(forIdentifier: .dietaryFatTotal)!
let iron = HKObjectType.quantityType(forIdentifier: .dietaryIron)!
let iodine = HKObjectType.quantityType(forIdentifier: .dietaryIodine)!
let potassium = HKObjectType.quantityType(forIdentifier: .dietaryPotassium)!
let calcium = HKObjectType.quantityType(forIdentifier: .dietaryCalcium)!
let fiber = HKObjectType.quantityType(forIdentifier: .dietaryFiber)!
let caffein = HKObjectType.quantityType(forIdentifier: .dietaryCaffeine)!
let magnesium = HKObjectType.quantityType(forIdentifier: .dietaryMagnesium)!
let manganese = HKObjectType.quantityType(forIdentifier: .dietaryManganese)!
let copper = HKObjectType.quantityType(forIdentifier: .dietaryCopper)!
let molibdenum = HKObjectType.quantityType(forIdentifier: .dietaryMolybdenum)!
let monofats = HKObjectType.quantityType(forIdentifier: .dietaryFatMonounsaturated)!
let saturatedfats = HKObjectType.quantityType(forIdentifier: .dietaryFatSaturated)!
let sodium = HKObjectType.quantityType(forIdentifier: .dietarySodium)!
let nikotin = HKObjectType.quantityType(forIdentifier: .dietaryNiacin)!
let pantocid = HKObjectType.quantityType(forIdentifier: .dietaryPantothenicAcid)!
let polifat = HKObjectType.quantityType(forIdentifier: .dietaryFatPolyunsaturated)!
let riboflavin = HKObjectType.quantityType(forIdentifier: .dietaryRiboflavin)!
let sugar = HKObjectType.quantityType(forIdentifier: .dietarySugar)!
let selenium = HKObjectType.quantityType(forIdentifier: .dietarySelenium)!
let carbs = HKObjectType.quantityType(forIdentifier: .dietaryCarbohydrates)!
let folat = HKObjectType.quantityType(forIdentifier: .dietaryFolate)!
let phoshor = HKObjectType.quantityType(forIdentifier: .dietaryPhosphorus)!
let cloride = HKObjectType.quantityType(forIdentifier: .dietaryChloride)!
let chlororestertine = HKObjectType.quantityType(forIdentifier: .dietaryCholesterol)!
let chrome = HKObjectType.quantityType(forIdentifier: .dietaryChromium)!
let zinc = HKObjectType.quantityType(forIdentifier: .dietaryZinc)!
let energy = HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed)!

let sleep = HKObjectType.categoryType(forIdentifier: .sleepAnalysis)! // ?

let basalTemp = HKObjectType.quantityType(forIdentifier: .basalBodyTemperature)!
let bleedings = HKObjectType.categoryType(forIdentifier: .intermenstrualBleeding)!
let menstrual = HKObjectType.categoryType(forIdentifier: .menstrualFlow)!
let ouvalation = HKObjectType.categoryType(forIdentifier: .ovulationTestResult)!
let sexactive = HKObjectType.categoryType(forIdentifier: .sexualActivity)!
let cervical = HKObjectType.categoryType(forIdentifier: .cervicalMucusQuality)!

let alckohol = HKObjectType.quantityType(forIdentifier: .bloodAlcoholContent)!
let glucose = HKObjectType.quantityType(forIdentifier: .bloodGlucose)!
let inhalerUse = HKObjectType.quantityType(forIdentifier: .inhalerUsage)!
let falls = HKObjectType.quantityType(forIdentifier: .numberOfTimesFallen)!
let oxygen = HKObjectType.quantityType(forIdentifier: .oxygenSaturation)!
let breathvolume = HKObjectType.quantityType(forIdentifier: .forcedExpiratoryVolume1)!
let peripheralP = HKObjectType.quantityType(forIdentifier: .peakExpiratoryFlowRate)!
let ufIndecs = HKObjectType.quantityType(forIdentifier: .uvExposure)!
let forcevitak = HKObjectType.quantityType(forIdentifier: .forcedVitalCapacity)!
let electroderma = HKObjectType.quantityType(forIdentifier: .electrodermalActivity)!


class HKServiceImp {
  let repository: HKRepository = HKRepositoryImp()
  let storage: HKStorage = HKStorageImp()
  let semaphore = DispatchSemaphore.init(value: 1)
  let queue = OperationQueue.init() // just one queue
  
  let categoryTuples: [(HKCategoryType ,  [String])]!
  let quantityTuples: [(HKQuantityType, HKUnit)]!
  
  var progressV: Float = 0.0
  var userDate = Date()
  
  static let shared = HKServiceImp()
  
  
  private init() {
    
    queue.maxConcurrentOperationCount = 4
    categoryTuples = [(sleep , ["inbed","asleep",
                                "awake"]),
                      (bleedings , ["Bleeding"]),
                      (menstrual, ["undefined","unspecified","unspecified", "light", "medium", "heavy"]),
                      (ouvalation,["undefined","negative",
                                   "positive",
                                   "indeterminate"]),
                      (sexactive, ["undefined","protection used",
                                   "protection not used", "unspecified"]),
                      (standHour, ["undefined","stood", "idle"]),
                      (cervical,["undefined",
                                 "dry",
                                 "sticky",
                                 "creamy",
                                 "watery","eggWhite"
                        ])
    ]
    
    quantityTuples = [(heartRate , HKUnit.count().unitDivided(by: HKUnit.minute())),
                      (bodyTemperature, HKUnit.degreeCelsius()),
                      (respiratoryRate, HKUnit.count().unitDivided(by: HKUnit.minute())),
                      (bodyMassIndex, HKUnit.count()),
                      (height, HKUnit.meter()),
                      (bodyMass, HKUnit.gram()),
                      (leanBodyMass, HKUnit.gram()),
                      (bodyFatPercentage, HKUnit.percent()),
                      (exersizeTime, HKUnit.minute()),
                      (stepCount, HKUnit.count()),
                      (distanceWalk, HKUnit.meter()),
                      (distanceCycling, HKUnit.meter()),
                      (distanceSwimming, HKUnit.meter()),
                      (distanceWheelchair, HKUnit.meter()),
                      (basalEnergyBurned, HKUnit.kilocalorie()),
                      (activeEnergyBurned, HKUnit.kilocalorie()),
                      (flightsClimbed, HKUnit.count()),
                      (protein, HKUnit.gram()),
                      (vitaminsA, HKUnit.gram()),
                      (vitaminsB6, HKUnit.gram()),
                      (vitaminsB12, HKUnit.gram()),
                      (vitaminsC, HKUnit.gram()),
                      (vitaminsD, HKUnit.gram()),
                      (vitaminsE, HKUnit.gram()),
                      (vitaminsK, HKUnit.gram()),
                      (water, HKUnit.liter()),
                      (fatIn, HKUnit.gram()),
                      (iron, HKUnit.gram()),
                      (iodine, HKUnit.gram()),
                      (potassium, HKUnit.gram()),
                      (calcium, HKUnit.gram()),
                      (fiber, HKUnit.gram()),
                      (caffein, HKUnit.gram()),
                      (magnesium, HKUnit.gram()),
                      (manganese, HKUnit.gram()),
                      (copper, HKUnit.gram()),
                      (molibdenum, HKUnit.gram()),
                      (monofats, HKUnit.gram()),
                      (saturatedfats, HKUnit.gram()),
                      (sodium, HKUnit.gram()),
                      (nikotin, HKUnit.gram()),
                      (pantocid, HKUnit.gram()),
                      (polifat, HKUnit.gram()),
                      (riboflavin, HKUnit.gram()),
                      (sugar, HKUnit.gram()),
                      (selenium, HKUnit.gram()),
                      (carbs, HKUnit.gram()),
                      (folat, HKUnit.gram()),
                      (phoshor, HKUnit.gram()),
                      (cloride, HKUnit.gram()),
                      (chlororestertine, HKUnit.gram()),
                      (chrome, HKUnit.gram()),
                      (zinc, HKUnit.gram()),
                      (energy, HKUnit.kilocalorie()),
                      (basalEnergyBurned, HKUnit.kilocalorie()),
                      (alckohol, HKUnit.percent()),
                      (glucose, HKUnit.gram().unitDivided(by: HKUnit.liter())),
                      (inhalerUse, HKUnit.count()),
                      (falls, HKUnit.count()),
                      (oxygen, HKUnit.percent()),
                      (breathvolume, HKUnit.liter()),
                      (peripheralP, HKUnit.liter().unitDivided(by: HKUnit.minute())),
                      (ufIndecs, HKUnit.count()),
                      (forcevitak, HKUnit.liter()),
                      (electroderma, HKUnit.siemen()),
    ]
  }
  
  fileprivate func getReadTypes() -> Set<HKObjectType>{
    return [dateOfBirth,
            bloodType,
            biologicalSex,
            skinType,
            bodyMassIndex,
            bodyMass,
            heartRate,
            bodyTemperature,
            respiratoryRate,
            leanBodyMass,
            bodyMass,
            bodyMassIndex,
            bodyFatPercentage,
            height,
            activity,
            distanceCycling,
            distanceWalk,
            exersizeTime,
            flightsClimbed,
            stepCount,
            activeEnergyBurned,
            basalEnergyBurned,
            HKObjectType.workoutType(),
            protein,
            vitaminsA,
            vitaminsB6,
            vitaminsB12,
            vitaminsC,
            vitaminsD,
            vitaminsE,
            vitaminsK,
            water,
            fatIn,
            iron,
            iodine,
            potassium,
            calcium,
            fiber,
            caffein,
            magnesium,
            manganese,
            copper,
            molibdenum,
            monofats,
            saturatedfats,
            sodium,
            nikotin,
            pantocid,
            polifat,
            riboflavin,
            sugar,
            selenium,
            carbs,
            folat,
            phoshor,
            cloride,
            chlororestertine,
            chrome,
            zinc,
            energy,
            sleep,
            basalTemp,
            bleedings,
            menstrual,
            ouvalation,
            sexactive,
            cervical,
            alckohol,
            glucose,
            inhalerUse,
            falls,
            oxygen,
            breathvolume,
            peripheralP,
            ufIndecs,
            forcevitak,
            electroderma,
            workout
    ]
  }
  
  fileprivate func getWriteTypes() -> Set<HKSampleType> {
    return []
  }
  
  fileprivate func checkProgress(type: HKObjectType) {
    switch type {
    case stepCount, heartRate, distanceWalk, activeEnergyBurned, basalEnergyBurned, flightsClimbed:
      progressV += 4
    case bodyMass, height, flightsClimbed, exersizeTime, activity, workout:
      progressV += 2
    default:
      progressV += 1
    }
  }
  
  fileprivate func getAnchor(type: HKObjectType) -> HKQueryAnchor? {
    let typeStr = "\(type)"
    return storage.getAnchor(type: typeStr)
  }
  
  fileprivate func saveAnchor(type: HKObjectType, anchor: HKQueryAnchor) {
    let typeStr = "\(type)"
    storage.saveAnchor(anchor: anchor, forType: typeStr)
  }
  
  fileprivate func checkFinishSync( value: Float, completion: @escaping (Bool, Error?) -> Swift.Void) {
    if (value >= 99) {
      completion(true, nil)
    }
  }
  
  fileprivate func getCategorySamples(type: HKCategoryType, values: [String], completion: @escaping (Bool, Int,Error?) -> Swift.Void) {
    let anchor = storage.getAnchor(type: "\(type)")
    repository.getCategorySamples(type: type, anchor: anchor) {[weak self] (tuple, error) in
      if let hkError = error {
        completion(false, 0,hkError)
        return
      }
      guard let sSelf = self else {
        return
      }
      sSelf.checkProgress(type: type)
      
      //completion(error == nil, tuple.added.count, error)
      sSelf.storage.saveCategorySamples(samples: tuple.added, values: values, completion: { (success, error) in
        if let sAnchor = tuple.newAnchor{
          sSelf.storage.saveAnchor(anchor: sAnchor, forType: "\(type)")
        }
        
        completion(success, tuple.added.count,error)
      })
    }
  }
  
  
  fileprivate func getQuantitySamples(type: HKQuantityType, unit: HKUnit, completion: @escaping (Bool, Int,Error?) -> Swift.Void) {
    let anchor = storage.getAnchor(type: "\(type)")
    
    repository.getQuantitySamples(type: type, anchor: anchor) { [weak self] (tuple, error) in
      if let hkError = error {
        completion(false, 0,hkError)
        
        return
      }
      guard let sSelf = self else {
        completion(false, 0, nil)
        return
      }
      
      sSelf.checkProgress(type: type)
      if tuple.added.isEmpty {
        completion(error == nil, tuple.added.count,error)
        return
      }
      
      
      //completion(error == nil, tuple.added.count,error)
      sSelf.storage.saveQuantitySamples(samples: tuple.added, unit: unit, completion: { (success, error) in
        completion(success, tuple.added.count,error)
        if let sAnchor = tuple.newAnchor{
          sSelf.storage.saveAnchor(anchor: sAnchor, forType: "\(type)")
        }
      })
    }
  }
  
}

extension HKServiceImp: HKService {
  
  func getCountType(_ type: HKObjectType) -> Int {
    if let _: HKCategoryType = type as? HKCategoryType {
      return storage.getCountForCharacteristicType("\(type)")
    } else if let _: HKQuantityType = type as? HKQuantityType {
      return storage.getCountForQuantityType("\(type)")
    } else if let _: HKWorkoutType = type as? HKWorkoutType {
      return storage.getCountForWorkoutType()
    } else if let _: HKActivitySummaryType = type as? HKActivitySummaryType {
      return storage.getCountforActivityType()
    } else {
      return 0
    }
  }
  
  func getCountForTypes(_ types: [HKObjectType]) -> Int {
    var result = 0
    for type in types {
      result += self.getCountType(type)
    }
    
    return result
  }
  
  func getUserData(completion: @escaping ([(type: String, value: String)],Error?) -> Swift.Void) {
    storage.getCharacteristicSamples { (success, tuple, error) in
      completion(tuple, error)
    }
  }
  
  func getSamplesForType(type: HKObjectType, completion: @escaping ([(date: String, value: String)],Error?) -> Swift.Void) {
    if let cT: HKCategoryType = type as? HKCategoryType {
      storage.getCategorySamples(type: cT) { (success, results, error) in
        if (success) {
          let tuple = results.map({ (tuple) -> (String,String) in
            return ("\(tuple.0)", tuple.1)
          })
          completion(tuple, error)
        }
      }
    } else if let qt: HKQuantityType = type as? HKQuantityType {
      storage.getQuantitySamples(type: qt) { (success, results, error) in
        if (success) {
          let tuples = results.map({ (tuple) -> (String, String) in
            return ("\(tuple.0)", "\(tuple.1)"+" "+tuple.2)
          })
          completion(tuples, error)
        }
      }
    } else if let _: HKWorkoutType = type as? HKWorkoutType {
      storage.getWorkoutSamples { (success, results, error) in
        if (success) {
          let tuples = results.map({ (tuple) -> (String, String) in
            return ("\(tuple.0)", "\(tuple.1) m")
          })
          completion(tuples, error)
        }
      }
    } else if let _: HKActivitySummaryType = type as? HKActivitySummaryType {
      storage.getActivitySamples { (success, results, error) in
        if (success) {
          let tuples = results.map({ (tuple) -> (String, String) in
            return ("\(tuple.0)", "\(tuple.1) min")
          })
          completion(tuples, error)
        }
      }
    } else {
      completion([("","")], HKServiceError.AuthorizationDenied("Not working"))
    }
  }
  
  func startSynchronization(progress: @escaping (Float, String) -> Swift.Void,completion: @escaping (Bool, Error?) -> Swift.Void){
    
    self.progressV = 0.0
    
    self.storage.getQuantitySamples(type: heartRate) { (success, array, error) in
      
    }
    
    self.requestAuthorization {[weak self] (success, error) in
      guard let selfC = self else {
        completion(false, HKServiceError.serviceIsNil)
        return
      }
      
      if (success) {
        progress(0.0, "Get Authorization")
        selfC.repository.getBirthDay(completion: { (date, error) in
          if let dateC = date {
            selfC.userDate = dateC
            //progress(1.5,"Get user date \(self.userDate)")
          }
          selfC.checkProgress(type: dateOfBirth)
          progress(selfC.progressV,"Get user date \(selfC.userDate)")
          selfC.storage.saveCharacteristicSample(type: "dateOfBirth", value: "\(String(describing: date))", completion: { (success, error) in
          })
        })
        
        selfC.repository.getSex(completion: { (sex, error) in
          selfC.checkProgress(type: biologicalSex)
          if let s = sex {
            progress(selfC.progressV,"Get user sex \(s)")
            let values = ["not set","female","male","other"]
            selfC.storage.saveCharacteristicSample(type: "sex", value: "\(values[s.rawValue])", completion: { (success, error) in
            })
          }
          
        })
        
        selfC.repository.getBloodType(completion: { (blood, error) in
          selfC.checkProgress(type: bloodType)
          if let b = blood {
            progress(selfC.progressV,"Get user blood \(b)")
            
            var values = ["notset", "aPositive" , "aNegative" ,"bPositive" , "bNegative" ,"abPositive" ,"abNegative" ,"oPositive", "oNegative"]
            
            selfC.storage.saveCharacteristicSample(type: "\(bloodType)", value: "\(values[b.rawValue])", completion: { (success, error) in
            })
          }
        })
        
        selfC.repository.getSkinType(completion: { (skin, error) in
          selfC.checkProgress(type: skinType)
          if let s = skin {
            progress(selfC.progressV,"Get user skin \(s)")
            let values = ["notset","1","2","3","4", "5", "6"]
            selfC.storage.saveCharacteristicSample(type: "\(skinType)", value: "\(values[s.rawValue])", completion: { (success, error) in
            })
          }
        })
        
        DispatchQueue.global(qos: .userInitiated).async {
          
          selfC.queue.addOperation {
            selfC.repository.getWorkoutSamples(lastSynceDate: selfC.storage.getWorkoutDate(), completion: { (results, error) in
              if (error == nil) {
                selfC.storage.saveWorkoutSamples(samples: results, completion: { (success, error) in
                  if (error == nil)
                  {
                    selfC.storage.saveWorkoutDate(date: Date())
                    progress(selfC.progressV, "added \(results.count) workout")
                  }
                })
              } else {
                progress(selfC.progressV, "added \(results.count) activities")
              }
            })
          }
          
          selfC.queue.addOperation {
            selfC.repository.getActivities(lastSynceDate: selfC.storage.getActivityDate() ,completion: { (activities, error) in
              selfC.checkProgress(type: activity)
              if (error == nil) {
                selfC.storage.saveActivitySamples(samples: activities, completion: { (success, error) in
                  selfC.storage.saveActivityDate(date: Date())
                  progress(selfC.progressV, "added \(activities.count) activities")
                })
              } else {
                progress(selfC.progressV, "added \(activities.count) activities")
              }
            })
          }
          
          
          for tuple in selfC.categoryTuples {
            
            selfC.queue.addOperation {
              selfC.getCategorySamples(type: tuple.0, values: tuple.1, completion: { (success, amount, error) in
                let message = success ? "added \(amount) \(tuple.0)" : "error: \(String(describing: error)) \(tuple.1)"
                progress(selfC.progressV, message)
                selfC.checkFinishSync(value: selfC.progressV, completion: completion)
              })
            }
          }
          
          
          for tuple in selfC.quantityTuples {
            
            selfC.queue.addOperation {
              selfC.getQuantitySamples(type: tuple.0, unit: tuple.1, completion: { (success, amount, error) in
                let message = success ? "added \(amount) \(tuple.0)" : "error: \(String(describing: error)) \(tuple.1)"
                progress(selfC.progressV, message)
                selfC.checkFinishSync(value: selfC.progressV, completion: completion)
              })
            }
          }
        }
        return
      } else {
        completion(false, HKServiceError.AuthorizationDenied("All types"))
      }
      return
    }
  }
  
  
  func requestAuthorization(completion: @escaping (Bool, Error?) -> Swift.Void) {
    repository.requestAuthorization(readTypes: getReadTypes(), writeTypes: getWriteTypes()) { (success, error) in
      completion(success, error)
    }
  }
  
}
