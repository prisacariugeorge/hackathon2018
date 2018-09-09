//
//  FinderTVCell.swift
//  Hackathon2018
//
//  Created by Marian Prisacariu on 9/8/18.
//  Copyright © 2018 Marian Prisacariu. All rights reserved.
//

@objc protocol FinderTVCellDelegate {
    func finderTVCellDelegateDidSelectFinder(_ finder: Finder)
    @objc optional func finderTVCellDelegateDidSelectCategory()
    @objc optional func finderTVCellDelegateDidSelectPrice()
}

import UIKit

class FinderTVCell: UITableViewCell {
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var filterView: UIView!
    var finders: [Finder] = []
    
    var delegate: FinderTVCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.registerReusable(withClass: FinderCVCell.self, fromNib: true)
        
    }
    
    public func setupWithFinders(_ finders: [Finder]) {
        self.finders = finders
        self.collectionView.reloadData()
    }
    
    @IBAction func categoryButtonPressed(_ sender: Any) {
        if self.delegate?.finderTVCellDelegateDidSelectCategory != nil {
            self.delegate?.finderTVCellDelegateDidSelectCategory!()
        }
        
    }
    @IBAction func priceButtonPressed(_ sender: Any) {
        if self.delegate?.finderTVCellDelegateDidSelectPrice != nil {
            self.delegate?.finderTVCellDelegateDidSelectPrice!()
        }
    }
}

extension FinderTVCell: UICollectionViewDataSource, UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.finders.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FinderCVCell", for: indexPath) as? FinderCVCell {
            let finder: Finder = self.finders[indexPath.row]
            cell.setupWithFinder(finder)
            return cell
        } else {
            return UICollectionViewCell()
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        for value in self.finders {
            value.enlarge = false
        }
        let finder: Finder = self.finders[indexPath.row]
        finder.enlarge = true
        self.delegate?.finderTVCellDelegateDidSelectFinder(finder)
        collectionView.reloadData()
    }
}

