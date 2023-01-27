//
//  ViewController.swift
//  Guessing Game - Roy Alameh
//
//  Created by Roy Alameh on 1/26/23.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var numsList = [Int]()
    var totalNums = 100
    var randomNum = -1
    var lowerBound = 1
    var selectedNum = -1
    var guesses = 0
    var found = false

    @IBOutlet weak var pickerOutlet: UIPickerView!
    @IBOutlet weak var informationOutlet: UILabel!
    @IBOutlet weak var resetOutlet: UIButton!
    
    override func viewDidLoad() {
        pickerOutlet.delegate = self
        pickerOutlet.dataSource = self
        
        super.viewDidLoad()
        resetOutlet.isHidden = true
        reset()
    }
    
    @IBAction func submitAction(_ sender: UIButton) {
        var displayText = ""
        if selectedNum < randomNum {
            let distance = randomNum - selectedNum
            if distance <= 10 {
                displayText = "Extremely close! Guess is too low."
            }
            else if distance <= 20 {
                displayText = "Very close! Guess is too low."
            }
            else if distance <= 30 {
                displayText = "Pretty close! Guess is too low."
            }
            else if distance <= 40 {
                displayText = "Somewhat close. Guess is too low."
            }
            else if distance <= 50 {
                displayText = "Pretty far off. Guess is too low."
            }
            else {
                displayText = "Very far off. Guess is far too low."
            }
            var i = 0
            let topRange = numsList.firstIndex(of: selectedNum)!
            while i <= topRange {
                numsList.remove(at: 0)
                i += 1
            }
            pickerOutlet.reloadAllComponents()
            pickerOutlet.selectRow(0, inComponent: 0, animated: false)
            selectedNum = numsList[0]
            guesses += 1
        }
        else if selectedNum > randomNum {
            let distance = selectedNum - randomNum
            if distance <= 10 {
                displayText = "Extremely close! Guess is too high."
            }
            else if distance <= 20 {
                displayText = "Very close! Guess is too high."
            }
            else if distance <= 30 {
                displayText = "Pretty close! Guess is too high."
            }
            else if distance <= 40 {
                displayText = "Somewhat close. Guess is too high."
            }
            else if distance <= 50 {
                displayText = "Pretty far off. Guess is too high."
            }
            else {
                displayText = "Very far off. Guess is far too high."
            }
            var i = numsList.firstIndex(of: selectedNum)!
            let iFinal = i
            let finalCount = numsList.count
            while i < finalCount {
                numsList.remove(at: iFinal)
                i += 1
            }
            pickerOutlet.reloadAllComponents()
            selectedNum = numsList[numsList.count - 1]
            guesses += 1
            
        }
        else if !found {
            guesses += 1
            found = true
            displayText = "Correct! It took you \(guesses) attempt(s)."
            numsList = [Int]()
            numsList.append(randomNum)
            pickerOutlet.reloadAllComponents()
            selectedNum = numsList[0]
            resetOutlet.isHidden = false
        }
        else {
            displayText = "Correct! It took you \(guesses) attempt(s)."
        }
        informationOutlet.text = displayText
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        numsList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedNum = numsList[row]
    }
        
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        String(numsList[row])
    }
    
    func reset() {
        numsList = [Int]()
        totalNums = 100
        randomNum = -1
        lowerBound = 1
        selectedNum = -1
        guesses = 0
        found = false
        randomNum = Int.random(in: 1...(totalNums + 1))
        for i in lowerBound...(lowerBound + totalNums - 1) {
            numsList.append(i)
        }
        pickerOutlet.reloadAllComponents()
        informationOutlet.text = "Select a number and hit submit in order to guess"
        print("Number to guess: \(randomNum)")
    }

    @IBAction func resetAction(_ sender: UIButton) {
        reset()
    }
}
