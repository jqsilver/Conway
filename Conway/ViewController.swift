import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var startButton: UIButton!
    
    let life = LifeController()
    var board: [[Bool]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startButton.addTarget(self, action: "startPressed", forControlEvents: .TouchUpInside)
        
        board = Array(count: 10, repeatedValue:
            Array(count: 10, repeatedValue: false)
        )
        
        board[5][5] = true
        board[5][6] = true
        board[6][5] = true
        board[6][6] = true
        boardView.updateWithBoard(board)
    }
    
    func startPressed() {
        let nextBoard = life.nextBoard(board)
        boardView.updateWithBoard(nextBoard)
        board = nextBoard
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

