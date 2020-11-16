//
//  ViewController.swift
//  MessagerTest
//
//  Created by Virgil Martinez on 11/15/20.
//

import UIKit

class ViewController: UIViewController {

    private var viewModel = MessageViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        loadAllMessagesData()
    }

    private func loadAllMessagesData() {
        
        viewModel.fetchMessagesData{ [weak self] in
            print("[DEBUG] Finished fetching data")
        }
        
    }

}

