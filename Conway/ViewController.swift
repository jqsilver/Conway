import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var startButton: UIButton!
    
    let life = LifeController()
    var timer: NSTimer!
    var board: [[Bool]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startButton.addTarget(self, action: "startPressed", forControlEvents: .TouchUpInside)
        
        board = Array(count: 10, repeatedValue:
            Array(count: 10, repeatedValue: false)
        )
        
        board[3][5] = true
        board[4][5] = true
        board[5][5] = true
        boardView.updateWithBoard(board)
    }
    
    func startPressed() {
        assert(NSThread.isMainThread())
        timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "nextStep", userInfo: nil, repeats: true)
    }
    
    func nextStep() {
        let nextBoard = life.nextBoard(board)
        boardView.updateWithBoard(nextBoard)
        board = nextBoard
    }
}

