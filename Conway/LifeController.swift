import Foundation

class LifeController {
    // TODO: try making a Stream of states using one/each of the FRP libraries
    
    func nextBoard(board: [[Bool]]) -> [[Bool]] {
        var next = board
        for i in 0..<board.count {
            for j in 0..<board.count {
                let numNeighbors = countNeighbors(board, i: i, j: j)
                next[i][j] = liveOrDie(board[i][j], numNeighbors: numNeighbors)
            }
        }
        return next
    }
    
    func countNeighbors(board: [[Bool]], i: Int, j: Int) -> Int {
        // TODO: think about how we could abstract the board to use hexagons or something crazy like that
        
        var sum = 0
        for (di, dj) in neighborDeltas() {
            let row = board.toroidalGet(i + di)
            if row.toroidalGet(j + dj) {
                sum++
            }

        }
        return sum
        
        
//        let neighborBools = neighborDeltas().map { deltas in
//            let (di, dj) = deltas
//            let row = board.toroidalGet(i + di)
//            return row.toroidalGet(j + dj)
//        }
//        return neighborBools.map { $0 ? 1 : 0 }.reduce(0, combine: +)
    }
    
    
    func neighborDeltas() -> [(Int, Int)] {
        let oneDDeltas = [-1, 0, 1]
        let pairs = oneDDeltas.cross(oneDDeltas)
        return pairs.filter { !($0.0 == 0 && $0.1 == 0) }
    }
    
    func liveOrDie(alive: Bool, numNeighbors: Int) -> Bool {
        switch numNeighbors {
        case 2:
            return alive
        case 3:
            return true
        default:
            return false
        }
    }
}

extension Array {
    func toroidalGet(idx: Int) -> Element {
        if idx < 0 {
            return self[self.count + idx]
        } else if idx >= self.count {
            return self[idx - self.count]
        } else {
            return self[idx]
        }
    }
    
    func cross<OtherElem>(other: [OtherElem]) -> [(Element, OtherElem)] {

// how do I do this functionally?
//        self.flatMap { (elem: Element) -> [(Element, OtherElem)] in
//            return other.map { otherElem in
//                (elem, otherE)
//            }
//        }
        var ret = [(Element, OtherElem)]()
        for elem in self {
            for otherElem in other {
                ret.append(elem, otherElem)
            }
        }
        return ret
    }
}