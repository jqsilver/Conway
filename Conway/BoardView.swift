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
    var cells: [[BoardCell]]!
    
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
    
    func updateWithBoard(board: Board) {
        // TODO: ensure properly matched dimensions
        
        board.enumerateCells { (i, j, isAlive) in
            cells[i][j].isAlive = isAlive
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
