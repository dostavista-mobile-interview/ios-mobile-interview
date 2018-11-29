//
//  OrderListViewController
//  ios-mobile-interview
//
//  Created by Boris Bengus on 28.08.2018.
//  Copyright © 2018 Portal OOO. All rights reserved.
//

import UIKit

fileprivate let OrderCellIdentidier = "OrderCell"
fileprivate let OrderCellHeight: CGFloat = 75

final class OrderListViewController: UIViewController {
    // MARK: Dependencies
    fileprivate let orderDataProvider: OrderDataProvider
    
    
    // MARK: Init
    init(orderDataProvider: OrderDataProvider) {
        self.orderDataProvider = orderDataProvider
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Subviews
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        // iOS 11 top inset
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
        } else {
            // Fallback on earlier versions
        }
        // iOS 11 Floating TableView
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .interactive
        return tableView
    }()
    
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "OrderListNavigationTitle".localized
        view.backgroundColor = .white
        edgesForExtendedLayout = []
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        update()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    
    // MARK: Private
    fileprivate var orders = [Order]()
    
    fileprivate func update() {
        orderDataProvider.updateOrders() { [weak self] orders, error in
            guard let strongSelf = self else { return }
            
            if let error = error {
                let alertController = UIAlertController(
                    title: "Error".localized,
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                strongSelf.present(alertController, animated: true, completion: nil)
                return
            }
            
            strongSelf.orders = orders
            strongSelf.reload()
        }
    }
    
    fileprivate func reload() {
        tableView.reloadData()
    }
    
    fileprivate func openOrderDetails(withOrder order: Order) {
        let orderDetailsViewController = OrderDetailsViewController(order: order)
        navigationController?.pushViewController(orderDetailsViewController, animated: true)
    }
}


// MARK: Специально для любителей все в отдельном extension писать, "чтобы глаза не мозолило"
extension OrderListViewController:
    UITableViewDataSource,
    UITableViewDelegate
{
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let reusableCell = tableView.dequeueReusableCell(withIdentifier: OrderCellIdentidier) {
            return reusableCell
        } else {
            let cell = OrderListViewCell(style: .default, reuseIdentifier: OrderCellIdentidier)
            return cell
        }
    }
    
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return OrderCellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let order = orders[indexPath.row]
        let cell = cell as! OrderListViewCell
        cell.applyOrder(order)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let order = orders[indexPath.row]
        openOrderDetails(withOrder: order)
    }
}

