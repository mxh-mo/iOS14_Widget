//
//  MOWidgetManager.swift
//  MOWidgetDemo
//
//  Created by 莫晓卉 on 2020/12/26.
//

import WidgetKit

@objc
@available(iOS 14.0, *)
class WWWidgetManager: NSObject {
  @objc static let shared = WWWidgetManager()

  //MARK: - 刷新所有小组件
  @objc func reloadAllTimelines() {
    #if arch(arm64) || arch(i386) || arch(x86_64)
    WidgetCenter.shared.reloadAllTimelines()
    #endif
  }

  // MARK: - 刷新单个小组件
  @objc func reloadTimelines(kind: String) {
    #if arch(arm64) || arch(i386) || arch(x86_64)
    WidgetCenter.shared.reloadTimelines(ofKind: kind)
    #endif
  }
}

class WWAppGroupManager: NSObject {
  static let kAppGroupIdentify = "group.mo.widget"
  static let kUserInfoKey = "user_info"
  
  // MARK: - 保存用户信息
  @objc static func setUserInfo(_ info: [AnyHashable : Any]) {
    let userDefaults = UserDefaults(suiteName: kAppGroupIdentify)
    userDefaults?.setValue(info, forKey: kUserInfoKey)
  }
  
  // MARK: - 获取用户信息
  @objc static func getUserInfo() -> [AnyHashable : Any]? {
    let userDefaults = UserDefaults(suiteName: kAppGroupIdentify)
    guard let info: [AnyHashable : Any] = userDefaults?.value(forKey: kUserInfoKey) as? [AnyHashable : Any] else {
      print("app group: get user nil")
      return nil
    }
    return info
  }
}
