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
    
    let districtLabel: UILabel = {
        let label = UILabel.init()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    
    let proximityLabel: UILabel = {
        let label = UILabel.init()
        label.numberOfLines = 1
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 17)
        //label.text = "prox"
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
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        
        contentView.addSubview(districtLabel)
        districtLabel.translatesAutoresizingMaskIntoConstraints = false
        districtLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        districtLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 13).isActive = true
        
        contentView.addSubview(callButton)
        callButton.translatesAutoresizingMaskIntoConstraints = false
        callButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        callButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        callButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        callButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        callButton.addTarget(self, action: #selector(handleCallButton), for: .touchUpInside)
        
        contentView.addSubview(proximityLabel)
        proximityLabel.translatesAutoresizingMaskIntoConstraints = false
        proximityLabel.rightAnchor.constraint(equalTo: callButton.leftAnchor, constant: -20).isActive = true
        proximityLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
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

