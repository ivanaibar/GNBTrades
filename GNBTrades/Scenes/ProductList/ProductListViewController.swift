//
//  ProductListViewController.swift
//  GNBTrades
//
//  Created by Ivan Aibar Romero on 03/11/2020.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ProductListViewController: UIViewController {
    
    private let viewModel: ProductListViewModelType
    private let disposeBag = DisposeBag()
    
    private var products: Transactions { viewModel.dataList }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    init(viewModel: ProductListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ProductListViewController.self),
                   bundle: Bundle(for: ProductListViewController.self))
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindToViewModel()
    }
}

private extension ProductListViewController {
    
    func show(error: String) {
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func setupTableView() {
        title = "Select a product"
        tableView.register(UINib.init(nibName: "ProductListTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductListTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView()
    }
    
    func bindToViewModel() {
        viewModel.reloadFields
            .asDriver(onErrorJustReturn: .all)
            .drive(onNext: table(reload:))
            .disposed(by: disposeBag)
        viewModel.error
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: show(error:)).disposed(by: disposeBag)
        viewModel.isDataLoading
            .asObservable()
            .observeOn(MainScheduler.instance).bind(to: indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        viewModel.loadData()
    }
    
    func table(reload: TableReload) {
        switch reload {
        case .all:
            UIView.transition(with: tableView,
                              duration: 0.35,
                              options: .transitionCrossDissolve,
                              animations: { self.tableView.reloadData() })
        case let .insertItems(paths): tableView.insertItemsAtIndexPaths(paths, animationStyle: .automatic)
        }
    }
}

extension ProductListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
}

extension ProductListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductListTableViewCell.identifier, for: indexPath) as! ProductListTableViewCell
        cell.setData(with: products[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productTransactions = viewModel.getProductTransactions(productSku: products[indexPath.row].sku)
        AppNavigator.shared.push(.productTransactions(productTransactions))
    }
    
}
