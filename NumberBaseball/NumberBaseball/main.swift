//
//  NumberBaseball - main.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

func selectMenu(quitFlag: inout Bool) {
    print("1. 게임시작")
    print("2. 게임종료")
    print("원하는 기능을 선택해주세요", terminator: " : ")
    
    guard let selectedMenu = readLine() else {
        // TODO: 에러출력
        // TODO: return 제거
        return
    }
    
    switch selectedMenu {
    case "1":
        // TODO: 게임숫자 입력받는 함수 구현
        // TODO: return 제거
        return
    case "2":
        quitFlag = true
        return
    default:
        // TODO: 에러출력
        // TODO: return 제거
        return
    }
}

func runNumberGame() {
    var quitFlag = false
    while quitFlag == false {
        selectMenu(quitFlag: &quitFlag)
    }
}

func startGame() {
    let lifeCount = 9
    let generatedCorrectNumbers = generatedThreeRandomNumbers()
    var userTryNumbers: [Int]
    var threeStrikeFlag = false
    
    for attemptCount in 1...lifeCount where threeStrikeFlag == false {
        userTryNumbers = generatedThreeRandomNumbers()
        
        let (strikeCount, ballCount) = computedStrikeCountAndBallCount(generatedCorrectNumbers: generatedCorrectNumbers, userTryNumbers: userTryNumbers)
        
        print("임의의 수: \(userTryNumbers[0]) \(userTryNumbers[1]) \(userTryNumbers[2])")
        print("\(strikeCount) 스트라이크, \(ballCount) 볼")
        
        threeStrikeFlag = isThreeStrike(strikeCount: strikeCount)
        
        printRemainingLifeCount(lifeCount: lifeCount, attemptCount: attemptCount, threeStrikeFlag: threeStrikeFlag)
    }
    
    printWinner(threeStrikeFlag: threeStrikeFlag)
}

func printWinner(threeStrikeFlag: Bool) {
    if threeStrikeFlag == true {
        print("사용자 승리...!")
    } else {
        print("컴퓨터 승리...!")
    }
}

func printRemainingLifeCount(lifeCount: Int, attemptCount: Int, threeStrikeFlag: Bool) {
    if threeStrikeFlag == true {
        return
    } else {
        print("남은 기회: \(lifeCount-attemptCount)")
    }
}

func isThreeStrike(strikeCount: Int) -> Bool {
    if strikeCount == 3 {
        return true
    } else {
        return false
    }
}

func generatedThreeRandomNumbers() -> [Int] {
    var randomNumbers: [Int]
    var deduplicatedNumbers: Set<Int>
    
    repeat {
        randomNumbers = [Int.random(in: 1...9), Int.random(in: 1...9), Int.random(in: 1...9)]
        deduplicatedNumbers = Set(randomNumbers)
    } while randomNumbers.count != deduplicatedNumbers.count
    
    return randomNumbers
}

func computedStrikeCountAndBallCount(generatedCorrectNumbers: [Int], userTryNumbers: [Int]) -> (Int, Int) {
    var strikeCount = 0
    var ballCount = 0
    
    for index in 0..<userTryNumbers.count {
        increaseStrikeCountOrBallCount(generatedCorrectNumbers: generatedCorrectNumbers,
                                       userTryNumbers: userTryNumbers,
                                       index: index,
                                       strikeCount: &strikeCount,
                                       ballCount: &ballCount)
    }
    
    return (strikeCount, ballCount)
}

func increaseStrikeCountOrBallCount(generatedCorrectNumbers: [Int], userTryNumbers: [Int], index: Int, strikeCount: inout Int, ballCount: inout Int) {
    if generatedCorrectNumbers[index] == userTryNumbers[index] {
        strikeCount += 1
    } else if generatedCorrectNumbers.contains(userTryNumbers[index]) {
        ballCount += 1
    }
}
