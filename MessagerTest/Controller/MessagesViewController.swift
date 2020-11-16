//
//  MessagesViewController.swift
//  MessagerTest
//
//  Created by Virgil Martinez on 11/15/20.
//

import UIKit

class MessagesViewController: UIViewController {

    @IBOutlet weak var messagesTableView: UITableView!
    private var viewModel = MessageViewModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        
        loadAllMessagesData()
    }

    private func loadAllMessagesData() {
        
        viewModel.fetchMessagesData{ [weak self] in
            print("[DEBUG] Finished fetching data")
            self?.messagesTableView.dataSource = self
            self?.messagesTableView.delegate = self
            self?.messagesTableView.reloadData()
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPaths = self.messagesTableView!.indexPathsForSelectedRows!
        let indexPath = indexPaths[0] as IndexPath
        let vc = segue.destination as! MessageDetailViewController
        vc.message = viewModel.cellForRowAt(indexPath: indexPath).first
    }
}

// MARK: - TableView
extension MessagesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageTableViewCell
        
        let message = viewModel.cellForRowAt(indexPath: indexPath)
        
        cell.setCellWithValuesOf(message.first!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toMessageView", sender: indexPath)
    }
}

