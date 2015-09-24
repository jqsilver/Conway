import Foundation

struct Board {
    // slightly tempted to make this a `let` and see where that gets to be a problem
    private var cells: [[Bool]]

    var dimension: Int {
        return cells.count
    }
    
    // Creates a board with all cells equal to false
    init(dimension: Int) {
        cells = MakeArray2D(dimension, numPerRow: dimension, value: false)
    }
    
    init(cells: [[Bool]]) {
        self.cells = cells
    }
    
    mutating func setValue(val: Bool, atIndex index: (Int, Int)) {
        cells[index.0][index.1] = val
    }
    
    func getValue(index: (Int, Int)) -> Bool {
        let (i, j) = index
        return cells.toroidalGet(i).toroidalGet(j)
    }
    
    func countLivingNeighbors(index: (Int, Int)) -> Int {
        func neighborDeltas() -> [(Int, Int)] {
            let oneDDeltas = [-1, 0, 1]
            let pairs = oneDDeltas.cross(oneDDeltas)
            return pairs.filter { !($0.0 == 0 && $0.1 == 0) }
        }
        
        let (i, j) = index
        let delts = neighborDeltas()
        let neighborLivingStates = delts.map { (indexDeltas: (Int, Int)) -> Bool in
            let (di, dj) = indexDeltas
            let index = (i + di, j + dj)
            return getValue(index)
        }
        
        return neighborLivingStates.map { $0 ? 1 : 0 }.reduce(0, combine: +)
    }
    
    func enumerateCells(@noescape callback: (Int, Int, Bool) -> Void) {
        cells.enumerate2d(callback)
    }
}


/**

it depends on how we want to create a board. 

1) create the 2D array by appending, then pass it to the board in the init
2) create a partial board, then fill it in as we go
3) create a 2d array with nils and then fill it in, then pass to Board

and how we want to update a board when user is interacting

1) toggle the cell that got tapped on
2) create a new board with the cell changed like Haskell would want you to but c'mon

there are two types of mutations: arbitrary user mutations and rules-based mutations. 
arbitrary user changes are controlled by the editor, though we could also just operate on a 2d array
rules would be controlled by the life simulator

in any case it feels like this model is a little pointless since we could just operate on a 2d array

*/
