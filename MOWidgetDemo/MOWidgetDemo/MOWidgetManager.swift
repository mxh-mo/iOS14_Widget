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
  static let kAppGroupIdentify = "group.com.mobvoi.One"
  static let kUserInfoKey = "mo_app_group_user_info"
  
  // MARK: - 保存用户信息
  @objc static func setUserInfo(_ info: [AnyHashable : Any]) {
    let userDefaults = UserDefaults(suiteName: kAppGroupIdentify)
    userDefaults?.setValue(info, forKey: kUserInfoKey)
    
    // 刷新widget
    if #available(iOS 14.0, *) {
      WWWidgetManager.shared.reloadAllTimelines()
    } else {
      // Fallback on earlier versions
      print("earlier versions can't supported iOS14 widget")
    }
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
