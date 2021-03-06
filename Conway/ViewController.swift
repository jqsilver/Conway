import UIKit

class ViewController: UIViewController, BoardCellDelegate {
    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var startButton: UIButton!
    
    let life = LifeController()
    weak var timer: NSTimer?
    var board: Board!
    var running: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        boardView.delegate = self
        
        startButton.setTitle("Start", forState: .Normal)
        startButton.setTitle("Stop", forState: .Selected)
        
        // TODO could also do some FRP stuff here
        startButton.addTarget(self, action: "startPressed", forControlEvents: .TouchUpInside)
        
        board = Board(dimension: 10)
        
        boardView.updateWithBoard(board)
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
        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "nextStep", userInfo: nil, repeats: true)
    }
    
    func stopLife() {
        startButton.selected = false
        running = false
        timer?.invalidate()
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
    }
}

