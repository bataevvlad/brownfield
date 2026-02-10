package com.brownfield.calculator

import android.content.Intent
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import androidx.appcompat.app.AppCompatActivity
import com.brownfield.calculator.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    private val calculator = CalculatorLogic()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        setSupportActionBar(binding.toolbar)
        supportActionBar?.title = "Calculator"

        setupButtonListeners()
    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        menuInflater.inflate(R.menu.main_menu, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        return when (item.itemId) {
            R.id.action_info -> {
                showInfoScreen()
                true
            }
            else -> super.onOptionsItemSelected(item)
        }
    }

    private fun showInfoScreen() {
        // Launch React Native Info screen
        val intent = Intent(this, ReactNativeActivity::class.java)
        startActivity(intent)
    }

    private fun setupButtonListeners() {
        // Number buttons
        binding.btn0.setOnClickListener { onButtonClick("0") }
        binding.btn1.setOnClickListener { onButtonClick("1") }
        binding.btn2.setOnClickListener { onButtonClick("2") }
        binding.btn3.setOnClickListener { onButtonClick("3") }
        binding.btn4.setOnClickListener { onButtonClick("4") }
        binding.btn5.setOnClickListener { onButtonClick("5") }
        binding.btn6.setOnClickListener { onButtonClick("6") }
        binding.btn7.setOnClickListener { onButtonClick("7") }
        binding.btn8.setOnClickListener { onButtonClick("8") }
        binding.btn9.setOnClickListener { onButtonClick("9") }

        // Operation buttons
        binding.btnAdd.setOnClickListener { onButtonClick("+") }
        binding.btnSubtract.setOnClickListener { onButtonClick("−") }
        binding.btnMultiply.setOnClickListener { onButtonClick("×") }
        binding.btnDivide.setOnClickListener { onButtonClick("÷") }
        binding.btnEquals.setOnClickListener { onButtonClick("=") }

        // Other buttons
        binding.btnClear.setOnClickListener { onButtonClick("C") }
        binding.btnToggleSign.setOnClickListener { onButtonClick("±") }
        binding.btnPercent.setOnClickListener { onButtonClick("%") }
        binding.btnDecimal.setOnClickListener { onButtonClick(".") }
    }

    private fun onButtonClick(input: String) {
        val result = calculator.processInput(input)
        binding.displayText.text = result
    }
}
