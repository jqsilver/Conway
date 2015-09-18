import UIKit

protocol BoardCellDelegate: class {
    func boardCellTapped(cell: BoardCell)
}

class BoardCell: UIView {
    weak var delegate: BoardCellDelegate? = nil
    
    let index: (Int, Int)
    
    var isAlive: Bool {
        return self.backgroundColor == UIColor.blueColor()
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
    
    func live() {
        backgroundColor = UIColor.blueColor()
    }
    
    func die() {
        backgroundColor = UIColor.whiteColor()
    }
}
