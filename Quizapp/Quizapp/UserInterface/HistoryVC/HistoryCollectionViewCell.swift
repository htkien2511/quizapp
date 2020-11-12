//
//  HistoryCollectionViewCell.swift
//  Quizapp
//
//  Created by Hoang Trong Kien on 11/11/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lbSubject: UILabel!
    @IBOutlet weak var lbCompletedTime: UILabel!
    @IBOutlet weak var lbPoint: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(completedSubject: CompletedSubjectResponse) {
        lbSubject.text = completedSubject.name
        lbCompletedTime.text = completedSubject.completedDay
        lbPoint.text = "\(String(describing: completedSubject.point!))/\(String(describing: completedSubject.maxPoint!))"
    }
}
