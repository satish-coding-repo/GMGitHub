//
//  GMTableViewcellTableViewCell.swift
//  GMGitProject
//
//  Created by Satish on 17/01/21.
//

import UIKit

class GMTableViewcellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var commentLablel: UILabel!
    @IBOutlet weak var authorNamelabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    func initializeDataWithModel(_ commit: GMCommit) {
        commentLablel.text = commit.commit.message
        authorNamelabel.text = commit.commit.author.name
        dateLabel.text = commit.commit.author.date
    }
}

