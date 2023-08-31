//
//  NumberBaseball - main.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation

var remainChance = 9
var computerChoice = makeRandomNumber()

func makeRandomNumber() -> [Int] {
    var randomNum: Set<Int> = []
    
    while randomNum.count < 3 {
        randomNum.insert(Int.random(in: 1...9))
    }
    return Array(randomNum)
}

func compareRandomNumber(randomNumber: [Int]) -> [Int] {
    var strike = 0
    var ball = 0
    
    for (index, number) in randomNumber.enumerated() {
        if index == computerChoice.firstIndex(of: number) {
            strike += 1
        } else if computerChoice.contains(number) {
            ball += 1
        }
    }
    return [ball, strike]
}

func startGame() {
    while remainChance >= 0 {
        let userNumber = makeRandomNumber()
        let result = compareRandomNumber(randomNumber: userNumber)
        print("임의의 수 :\(userNumber.map { String($0) }.joined(separator: " "))")
        print("\(result[1]) 스트라이크, \(result[0]) 볼")
        if remainChance != 0 {
            print("남은 기회 : \(remainChance)")
        } else {
            print("컴퓨터 승리")
        }
        if result[1] == 3 {
            print("사용자 승리")
            break
        }
        remainChance -= 1
    }
}

func menu() {
    while true {
        print("1. 게임시작")
        print("2. 게임종료")
        print("원하는 기능을 선택해 주세요 :", terminator: " ")
        let input = readLine()
        guard let input, let input = Int(input) else { return }
        if input == 1 {
            print("게임시작")
        } else if input == 2 {
            print("게임종료")
            break
        } else {
            print("입력이 잘못되었습니다")
            continue
        }
    }
}

func verifyingUserNumber(number: String?) -> [Int]? {
    var intArray: [Int] = []
    guard let number else { return nil }
    var result = number.components(separatedBy: " ")
    
    if result.count == 3 {
        for i in result {
            guard let changeInt = Int(i) else { return nil }
            intArray.append(changeInt)
        }
    } else {
        print("입력이 잘못되었습니다.")
        return nil
    }
    
    var changeSet = Set(intArray)
    var verifyingNumberArray = intArray.count == changeSet.count
    
    if verifyingNumberArray {
        return intArray
    } else {
        print("입력이 잘못되었습니다.")
        return nil
    }
}
