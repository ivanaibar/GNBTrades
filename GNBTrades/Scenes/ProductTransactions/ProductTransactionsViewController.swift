//
//  ProductTransactionsViewController.swift
//  GNBTrades
//
//  Created by Ivan Aibar Romero on 05/11/2020.
//

import UIKit
import RxSwift
import RxCocoa

class ProductTransactionsViewController: UIViewController {
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private let viewModel: ProductTransactionsViewModelType
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    private let disposeBag = DisposeBag()
    
    private var transactions: Transactions { viewModel.transactions }
    
    init(viewModel: ProductTransactionsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: ProductTransactionsViewController.self),
                   bundle: Bundle(for: ProductTransactionsViewController.self))
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTotalAmount()
        setupTableView()
        bindToViewModel()
    }

}

private extension ProductTransactionsViewController {
    
    func show(error: String) {
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func setupTotalAmount() {
        totalAmountLabel.text = ""
    }
    
    func setupTableView() {
        title = "Product " + transactions.first!.sku
        tableView.register(UINib.init(nibName: "ProductTransactionsTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTransactionsTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView()
    }
    
    func bindToViewModel() {
        viewModel.error
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: show(error:)).disposed(by: disposeBag)
        viewModel.updateTotalAmount
            .subscribe({ update in
                self.updateAmountLabel()
            })
            .disposed(by: disposeBag)
        viewModel.showLoading
            .asObservable()
            .observeOn(MainScheduler.instance).bind(to: indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
        viewModel.loadData()
    }
    
    func updateAmountLabel() {
        DispatchQueue.main.async {
            if let totalAmount = self.viewModel.totalAmount {
                self.totalAmountLabel.text = "\(totalAmount) €"
                self.totalAmountLabel.fadeTransition(0.4)
            }
        }
    }
}

extension ProductTransactionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
}

extension ProductTransactionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTransactionsTableViewCell.identifier, for: indexPath) as! ProductTransactionsTableViewCell
        cell.setData(with: transactions[indexPath.row])
        return cell
    }
}
