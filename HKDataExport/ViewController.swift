//
//  ViewController.swift
//  HKDataExport
//
//  Created by Dmitrii Kalashnikov on 10/01/2019.
//  Copyright © 2019 Dmitrii Kalashnikov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  let hkService: HKService = HKServiceImp()
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    hkService.startSynchronization(progress: { (progrees, type) in
      print("progress: \(progrees)% - \(type)")
    }) { (success, error) in
      print("finished - \(success) error: \(error)")
    }
  }


}

