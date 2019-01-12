//
//  HKRepository.swift
//  HKDataExport
//
//  Created by Dmitrii Kalashnikov on 10/01/2019.
//  Copyright © 2019 Dmitrii Kalashnikov. All rights reserved.
//

import HealthKit
import Foundation

protocol HKRepository {
  func isHKAvailable() -> Bool
  func requestAuthorization(readTypes :Set<HKObjectType>, writeTypes: Set<HKSampleType>, completion: @escaping (Bool, Error?) -> Swift.Void)
  func getBirthDay(completion: @escaping (Date?, Error?) -> Swift.Void)
  func getBloodType(completion: @escaping (HKBloodType?, Error?) -> Swift.Void)
  func getSex(completion: @escaping (HKBiologicalSex?, Error?) -> Swift.Void)
  func getSkinType(completion: @escaping (HKFitzpatrickSkinType?, Error?) -> Swift.Void)
  func getWorkoutSamples(lastSynceDate: Date? ,completion: @escaping ([HKWorkout], Error?) -> Swift.Void)
  func getCategorySamples(type: HKCategoryType,
                          anchor: HKQueryAnchor?,
                          completion: @escaping ((added: [HKCategorySample],
    newAnchor: HKQueryAnchor?),Error?) -> Swift.Void)
  func getQuantitySamples(type: HKQuantityType,
                          anchor: HKQueryAnchor?,
                          completion: @escaping ((added: [HKQuantitySample],
    newAnchor: HKQueryAnchor?),Error?) -> Swift.Void)
  func getActivities(lastSynceDate: Date?, completion: @escaping ([HKActivitySummary], Error?) -> Swift.Void)
}
