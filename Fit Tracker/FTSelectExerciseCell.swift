//
//  FTSelectExerciseCell.swift
//  Fit Tracker
//
//  Created by Casey McLewin on 2018-07-13.
//  Copyright © 2018 Casey McLewin. All rights reserved.
//

import UIKit

protocol FTSelectExerciseCellDelegate: class {
    func selectExerciseCellDidTapOnMoreInfo(_ selectExerciseCell: FTSelectExerciseCell)
}

class FTSelectExerciseCell: UITableViewCell {

    @IBOutlet private weak var selectionImageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    public var exercise: FTExercise?
    
    public weak var delegate: FTSelectExerciseCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainLabel.font = FTFonts.body
        detailLabel.font = FTFonts.description
        detailLabel.textColor = FTColours.descriptionText
    }
    
    public static func getNib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectionImageView.image = selected ? #imageLiteral(resourceName: "checkmak-filled-blue") : #imageLiteral(resourceName: "empty-circle")
    }

    @IBAction private func handleInfoTap(_ sender: FTButton) {
        
    }
}
