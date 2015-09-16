import Foundation

// This is the Model
struct Board {
    // slightly tempted to make this a `let` and see where that gets to be a problem
    var cells: [[Bool]]

    // Creates a board with all cells equal to false
    init(dimension: Int) {
        let row = Array(count: dimension, repeatedValue: false)
        cells = Array(count: dimension, repeatedValue: row)
    }
    
    init(cells: [[Bool]]) {
        self.cells = cells
    }
}


/**

it depends on how we want to create a board. 

1) create the 2D array by appending, then pass it to the board in the init
2) create a partial board, then fill it in as we go
3) create a 2d array with nils and then fill it in, then pass to Board

and how we want to update a board when user is interacting

1) toggle the cell that got tapped on
2) create a new board with the cell changed like Haskell would want you to but c'mon

there are two types of mutations: arbitrary user mutations and rules-based mutations. 
arbitrary user changes are controlled by the editor, though we could also just operate on a 2d array
rules would be controlled by the life simulator

in any case it feels like this model is a little pointless since we could just operate on a 2d array

*/
