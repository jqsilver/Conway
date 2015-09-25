import UIKit
import ReactKit

class ViewController: UIViewController, BoardCellDelegate {
    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var startButton: UIButton!
    
    let life = LifeController()
    var board: Board!
    var running: Bool = false
    
    var timerStream: Stream<Void>?
    var lifeStream: Stream<Board>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        boardView.delegate = self
        
        startButton.setTitle("Start", forState: .Normal)
        startButton.setTitle("Stop", forState: .Selected)
        
        // TODO could also do some FRP stuff here
        startButton.addTarget(self, action: "startPressed", forControlEvents: .TouchUpInside)
        
        board = Board(dimension: 10)
        
        boardView.updateWithBoard(board)
        
        lifeStream = life.lifeStream(board)
    }
    
    func startPressed() {
        if running {
            stopLife()
        } else {
            startLife()
        }
    }
    
    func startLife() {
        startButton.selected = true
        running = true
        
        timerStream = NSTimer.stream(timeInterval: 0.5) { timer in
            return
        }
        
        self.nextStep <~ timerStream!
    }
    
    func stopLife() {
        startButton.selected = false
        running = false
        
        timerStream?.cancel()
        timerStream = nil
    }
    
    func nextStep() {
        let nextBoard = life.nextBoard(board)
        boardView.updateWithBoard(nextBoard)
        board = nextBoard
    }
    
    func boardCellTapped(cell: BoardCell) {
        // Only allow tapping when not running the simulation
        guard !running else { return }

        // update the model, then pass the model to the view
        board.setValue(!cell.isAlive, atIndex: cell.index)
        
        boardView.updateWithBoard(board)
        
        // reset the lifeStream
        lifeStream = life.lifeStream(board)
    }
}

