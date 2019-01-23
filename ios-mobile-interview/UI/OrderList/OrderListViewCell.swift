//
//  OrderListViewCell.swift
//  ios-mobile-interview
//
//  Created by Boris Bengus on 29.08.2018.
//  Copyright © 2018 Portal OOO. All rights reserved.
//

import UIKit

final class OrderListViewCell: UITableViewCell {
    // MARK: Subviews
    fileprivate let orderIdLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    fileprivate let dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .right
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    fileprivate let addressLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(orderIdLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(addressLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: UITableViewCell overriding
    override func prepareForReuse() {
        super.prepareForReuse()
        
        orderIdLabel.text = nil
        dateLabel.text = nil
        addressLabel.text = nil
    }
    
    
    // MARK: Applying model
    func applyOrder(_ order: Order) {
        orderIdLabel.text = String(format: "OrderNumberFormat_%@".localized, String(order.orderId))
        dateLabel.text = String(describing: order.date)
        addressLabel.text = order.address
    }
    
    
    // MARK: Life cycle
    override func layoutSubviews() {
        super.layoutSubviews()
     
        let insets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        let insettedBounds = contentView.bounds.inset(by: insets)
        
        let (firstLineFrame, secondLineFrame) = insettedBounds.divided(
            atDistance: insettedBounds.height / 2.0,
            from: .minYEdge
        )
        
        let (orderIdFrame, dateFrame) = firstLineFrame.divided(
            atDistance: firstLineFrame.width * 0.3,
            from: .minXEdge
        )
        
        orderIdLabel.frame = orderIdFrame
        dateLabel.frame = dateFrame
        addressLabel.frame = secondLineFrame
    }
}
