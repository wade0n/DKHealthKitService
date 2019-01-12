//
//  HKService.swift
//  HKDataExport
//
//  Created by Dmitrii Kalashnikov on 10/01/2019.
//  Copyright © 2019 Dmitrii Kalashnikov. All rights reserved.
//

import Foundation
import HealthKit

// rename project all
protocol HKService {
  
  //TODO: separate get methods from DB and authorization methods
  func requestAuthorization(completion: @escaping (Bool, Error?) -> Swift.Void)
  //TODO add authorization list set
  
  
  func startSynchronization(progress: @escaping (Float, String) -> Swift.Void,completion: @escaping (Bool, Error?) -> Swift.Void)
  func getSamplesForType(type: HKObjectType, completion: @escaping ([(date: String, value: String)],Error?) -> Swift.Void)
  func getUserData(completion: @escaping ([(type: String, value: String)],Error?) -> Swift.Void)
  
  func getCountType(_ type: HKObjectType) -> Int
  func getCountForTypes(_ types: [HKObjectType]) -> Int
}
