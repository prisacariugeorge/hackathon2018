//
//  ViewController.swift
//  Hackathon2018
//
//  Created by Marian Prisacariu on 9/8/18.
//  Copyright © 2018 Marian Prisacariu. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift

@objcMembers
class ViewControllerVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var viewModel: GiftFinderVM!
    var disposeBag = DisposeBag()
    var tvAnimatedDataSource: RxTableViewSectionedAnimatedDataSource<GiftFinderSection>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mockInit()
        self.tableView.register(UINib(nibName: "RecommendationCell", bundle: nil), forCellReuseIdentifier: "RecommendationCell")
        self.tableView.register(UINib(nibName: "FinderTVCell", bundle: nil), forCellReuseIdentifier: "FinderTVCell")

        
        self.configureDataSource()
        
        self.viewModel.dataSource
            .asObservable()
            .subscribeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(dataSource: self.tvAnimatedDataSource))
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func mockInit() {
        let giftFinderDTO = GiftFinderDTO(recommendations: self.getRecommendation(), finders: self.getFinders())
        let viewModel = GiftFinderVM(giftFinderDTO: giftFinderDTO)
        self.viewModel = viewModel
    }
}

extension ViewControllerVC {
    func configureDataSource() {
        self.tvAnimatedDataSource =
            RxTableViewSectionedAnimatedDataSource<GiftFinderSection>(
                configureCell: { [weak self] _, _, indexPath, item in
                    guard let strongSelf = self else { return UITableViewCell() }
                    switch item.type {
                    case .recommendationCell:
                        return strongSelf.recommendationCellFor(product: item.data as! Product, atIndexPath: indexPath)
                    case .finderCell:
                        return strongSelf.finderCellFor(finders: item.data as! [Finder], atIndexPath: indexPath)
                    default:
                        return UITableViewCell()
                    }
            })
    }
    
    fileprivate func recommendationCellFor(product: Product, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "RecommendationCell", for: indexPath) as? RecommendationCell {
            cell.setupWithProduct(product)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    fileprivate func finderCellFor(finders: [Finder], atIndexPath indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "FinderTVCell", for: indexPath) as? FinderTVCell {
            cell.setupWithFinders(finders)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
