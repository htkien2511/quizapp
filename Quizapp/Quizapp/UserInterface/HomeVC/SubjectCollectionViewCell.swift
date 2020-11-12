//
//  QuizCollectionViewCell.swift
//  Quizapp
//
//  Created by Hoang Trong Kien on 11/7/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

class SubjectCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lbSubject: UILabel!
    @IBOutlet weak var lbDeadline: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func config(subject: SubjectResponse) {
        lbSubject.text = subject.name
        lbDeadline.text = subject.deadline
    }

}
