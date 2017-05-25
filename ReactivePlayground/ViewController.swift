//
//  ViewController.swift
//  ReactivePlayground
//
//  Created by Tushar Gupta on 22/05/17.
//  Copyright © 2017 Tushar Gupta. All rights reserved.
//

import UIKit

class ReactiveStyleRowCell : UICollectionViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var rowLabel : UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = UIColor.white
        
        self.rowLabel = UILabel()
        
        self.rowLabel?.font = UIFont.systemFont(ofSize: 16)
        if let row = self.rowLabel {
            self.contentView.addSubview(row)
            self.rowLabel?.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .leading)
            self.rowLabel?.autoPinEdge(.leading, to: .leading, of: self.contentView, withOffset: 15)
        }
    }
    
    func bind(data: String) {
        self.rowLabel?.text = data
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var reactiveStyleList: UICollectionView!
    
    enum ReactiveStyle : String {
        case imperative = "Imperative Style"
        case rx = "Declarative Style using RxSwift"
    }
    
    let reactiveStyleContentList : [ReactiveStyle] = [
        ReactiveStyle.imperative,
        ReactiveStyle.rx,
    ] 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reactiveStyleList.register(ReactiveStyleRowCell.self, forCellWithReuseIdentifier: ReactiveStyleRowCell.reuseIdentifier)
        
        reactiveStyleList.dataSource = self
        reactiveStyleList.delegate = self
    }
    
    func getVC(style: ReactiveStyle) -> UIViewController {
        
        switch style {
        case .imperative:
            return ImperativeSignupViewController(presentationModel: ImperativeSignupPresentationModel())
        case .rx: 
            return RxSignupViewController(presentationModel: RxSignupPresentationModel())
        }
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.screenWidthWith(height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reactiveStyleContentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReactiveStyleRowCell.reuseIdentifier, for: indexPath) as! ReactiveStyleRowCell
        
        cell.bind(data: reactiveStyleContentList[indexPath.row].rawValue)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(getVC(style: reactiveStyleContentList[indexPath.row]), animated: true)
    }
}

