//
//  StartQuizViewController.swift
//  Quizapp
//
//  Created by Hoang Trong Kien on 11/8/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

protocol FinishQuiz: class {
    func finishQuiz(result: Int)
}

class StartQuizViewController: UIViewController {
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var clvStartQuiz: UICollectionView!
    
    weak var delegate: FinishQuiz?
    var questionData: [QuestionObj] = []
    var name = ""
    var time = 0
    var map: [Int: Bool] = [:]
    var numberCorrectAnswer = 0
    var timer: Timer?
    var totalTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0..<questionData.count {
            map[index] = false
        }
        config()
        registerCell()
        setUpQuizClv()
        startOtpTimer()
    }
    
    func config() {
        lbName.text = name
        lbTime.text = timeFormatted(time * 60)
        btnSubmit.layer.borderWidth = CGFloat(1)
    }
    
    
    private func startOtpTimer() {
        self.totalTime = time * 60 - 1
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    @objc func updateTimer() {
        print(self.totalTime)
        self.lbTime.text = self.timeFormatted(self.totalTime) // will show timer
        if totalTime != 0 {
            totalTime -= 1  // decrease counter timer
        } else {
            if let timer = self.timer {
                stopTimer(timer: timer)
            }
            submitAction()
        }
    }
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func stopTimer(timer: Timer) {
        timer.invalidate()
        self.timer = nil
    }
    
    func registerCell() {
        clvStartQuiz.register(UINib(nibName: "StartQuizCollectionViewCell", bundle: nil),
                              forCellWithReuseIdentifier: "StartQuizCollectionViewCell")
    }
    
    func setUpQuizClv() {
        clvStartQuiz.dataSource = self
        clvStartQuiz.delegate = self
        clvStartQuiz.showsVerticalScrollIndicator = false
    }
    @IBAction func actionSubmit(_ sender: Any) {
        submitAction()
    }
    
    func submitAction() {
        stopTimer(timer: timer!)
        for index in 0..<questionData.count {
            if map[index]! {
                numberCorrectAnswer += 1
            }
        }
        delegate?.finishQuiz(result: numberCorrectAnswer)
        dismiss(animated: true, completion: nil)
    }
}

extension StartQuizViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StartQuizCollectionViewCell", for: indexPath) as! StartQuizCollectionViewCell
        cell.config(questionObj: questionData[indexPath.item])
        cell.numberQuestion = indexPath.item
        cell.delegate = self
        cell.layer.borderWidth = CGFloat(1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // dynamic height & fixed width cell of collection view
        let heightQuestion = getHeightLabelWith(text: questionData[indexPath.item].question!)
        let answerQuestion1 = getHeightLabelWith(text: questionData[indexPath.item].answer![0].answer!)
        let answerQuestion2 = getHeightLabelWith(text: questionData[indexPath.item].answer![1].answer!)
        let answerQuestion3 = getHeightLabelWith(text: questionData[indexPath.item].answer![2].answer!)
        let answerQuestion4 = getHeightLabelWith(text: questionData[indexPath.item].answer![3].answer!)
        let heightCell = heightQuestion * 1.4 + answerQuestion1 + answerQuestion2 + answerQuestion3 + answerQuestion4 + 15
        return CGSize(width: collectionView.frame.size.width,
                      height: heightCell)
    }
    
    private func getHeightLabelWith(text: String) -> CGFloat {
        let question:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: clvStartQuiz.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        question.numberOfLines = 0
        question.lineBreakMode = NSLineBreakMode.byWordWrapping
        question.font = UIFont(name: "SFProText-Medium", size: 17)
        question.text = text
        question.sizeToFit()
        return question.frame.height > 30 ? question.frame.height : 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension StartQuizViewController: GetResult {
    func getResult(numberQuestion: Int, isTrue: Bool) {
        map[numberQuestion] = isTrue
    }
    
    
}
