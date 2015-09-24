import UIKit

class BoardView: UIView {
    weak var delegate: BoardCellDelegate? {
        didSet {
            cells.enumerate2d { _, _, cell in
                cell.delegate = self.delegate
            }
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
        
        cells = GenerateArray2D(cellDimension, numPerRow: cellDimension) { i, j in
            return BoardCell(index: (i, j))
        }
        
        cells.enumerate2d { i, j, cell in
            self.addSubview(cell)
        }
    }
    
    func updateWithBoard(board: [[Bool]]) {
        // TODO: worry about mismatched dimensions
        
        board.enumerate2d { i, j, isAlive in
            cells[i][j].isAlive = isAlive
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
        
        cells.enumerate2d { i, j, cell in
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