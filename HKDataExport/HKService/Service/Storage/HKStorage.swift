//
//  HKStorage.swift
//  HKDataExport
//
//  Created by Dmitrii Kalashnikov on 10/01/2019.
//  Copyright © 2019 Dmitrii Kalashnikov. All rights reserved.
//

import Foundation
import HealthKit

protocol HKStorage {
  func saveAnchor(anchor: HKQueryAnchor, forType: String)
  func saveWorkoutDate(date: Date)
  func saveActivityDate(date: Date)
  
  func getWorkoutDate() -> Date?
  func getActivityDate() -> Date?
  func getAnchor(type: String) -> HKQueryAnchor?
  func saveQuantitySamples(samples: [HKQuantitySample], unit: HKUnit, completion: @escaping (Bool, Error?) -> Swift.Void)
  func saveCategorySamples(samples: [HKCategorySample], values: [String], completion: @escaping (Bool, Error?) -> Swift.Void)
  func saveActivitySamples(samples: [HKActivitySummary], completion: @escaping (Bool, Error?) -> Swift.Void)
  func saveWorkoutSamples(samples: [HKWorkout], completion: @escaping (Bool, Error?) -> Swift.Void)
  func saveCharacteristicSample(type: String, value: String, completion: @escaping (Bool, Error?) -> Swift.Void)
  
  func getWorkoutSamples(completion: @escaping (Bool, [(Date , String)], Error?) -> Swift.Void)
  func getActivitySamples(completion: @escaping (Bool, [(Date , String)], Error?) -> Swift.Void)
  func getQuantitySamples(type: HKQuantityType ,completion: @escaping (Bool, [(Date, Double, String)], Error?) -> Swift.Void)
  func getCategorySamples(type: HKCategoryType ,completion: @escaping (Bool, [(Date , String)], Error?) -> Swift.Void)
  func getCharacteristicSamples( completion: @escaping (Bool, [(String , String)], Error?) -> Swift.Void)
  
  func getCountForCharacteristicType(_ type: String) -> Int
  func getCountForQuantityType(_ type: String) -> Int
  func getCountForWorkoutType() -> Int
  func getCountforActivityType() -> Int
}
