//
//  HistoryViewController.swift
//  Quizapp
//
//  Created by Hoang Trong Kien on 11/7/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit
import Alamofire

class HistoryViewController: UIViewController {

    @IBOutlet weak var clvHistory: UICollectionView!
    var completedSubjectData: [CompletedSubjectResponse] = []
    lazy var idUser: String = {
        let defaults = UserDefaults.standard
        return defaults.value(forKey: "idUser") as! String
    }()
    var isDidLoad: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigation()
        registerCell()
        setUpQuizClv()
        loadData()
        isDidLoad = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !isDidLoad {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let isDataChanged = appDelegate.isDataChangedInHistoryVC
            if isDataChanged {
                loadData()
                appDelegate.toggleParamIsDataChangedInHistoryVC()
            }
        }
        isDidLoad = false
    }
    
    func setUpNavigation() {
        //self.title = "BK QUIZ"
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 180)
        navigationItem.titleView = imageView
    }

    func loadData() {
        LoadingDialog.showLoadingDialog(self)
        let parameter: Parameters = [
            "id_user": idUser
        ]
        let _ = APIManager.sharedInstance.getCompletedSubjects(queryParam: parameter) { (arrayCompletedSubjectResponse, error) in
            if let arrayCompletedSubjectResponse = arrayCompletedSubjectResponse as? ArrayCompletedSubjectResponse, let completedSubjectResponse = arrayCompletedSubjectResponse.data {
                
                self.dismiss(animated: true, completion: nil)
                self.completedSubjectData = completedSubjectResponse
                self.clvHistory.reloadData()
                
            } else if let errorMessage = error {
                
                print(errorMessage)
            }
        }
    }
    
    func registerCell() {
        clvHistory.register(UINib(nibName: "HistoryCollectionViewCell", bundle: nil),
                         forCellWithReuseIdentifier: "HistoryCollectionViewCell")
    }
    
    func setUpQuizClv() {
        clvHistory.dataSource = self
        clvHistory.delegate = self
        clvHistory.showsVerticalScrollIndicator = false
    }

}

extension HistoryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var numOfSection: Int = 0
        
        if completedSubjectData.count > 0 {
          self.clvHistory.backgroundView = nil
          numOfSection = 1
        }
        else {
          
          let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0,
                                                           width: self.clvHistory.bounds.size.width,
                                                           height: self.clvHistory.bounds.size.height))
          noDataLabel.text = "Chưa hoàn thành môn học nào cả!"
          noDataLabel.textColor = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
          noDataLabel.textAlignment = NSTextAlignment.center
          self.clvHistory.backgroundView = noDataLabel
        }
        
        return numOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return completedSubjectData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCollectionViewCell", for: indexPath) as! HistoryCollectionViewCell
        cell.config(completedSubject: completedSubjectData[indexPath.item])
        cell.layer.borderWidth = CGFloat(1)
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width * 0.95,
                      height: 120)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


