private func receivePlayerInput() -> Int? {
	print("원하는 기능을 선택해주세요", terminator: " : ")
	guard let input = readLine() else {
		return nil
	}
	
	return Int(input)
}

private func identify(playerInput: Int?) -> Bool? {
	switch playerInput {
	case 1: return true
	case 2: return nil
	default: return false
	}
}

consoleLoop: while true {
    print("1. 게임시작")
    print("2. 게임종료")
    
    switch identify(playerInput: receivePlayerInput()) {
	case .some(let isStartGame):
        isStartGame ? startGame() : print("입력이 잘못되었습니다")
	case .none:
		break consoleLoop
	}
}

