//
//  MODataSource.swift
//  MOWidgetDemo
//
//  Created by 莫晓卉 on 2020/12/26.
//

import Foundation

struct MOFitnessData {
  static let shared: MOFitnessData = MOFitnessData()
  var screenHeight: Float = 169.0 {
    didSet {
      scale = screenHeight / 169.0
    }
  }
  var scale: Float = 1.0
  // 动动：小时
  let activesNow: Float = 0.5
  let activesGoal: Float = 1.0
  // 锻炼：分钟
  let exercisesNow: Int = 20
  let exercisesGoal: Int = 30
  // 步数：步
  let stepsNow: Int = 9999
  let stepsGoal: Int = 99999
  
  let actives: [Bool] = [false, false, false, false, false, false, true, false, false, true, false, false, true, false, true, false, true, true, false, false, false, false, false, false]
  let exercises: [Float] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 133.884, 0.0, 122, 0.0, 200, 0.0, 80, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
  let steps: [Float] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 165.98833819241983, 100, 90, 300, 29, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
  
  func progress() -> [Float] {
    let exercise = Float(activesNow) / Float(activesGoal)
    let active = Float(exercisesNow) / Float(exercisesGoal)
    let step = Float(stepsNow) / Float(stepsGoal)
    return [exercise, active, step]
  }
}

struct MODataSouce {
  static let shared = MODataSouce()
  // MARK: 请求数据
  func fetchData(fetchSuccess: @escaping (MOFitnessData) -> Void, fetchFailure: @escaping () -> Void) {
    // 模拟耗时网络请求
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      let success = true
      if success {
        fetchSuccess(MOFitnessData.shared)
      } else {
        fetchFailure()
      }
    }
  }
}
