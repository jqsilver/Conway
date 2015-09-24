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
    
    return (0..<numRows).map { i in
        (0..<numPerRow).map { j in
            valueGenerator(i, j)
        }
    }
}

// just wrote this 'cause I wish it were a constructor
// There must be a way to convert generate into a SequenceType
func GenerateArray<Element>(count: Int, generate: () -> Element) -> [Element] {
    
    // for some bizarre reason I can't pass a function of type () -> Element when it wants a function of type () -> Element?
    let sequence = AnySequence(anyGenerator({ generate($0) }))
    return Array(sequence.prefix(count))
}

extension Array {
    func toroidalGet(idx: Int) -> Element {
        if idx < 0 {
            return self[self.count + idx]
        } else if idx >= self.count {
            return self[idx - self.count]
        } else {
            return self[idx]
        }
    }
    
    func cross<OtherElem>(other: [OtherElem]) -> [(Element, OtherElem)] {
        
        return self.flatMap { (elem: Element) -> [(Element, OtherElem)] in
            let othersWithElem = other.map { otherElem in
                return (elem, otherElem)
            }
            return othersWithElem
        }
    }
}