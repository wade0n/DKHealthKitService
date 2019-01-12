//
//  HKRepositoryImp.swift
//  HKDataExport
//
//  Created by Dmitrii Kalashnikov on 10/01/2019.
//  Copyright © 2019 Dmitrii Kalashnikov. All rights reserved.
//

import HealthKit
import Foundation

enum HKRepositoryError: Error {
  case notAuthorized
  case notAvailable
  case serviceError(String)
}

class HKRepositoryImp {
  fileprivate let store = HKHealthStore()
  
  init() {
    
  }
}

extension HKRepositoryImp: HKRepository {
  
  func isHKAvailable() -> Bool {
    return HKHealthStore.isHealthDataAvailable()
  }
  
  func requestAuthorization(readTypes :Set<HKObjectType>, writeTypes: Set<HKSampleType>, completion: @escaping (Bool, Error?) -> Swift.Void) {
    store.requestAuthorization(toShare: writeTypes, read: readTypes, completion: completion)
    
  }
  
  //MARK: user data
  func getBirthDay(completion: @escaping (Date?, Error?) -> Swift.Void) {
    do {
      let birthDateComponents = try store.dateOfBirthComponents()
      completion(birthDateComponents.date, nil)
    }
    catch{
      completion(nil, HKRepositoryError.notAvailable)
    }
  }
  
  func getBloodType(completion: @escaping (HKBloodType?, Error?) -> Swift.Void) {
    do {
      let bloodType = try store.bloodType()
      completion(bloodType.bloodType, nil)
    }
    catch{
      completion(nil, HKRepositoryError.notAvailable)
    }
  }
  
  func getSex(completion: @escaping (HKBiologicalSex?, Error?) -> Swift.Void) {
    do {
      let sexType = try store.biologicalSex()
      completion(sexType.biologicalSex, nil)
    }
    catch{
      completion(nil, HKRepositoryError.notAvailable)
    }
  }
  
  func getSkinType(completion: @escaping (HKFitzpatrickSkinType?, Error?) -> Swift.Void) {
    do {
      let skinType = try store.fitzpatrickSkinType()
      completion(skinType.skinType, nil)
    }
    catch {
      completion(nil, HKRepositoryError.notAvailable)
    }
  }
  
  //MARK: workout samples
  func getWorkoutSamples(lastSynceDate: Date? ,completion: @escaping ([HKWorkout], Error?) -> Swift.Void) {
    let startDate = Date()
    let endDate =  lastSynceDate ?? startDate.addingTimeInterval(-60*60*24*365)
    
    let predicate = HKQuery.predicateForSamples(withStart: endDate as Date, end: startDate as Date, options: [.strictStartDate, .strictEndDate])
    let query = HKSampleQuery.init(sampleType: HKObjectType.workoutType(), predicate: predicate, limit: 0, sortDescriptors: nil) { (query, samples, error) in
      var workouts: [HKWorkout] = []
      
      if let results = samples {
        for result in results {
          if let workout = result as? HKWorkout {
            // Here's a HKWorkout object
            workouts.append(workout)
          }
        }
        completion(workouts,nil)
      }
      else {
        completion(workouts,error)
        // No results were returned, check the error
      }
    }
    store.execute(query)
  }
  
  //MARK: category methods
  
  func getCategorySamples(type: HKCategoryType,
                          anchor: HKQueryAnchor?,
                          completion: @escaping ((added: [HKCategorySample],
    newAnchor: HKQueryAnchor?),Error?) -> Swift.Void) {
    let query = HKAnchoredObjectQuery(type: type,
                                      predicate: nil,
                                      anchor: anchor,
                                      limit: HKObjectQueryNoLimit)
    { (query, samplesOrNil, deletedObjectsOrNil, newAnchor, errorOrNil) in
      
      guard let samples = samplesOrNil else {
        // Handle the error here.
        completion((added: [], newAnchor: nil), HKRepositoryError.serviceError("*** An error occurred during the initial query: \(errorOrNil!.localizedDescription) ***"))
        return
      }
      
      completion((samples as! [HKCategorySample], newAnchor), nil)
    }
    
    // Run the query.
    store.execute(query)
  }
  
  //MARK: quantity methods
  
  func getQuantitySamples(type: HKQuantityType,
                          anchor: HKQueryAnchor?,
                          completion: @escaping ((added: [HKQuantitySample],
    newAnchor: HKQueryAnchor?), Error?) -> Swift.Void) {
    // Create the query.
    
    let query = HKAnchoredObjectQuery(type: type,
                                      predicate: nil,
                                      anchor: anchor,
                                      limit: 200000)
    { (query, samplesOrNil, deletedObjectsOrNil, newAnchor, errorOrNil) in
      
      guard let samples = samplesOrNil else {
        // Handle the error here.
        completion((added: [], newAnchor: nil), HKRepositoryError.serviceError("*** An error occurred during the initial query: \(errorOrNil!.localizedDescription) ***"))
        return
      }
      
      completion((samples as! [HKQuantitySample], newAnchor), nil)
    }
    
    // Run the query.
    store.execute(query)
  }
  
  func getActivities(lastSynceDate: Date?, completion: @escaping ([HKActivitySummary], Error?) -> Swift.Void) {
    var calendar = Calendar.current
    calendar.timeZone = TimeZone.current
    let endDate = Date()
    let startDate = lastSynceDate ?? endDate.addingTimeInterval(-60*60*24*365)
    
    var endC = calendar.dateComponents([Calendar.Component.day, Calendar.Component.month, Calendar.Component.year], from: endDate)
    endC.calendar = calendar
    var startC = calendar.dateComponents([Calendar.Component.day , Calendar.Component.month, Calendar.Component.year], from: startDate)
    startC.calendar = calendar
    let predicate = HKQuery.predicate(forActivitySummariesBetweenStart: startC, end: endC)
    let query = HKActivitySummaryQuery.init(predicate: predicate) { (querry, activities, error) in
      
      completion(activities!,error)
    }
    store.execute(query)
  }
}
