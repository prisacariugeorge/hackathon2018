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
import RealmSwift

@objcMembers
class ViewControllerVC: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var viewModel: GiftFinderVM!
    var disposeBag = DisposeBag()
    var tvAnimatedDataSource: RxTableViewSectionedAnimatedDataSource<GiftFinderSection>!
    
    var realm: Realm? = nil
    var items: Results<Product>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "RecommendationCell", bundle: nil), forCellReuseIdentifier: "RecommendationCell")
        self.tableView.register(UINib(nibName: "FinderTVCell", bundle: nil), forCellReuseIdentifier: "FinderTVCell")

        self.configureDataSource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = "Welcome"
        
        if let _ = SyncUser.current {
            self.mockInit()
        } else {
            let alertController = UIAlertController(title: "Login to Realm Cloud", message: "Supply a nice nickname!", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Login", style: .default, handler: { [unowned self]
                alert -> Void in
                let textField = alertController.textFields![0] as UITextField
                let creds = SyncCredentials.nickname(textField.text!, isAdmin: true)
                
                SyncUser.logIn(with: creds, server: Constants.AUTH_URL, onCompletion: { [weak self](user, err) in
                    if let _ = user {
                        self?.mockInit()
                    } else if let error = err {
                        fatalError(error.localizedDescription)
                    }
                })
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
                textField.placeholder = "A Name for your user"
            })
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func mockInit() {
        let syncConfig = SyncConfiguration(user: SyncUser.current!, realmURL: Constants.REALM_URL)
        self.realm = try? Realm(configuration: Realm.Configuration(syncConfiguration: syncConfig, objectTypes:[Product.self]))
        self.items = realm?.objects(Product.self).sorted(byKeyPath: "timestamp", ascending: false)
        
        let giftFinderDTO = GiftFinderDTO(products: self.getProducts(self.items), finders: self.getFinders())
        var viewModel = GiftFinderVM(giftFinderDTO: giftFinderDTO)
        self.viewModel = viewModel
        
        self.viewModel.dataSource
            .asObservable()
            .subscribeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(dataSource: self.tvAnimatedDataSource))
            .disposed(by: disposeBag)
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
            cell.delegate = self
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension ViewControllerVC: FinderTVCellDelegate {
    func finderTVCellDelegateDidSelectFinder(_ finder: Finder) {
        self.items = realm?.objects(Product.self).sorted(byKeyPath: "timestamp", ascending: false)
        
        let giftFinderDTO = GiftFinderDTO(products: self.getProducts(self.items), finders: self.getFinders())
        if finder.name == "Men" {
            giftFinderDTO.products = self.getProducts(self.items).filter { $0.sectionType == 1 }
        } else if finder.name == "Woman" {
            giftFinderDTO.products = self.getProducts(self.items).filter { $0.sectionType == 2 }
        }
        
        self.viewModel.giftFinderDTO.value = giftFinderDTO
    }
}
