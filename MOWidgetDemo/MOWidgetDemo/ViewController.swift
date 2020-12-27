//
//  ViewController.swift
//  MOWidgetDemo
//
//  Created by 莫晓卉 on 2020/12/10.
//

import UIKit
import WidgetKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let btn = UIButton(type: .custom)
    btn.backgroundColor = .red
    btn.frame = CGRect(x: 20, y: 100, width: 60, height: 44)
    btn.addTarget(self, action: #selector(clickBtn), for: .touchUpInside)
    view.addSubview(btn)
  }

  @objc func clickBtn() {
    WidgetCenter.shared.reloadAllTimelines()
    WidgetCenter.shared.reloadTimelines(ofKind: "MOWidget")
  }
  
  func login() {
    
  }
  

}

