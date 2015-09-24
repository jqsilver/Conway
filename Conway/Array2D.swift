import Foundation

extension Array where Element: SequenceType {
    
    func enumerate2d(@noescape block: (Int, Int, Element.Generator.Element) -> Void) {
        for (i, row) in self.enumerate() {
            for (j, item) in row.enumerate() {
                block(i, j, item)
            }
        }
    }
}

func MakeArray2D<Element>(numRows: Int, numPerRow: Int, value: Element) -> [[Element]] {
    let row = Array(count: numPerRow, repeatedValue: value)
    return Array(count: numRows, repeatedValue: row)
}

func GenerateArray2D<Element>(numRows: Int, numPerRow: Int, valueGenerator: (Int, Int) -> Element) -> [[Element]] {
    var arr2d = [[Element]]()
    for i in 0..<numRows {
        var row = [Element]()
        for j in 0..<numPerRow {
            row.append(valueGenerator(i, j))
        }
        arr2d.append(row)
    }
    return arr2d
}

struct BlockGenerator<Element> {

    let block: () -> Element
    mutating func next() -> Element? {
        return block()
    }
}