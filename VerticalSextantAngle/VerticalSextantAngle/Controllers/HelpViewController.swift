//
//  HelpViewController.swift
//  VerticalSextantAngle
//
//  Created by pmoens on 31/12/20.
//  Copyright © 2020 pmoens. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet weak var helpTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        helpTextField.text = HelpText.text
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        helpTextField.setContentOffset(.zero, animated: false)
    }

}
