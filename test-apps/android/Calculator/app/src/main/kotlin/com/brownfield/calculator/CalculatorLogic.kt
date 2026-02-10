package com.brownfield.calculator

import java.text.DecimalFormat
import kotlin.math.abs

class CalculatorLogic {

    private var currentNumber: String = "0"
    private var previousNumber: Double? = null
    private var currentOperation: String? = null
    private var shouldResetDisplay: Boolean = false

    fun processInput(input: String): String {
        return when (input) {
            in "0".."9" -> handleNumber(input)
            "." -> handleDecimal()
            "C" -> handleClear()
            "±" -> handleToggleSign()
            "%" -> handlePercent()
            "+", "−", "×", "÷" -> handleOperation(input)
            "=" -> handleEquals()
            else -> currentNumber
        }
    }

    private fun handleNumber(number: String): String {
        if (shouldResetDisplay || currentNumber == "0") {
            currentNumber = number
            shouldResetDisplay = false
        } else {
            if (currentNumber.length < 9) {
                currentNumber += number
            }
        }
        return currentNumber
    }

    private fun handleDecimal(): String {
        if (shouldResetDisplay) {
            currentNumber = "0."
            shouldResetDisplay = false
        } else if (!currentNumber.contains(".")) {
            currentNumber += "."
        }
        return currentNumber
    }

    private fun handleClear(): String {
        currentNumber = "0"
        previousNumber = null
        currentOperation = null
        shouldResetDisplay = false
        return currentNumber
    }

    private fun handleToggleSign(): String {
        val value = currentNumber.toDoubleOrNull()
        if (value != null) {
            currentNumber = formatResult(-value)
        }
        return currentNumber
    }

    private fun handlePercent(): String {
        val value = currentNumber.toDoubleOrNull()
        if (value != null) {
            currentNumber = formatResult(value / 100)
        }
        return currentNumber
    }

    private fun handleOperation(operation: String): String {
        val prev = previousNumber
        val op = currentOperation
        val current = currentNumber.toDoubleOrNull()

        if (prev != null && op != null && current != null) {
            val result = calculate(prev, op, current)
            previousNumber = result
            currentNumber = formatResult(result)
        } else {
            previousNumber = current
        }

        currentOperation = operation
        shouldResetDisplay = true
        return currentNumber
    }

    private fun handleEquals(): String {
        val prev = previousNumber ?: return currentNumber
        val op = currentOperation ?: return currentNumber
        val current = currentNumber.toDoubleOrNull() ?: return currentNumber

        val result = calculate(prev, op, current)
        currentNumber = formatResult(result)
        previousNumber = null
        currentOperation = null
        shouldResetDisplay = true
        return currentNumber
    }

    private fun calculate(a: Double, operation: String, b: Double): Double {
        return when (operation) {
            "+" -> a + b
            "−" -> a - b
            "×" -> a * b
            "÷" -> if (b != 0.0) a / b else 0.0
            else -> b
        }
    }

    private fun formatResult(value: Double): String {
        return if (value % 1 == 0.0 && abs(value) < 1e9) {
            String.format("%.0f", value)
        } else {
            val formatter = DecimalFormat("#.########")
            formatter.format(value)
        }
    }
}
