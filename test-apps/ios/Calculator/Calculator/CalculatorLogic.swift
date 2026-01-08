import Foundation

class CalculatorLogic {

    private var currentNumber: String = "0"
    private var previousNumber: Double?
    private var currentOperation: String?
    private var shouldResetDisplay: Bool = false

    func processInput(_ input: String) -> String {
        switch input {
        case "0"..."9":
            return handleNumber(input)
        case ".":
            return handleDecimal()
        case "C":
            return handleClear()
        case "±":
            return handleToggleSign()
        case "%":
            return handlePercent()
        case "+", "−", "×", "÷":
            return handleOperation(input)
        case "=":
            return handleEquals()
        default:
            return currentNumber
        }
    }

    private func handleNumber(_ number: String) -> String {
        if shouldResetDisplay || currentNumber == "0" {
            currentNumber = number
            shouldResetDisplay = false
        } else {
            if currentNumber.count < 9 {
                currentNumber += number
            }
        }
        return currentNumber
    }

    private func handleDecimal() -> String {
        if shouldResetDisplay {
            currentNumber = "0."
            shouldResetDisplay = false
        } else if !currentNumber.contains(".") {
            currentNumber += "."
        }
        return currentNumber
    }

    private func handleClear() -> String {
        currentNumber = "0"
        previousNumber = nil
        currentOperation = nil
        shouldResetDisplay = false
        return currentNumber
    }

    private func handleToggleSign() -> String {
        if let value = Double(currentNumber) {
            let negated = -value
            currentNumber = formatResult(negated)
        }
        return currentNumber
    }

    private func handlePercent() -> String {
        if let value = Double(currentNumber) {
            let percent = value / 100
            currentNumber = formatResult(percent)
        }
        return currentNumber
    }

    private func handleOperation(_ operation: String) -> String {
        if let prev = previousNumber, let op = currentOperation, let current = Double(currentNumber) {
            let result = calculate(prev, op, current)
            previousNumber = result
            currentNumber = formatResult(result)
        } else {
            previousNumber = Double(currentNumber)
        }
        currentOperation = operation
        shouldResetDisplay = true
        return currentNumber
    }

    private func handleEquals() -> String {
        guard let prev = previousNumber,
              let op = currentOperation,
              let current = Double(currentNumber) else {
            return currentNumber
        }

        let result = calculate(prev, op, current)
        currentNumber = formatResult(result)
        previousNumber = nil
        currentOperation = nil
        shouldResetDisplay = true
        return currentNumber
    }

    private func calculate(_ a: Double, _ operation: String, _ b: Double) -> Double {
        switch operation {
        case "+":
            return a + b
        case "−":
            return a - b
        case "×":
            return a * b
        case "÷":
            return b != 0 ? a / b : 0
        default:
            return b
        }
    }

    private func formatResult(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 && abs(value) < 1e9 {
            return String(format: "%.0f", value)
        } else {
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 8
            formatter.numberStyle = .decimal
            return formatter.string(from: NSNumber(value: value)) ?? "0"
        }
    }
}
