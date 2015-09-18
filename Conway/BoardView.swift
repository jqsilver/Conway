import UIKit

class BoardView: UIView {
    weak var delegate: BoardCellDelegate? = nil {
        didSet {
            forAllCells { $0.delegate = self.delegate }
        }
    }
    
    let cellDimension = 10
    var cells = [[BoardCell]]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCells()
    }
    
    private func initCells() {
        // TODO: do some acrobatics to try to make cells immutable
        cells = [[BoardCell]]()
        for i in 0..<cellDimension {
            var row = [BoardCell]()
            for j in 0..<cellDimension {
                let cell = BoardCell(index: (i, j))
                self.addSubview(cell)
                row.append(cell)
            }
            cells.append(row)
        }

    }
    
    func updateWithBoard(board: [[Bool]]) {
        // TODO: worry about mismatched dimensions
        
        for (i, row) in board.enumerate() {
            for (j, isAlive) in row.enumerate() {
                if isAlive {
                    cells[i][j].live()
                } else {
                    cells[i][j].die()
                }
            }
        }
    }
        
    func forAllCells(block: BoardCell -> Void) {
        for row in cells {
            for cell in row {
                block(cell)
            }
        }
    }
    
    // TODO: make this a global utility or something
    func forAllCellsWithIndices(block: (BoardCell, Int, Int) -> Void) {
        for (i, row) in cells.enumerate() {
            for (j, cell) in row.enumerate() {
                block(cell, i, j)
            }
        }
    }
    
    override func layoutSubviews() {
        let dimension = min(self.bounds.width, self.bounds.height)
        let cellSize = dimension / CGFloat(cellDimension)
        
        forAllCellsWithIndices { cell, i, j in
            let x = cellSize * CGFloat(i)
            let y = cellSize * CGFloat(j)
            
            cell.frame = CGRect(x: x, y: y, width: cellSize, height: cellSize)
        }

    }
}


// just wrote this 'cause I wish it were a constructor
func BuildArray<Element>(count: Int, generate: () -> Element) -> [Element] {
    var arr = [Element]()
    for _ in 0..<count {
        arr.append(generate())
    }
    return arr
}