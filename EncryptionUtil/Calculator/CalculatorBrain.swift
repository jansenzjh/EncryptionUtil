

import Foundation

func mod(divisor: Double, divider: Double) -> Double {
    
    return divisor.truncatingRemainder(dividingBy: divider)
}

struct CalculatorBrain {
    
    private var accumulator: Double?
	private var resultIsPending: Bool = false
    var description: String = ""
    
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    
    
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "±": Operation.unaryOperation({-$0}),
        "cos": Operation.unaryOperation(cos),
        "*": Operation.binaryOperation({$0 * $1}),
        "/": Operation.binaryOperation({$0 / $1}),
        "+": Operation.binaryOperation({$0 + $1}),
        "-": Operation.binaryOperation({$0 - $1}),
        "=": Operation.equals,
        "sin": Operation.unaryOperation(sin),
        "tan": Operation.unaryOperation(tan),
        "mod": Operation.binaryOperation(mod)
    ]
    
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
                description = String(value)
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                    description = symbol + "(" + description + ")"
                    
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, leftOperand: accumulator!)
                    description +=  " \(symbol)"
                    accumulator = nil
                    resultIsPending = true
                    
                }
                break
            case .equals:
                performPendingBinaryOperation()
                resultIsPending = false
                break
            }
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
//            description += " \(accumulator!)"
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
        }
    }
    
    private var pendingBinaryOperation: PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let leftOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(leftOperand, secondOperand)
        }
    }

    mutating func setOperand(_ operand: Double) {
        accumulator = operand
        description += " \(accumulator!)"
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
}
