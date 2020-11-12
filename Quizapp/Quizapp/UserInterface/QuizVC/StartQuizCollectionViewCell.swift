//
//  StartQuizCollectionViewCell.swift
//  Quizapp
//
//  Created by Hoang Trong Kien on 11/8/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

protocol GetResult: class {
    func getResult(numberQuestion: Int, isTrue: Bool)
}


class StartQuizCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lbQuestion: UILabel!
    @IBOutlet var lbsAnswer: Array<UILabel>!
    @IBOutlet var btnAnswer: Array<UIButton>!
    @IBOutlet weak var stackView: UIStackView!
    
    weak var delegate: GetResult?
    var questionObj: QuestionObj?
    var numberQuestion = 0
    let check = UIImage(named: "check")
    let uncheck = UIImage(named: "uncheck")
    var isChecked: Int = -1 {
        didSet {
            switch isChecked {
            case 0:
                if oldValue == 0 { return }
                btnAnswer[0].setImage(check, for: .normal)
                btnAnswer[1].setImage(uncheck, for: .normal)
                btnAnswer[2].setImage(uncheck, for: .normal)
                btnAnswer[3].setImage(uncheck, for: .normal)
                delegate?.getResult(numberQuestion: numberQuestion, isTrue: questionObj!.correctAnswer == 0)
            case 1:
                if oldValue == 1 { return }
                btnAnswer[0].setImage(uncheck, for: .normal)
                btnAnswer[1].setImage(check, for: .normal)
                btnAnswer[2].setImage(uncheck, for: .normal)
                btnAnswer[3].setImage(uncheck, for: .normal)
                delegate?.getResult(numberQuestion: numberQuestion, isTrue: questionObj!.correctAnswer == 1)
            case 2:
                if oldValue == 2 { return }
                btnAnswer[0].setImage(uncheck, for: .normal)
                btnAnswer[1].setImage(uncheck, for: .normal)
                btnAnswer[2].setImage(check, for: .normal)
                btnAnswer[3].setImage(uncheck, for: .normal)
                delegate?.getResult(numberQuestion: numberQuestion, isTrue: questionObj!.correctAnswer == 2)
            case 3:
                if oldValue == 3 { return }
                btnAnswer[0].setImage(uncheck, for: .normal)
                btnAnswer[1].setImage(uncheck, for: .normal)
                btnAnswer[2].setImage(uncheck, for: .normal)
                btnAnswer[3].setImage(check, for: .normal)
                delegate?.getResult(numberQuestion: numberQuestion, isTrue: questionObj!.correctAnswer == 3)
            default:
                break
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func config(questionObj: QuestionObj) {
//        print(lbQuestion.bounds.size.height)
        lbQuestion.text = questionObj.question
        lbsAnswer[0].text = questionObj.answer?[0].answer
        lbsAnswer[1].text = questionObj.answer?[1].answer
        lbsAnswer[2].text = questionObj.answer?[2].answer
        lbsAnswer[3].text = questionObj.answer?[3].answer
        self.questionObj = questionObj
    }
    
    @IBAction func chooseAction(_ sender: UIButton) {
        switch sender {
        case btnAnswer[0]:
            isChecked = 0
        case btnAnswer[1]:
            isChecked = 1
        case btnAnswer[2]:
            isChecked = 2
        case btnAnswer[3]:
            isChecked = 3
            
        default:
            break
        }
    }
    
}
