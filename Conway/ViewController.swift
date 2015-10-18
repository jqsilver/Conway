import UIKit
import ReactKit

class ViewController: UIViewController, BoardCellDelegate {
    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var startButton: UIButton!
    
    let life = LifeController()
    var initialBoard: Board!
    var running: Bool = false
    
    var timerStream: Stream<Void>!
    var lifeStream: Stream<Board>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        boardView.delegate = self
        
        startButton.setTitle("Start", forState: .Normal)
        startButton.setTitle("Stop", forState: .Selected)
        
        // TODO could also do some FRP stuff here
        startButton.addTarget(self, action: "startPressed", forControlEvents: .TouchUpInside)
        
        initialBoard = Board(dimension: 10)
        
        boardView.updateWithBoard(initialBoard)
        
        lifeStream = life.lifeStream(initialBoard)
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
  

        self.nextStep <~ timerStream
    }
    
    func stopLife() {
        startButton.selected = false
        running = false
        
        timerStream?.cancel()
        timerStream = nil
    }
    
    func nextStep() {
        /**
        // This always takes the first element in the stream and never actually gets to the second one
        lifeStream |> take(1) ~>! { nextBoard in
            self.boardView.updateWithBoard(nextBoard)
        }
        */
    }
    
    func boardCellTapped(cell: BoardCell) {
        // Only allow tapping when not running the simulation
        guard !running else { return }

        // update the model, then pass the model to the view
        initialBoard.setValue(!cell.isAlive, atIndex: cell.index)
        
        boardView.updateWithBoard(initialBoard)
        
        // reset the lifeStream
        lifeStream = life.lifeStream(initialBoard)
    }
}

