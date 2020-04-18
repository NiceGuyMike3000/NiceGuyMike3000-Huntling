//
//  TrackerListTCCell.swift
//  Huntling
//
//  Created by Michael Schilling on 17.04.20.
//  Copyright © 2020 Michael Schilling. All rights reserved.
//

import UIKit


protocol TrackerListTVCellDelegate {
    
    func didPressCallButton(cell: UITableViewCell)
    
}



class TrackerListTVCell: UITableViewCell {
    
    
    var delegate: TrackerListTVCellDelegate?
    
    let nameLabel: UILabel = {
        let label = UILabel.init()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    
    let cityLabel: UILabel = {
        let label = UILabel.init()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    
    lazy var callButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.setImage(UIImage(systemName: "phone.arrow.up.right"), for: .normal)
        button.addTarget(self, action: #selector(handleCallButton), for: .touchUpInside)
        return button
    }()
    
    
    @objc func handleCallButton() {
        delegate?.didPressCallButton(cell: self)
    }
    
    
    
    func setup() {
        
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.5).isActive = true
        
        contentView.addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        cityLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12.5).isActive = true
        
        contentView.addSubview(callButton)
        callButton.translatesAutoresizingMaskIntoConstraints = false
        callButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        callButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        callButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        callButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        callButton.addTarget(self, action: #selector(handleCallButton), for: .touchUpInside)
        
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.clear
        
        setup()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

