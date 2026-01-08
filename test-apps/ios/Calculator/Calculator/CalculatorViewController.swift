import UIKit
import ReactBrownfield

class CalculatorViewController: UIViewController {

    private let calculator = CalculatorLogic()

    private let displayLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 64, weight: .light)
        label.textColor = .white
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let buttonTitles: [[String]] = [
        ["C", "±", "%", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "−"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]

    private var buttons: [[UIButton]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        title = "Calculator"
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        let infoButton = UIBarButtonItem(
            title: "Info",
            style: .plain,
            target: self,
            action: #selector(infoButtonTapped)
        )
        navigationItem.rightBarButtonItem = infoButton
    }

    private func setupUI() {
        view.backgroundColor = .black

        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 12
        mainStack.distribution = .fill
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(mainStack)

        // Display container
        let displayContainer = UIView()
        displayContainer.addSubview(displayLabel)
        displayContainer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            displayLabel.leadingAnchor.constraint(equalTo: displayContainer.leadingAnchor, constant: 20),
            displayLabel.trailingAnchor.constraint(equalTo: displayContainer.trailingAnchor, constant: -20),
            displayLabel.bottomAnchor.constraint(equalTo: displayContainer.bottomAnchor),
            displayLabel.heightAnchor.constraint(equalToConstant: 80)
        ])

        mainStack.addArrangedSubview(displayContainer)

        // Button rows
        for row in buttonTitles {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 12
            rowStack.distribution = .fillEqually

            var rowButtons: [UIButton] = []

            for title in row {
                let button = createButton(title: title)
                rowStack.addArrangedSubview(button)
                rowButtons.append(button)

                // Make "0" button double width
                if title == "0" {
                    button.widthAnchor.constraint(equalTo: rowStack.widthAnchor, multiplier: 0.5, constant: -6).isActive = true
                }
            }

            buttons.append(rowButtons)
            mainStack.addArrangedSubview(rowStack)
            rowStack.heightAnchor.constraint(equalToConstant: 80).isActive = true
        }

        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            displayContainer.heightAnchor.constraint(equalToConstant: 120)
        ])
    }

    private func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        button.layer.cornerRadius = 40
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false

        switch title {
        case "C", "±", "%":
            button.backgroundColor = UIColor(white: 0.65, alpha: 1)
            button.setTitleColor(.black, for: .normal)
        case "÷", "×", "−", "+", "=":
            button.backgroundColor = UIColor.systemOrange
            button.setTitleColor(.white, for: .normal)
        default:
            button.backgroundColor = UIColor(white: 0.2, alpha: 1)
            button.setTitleColor(.white, for: .normal)
        }

        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

        return button
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }

        let result = calculator.processInput(title)
        displayLabel.text = result
    }

    @objc private func infoButtonTapped() {
        // Present the React Native Info screen using ReactBrownfield framework
        let reactView = ReactBrownfieldRootViewManager.shared.loadView(
            moduleName: "main",
            initialProps: nil,
            launchOptions: nil
        )

        let reactVC = UIViewController()
        reactVC.view = reactView
        reactVC.modalPresentationStyle = .fullScreen
        present(reactVC, animated: true)
    }
}
