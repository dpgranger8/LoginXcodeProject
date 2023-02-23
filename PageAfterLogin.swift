//
//  PageAfterLogin.swift
//  Login
//
//  Created by David Granger on 2/23/23.
//

import UIKit

class PageAfterLogin: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = dataToPass
    }

    @IBOutlet weak var descriptionLabel: UILabel!
}
