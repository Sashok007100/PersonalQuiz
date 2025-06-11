//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Alexandr Artemov on 06.06.2025.
//

import UIKit

final class ResultViewController: UIViewController {

    @IBOutlet var animalEmojiLabel: UILabel!
    @IBOutlet var animalDescriptionLabel: UILabel!
    
    var answers: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        findMostFrequentAnimal()
    }

    @IBAction func doneButtonAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    private func findMostFrequentAnimal() {
        let mostFrequentAnimal = calculateMostFrequentAnimal(from: answers)
        updateUI(with: mostFrequentAnimal)
    }
    
    private func calculateMostFrequentAnimal(from answers: [Answer]) -> Animal? {
        let animalCounts = answers.map{ $0.animal }
            .reduce(into: [:]) { result, animal in
            result[animal, default: 0] += 1
        }
        
        return animalCounts.max(by: { $0.value  < $1.value })?.key
    }
    
    private func updateUI(with animal: Animal?) {
        guard let animal = animal else { return }
        animalEmojiLabel.text = "Вы - \(animal.rawValue)"
        animalDescriptionLabel.text = animal.definition
    }
}
