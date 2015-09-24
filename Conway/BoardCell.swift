import UIKit

protocol BoardCellDelegate: class {
    func boardCellTapped(cell: BoardCell)
}

class BoardCell: UIView {
    weak var delegate: BoardCellDelegate? = nil
    
    let index: (Int, Int)
    
    var isAlive: Bool {
        get {
            return self.backgroundColor == UIColor.blueColor()
        }
        
        set(alive) {
            self.backgroundColor = alive ? UIColor.blueColor() : UIColor.whiteColor()
        }
    }
    
    init(index: (Int, Int)) {
        self.index = index
        
        super.init(frame: CGRectZero)
        
        layer.borderColor = UIColor.grayColor().CGColor
        layer.borderWidth = 1
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: "onTap"))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onTap() {
        delegate?.boardCellTapped(self)
    }
}
