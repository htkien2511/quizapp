//
//  HomeViewController.swift
//  Quizapp
//
//  Created by Hoang Trong Kien on 11/7/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    
    @IBOutlet weak var clvQuiz: UICollectionView!
    var subjectData: [SubjectResponse] = []
    lazy var idUser: String = {
        let defaults = UserDefaults.standard
        return defaults.value(forKey: "idUser") as! String
    }()
    var isDidLoad: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Home View Controler")
        print(navigationController)
        setUpNavigation()
        registerCell()
        setUpQuizClv()
        loadData()
        isDidLoad = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isDidLoad {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let isDataChanged = appDelegate.isDataChangedInHomeVC
            if isDataChanged {
                loadData()
                appDelegate.toggleParamIsDataChangedInHomeVC()
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
        let _ = APIManager.sharedInstance.getValidSubjects(queryParam: parameter) { (subjectResponse, error) in
            if let subjectResponse = subjectResponse as? ArraySubjectResponse {
                self.dismiss(animated: true, completion: nil)
                self.subjectData = subjectResponse.data!
                self.clvQuiz.reloadData()
                
            } else if let errorMessage = error {
                
                print(errorMessage)
            }
        }
    }
    
    func registerCell() {
        clvQuiz.register(UINib(nibName: "SubjectCollectionViewCell", bundle: nil),
                         forCellWithReuseIdentifier: "SubjectCollectionViewCell")
    }
    
    func setUpQuizClv() {
        clvQuiz.dataSource = self
        clvQuiz.delegate = self
        clvQuiz.showsVerticalScrollIndicator = false
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var numOfSection: Int = 0
        
        if subjectData.count > 0 {
          self.clvQuiz.backgroundView = nil
          numOfSection = 1
        }
        else {
          
          let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0,
                                                           width: self.clvQuiz.bounds.size.width,
                                                           height: self.clvQuiz.bounds.size.height))
          noDataLabel.text = "Chưa có dữ liệu!"
          noDataLabel.textColor = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
          noDataLabel.textAlignment = NSTextAlignment.center
          self.clvQuiz.backgroundView = noDataLabel
        }
        
        return numOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subjectData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubjectCollectionViewCell", for: indexPath) as! SubjectCollectionViewCell
        cell.config(subject: subjectData[indexPath.item])
        cell.layer.borderWidth = CGFloat(1)
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width * 0.95,
                      height: 140)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let quizVC = QuizViewController()
        quizVC.data = subjectData[indexPath.item]
        quizVC.indexSubject = indexPath.item
        navigationController?.pushViewController(quizVC, animated: true)
//        let viewController = UINavigationController(rootViewController: quizVC)
//        viewController.modalPresentationStyle = .fullScreen
//        present(viewController, animated: false, completion: nil)
    }
}

