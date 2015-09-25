import Foundation
import ReactKit

class LifeController {
    // TODO: try making a Stream of states using one/each of the FRP libraries
    
    func lifeStream(initialBoard: Board) -> Stream<Board> {
        return Stream.infiniteSequence(initialBoard) {
            return self.nextBoard($0)
        }
    }
    
    func nextBoard(board: Board) -> Board {
        var next = Board(dimension: board.dimension)
        board.enumerateCells { (i, j, isAlive) in
            let index = (i, j)
            let numNeighbors = board.countLivingNeighbors(index)
            let aliveNext = liveOrDie(board.getValue(index), numNeighbors: numNeighbors)
            next.setValue(aliveNext, atIndex: index)
        }
        return next
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

