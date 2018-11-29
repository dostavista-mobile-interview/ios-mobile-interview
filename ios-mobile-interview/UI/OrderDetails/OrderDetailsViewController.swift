//
//  OrderDetailsViewController.swift
//  ios-mobile-interview
//
//  Created by Boris Bengus on 29.08.2018.
//  Copyright © 2018 Portal OOO. All rights reserved.
//

import UIKit

final class OrderDetailsViewController: UIViewController {
    // MARK: Subviews
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.keyboardDismissMode = .interactive
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
        }
        
        return scrollView
    }()
    
    fileprivate lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    fileprivate lazy var orderIdLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.lineBreakMode = .byTruncatingTail
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        return label
    }()
    
    fileprivate lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.lineBreakMode = .byTruncatingTail
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        return label
    }()
    
    fileprivate lazy var addressLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.lineBreakMode = .byTruncatingTail
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        return label
    }()
    
    fileprivate lazy var textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    
    // MARK: Dependencies
    fileprivate let order: Order
    
    
    // MARK: Init
    init(order: Order) {
        self.order = order
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Private
    fileprivate func reload() {
        orderIdLabel.text = String(format: "OrderNumberFormat_%@".localized, String(order.orderId))
        dateLabel.text = String(describing: order.date)
        addressLabel.text = order.address
        textLabel.text = order.text
    }
    
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = String(format: "OrderNumberFormat_%@".localized, String(order.orderId))
        view.backgroundColor = .white
        edgesForExtendedLayout = []
        
        view.addSubview(scrollView)
        scrollView.constraintsToEdges(on: view)
        
        scrollView.addSubview(stackView)
        let insets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 10)
        stackView.constraintsToEdges(on: scrollView, insets: insets)
        stackView.widthAnchor.constraint(
            equalTo: scrollView.widthAnchor,
            multiplier: 1,
            constant: -(insets.left + insets.right)
            ).isActive = true
        
        stackView.addArrangedSubview(orderIdLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(addressLabel)
        stackView.addArrangedSubview(textLabel)
        
        reload()
    }
}
