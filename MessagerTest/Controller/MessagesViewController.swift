//
//  MessagesViewController.swift
//  MessagerTest
//
//  Created by Virgil Martinez on 11/15/20.
//

import UIKit

class MessagesViewController: UIViewController {

    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var viewModel = MessageViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        searchBar.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAllMessagesData()
    }
    
    @objc func addTapped() {
        self.performSegue(withIdentifier: "toCreateMessage", sender: self)
    }

    private func loadAllMessagesData() {
        viewModel.getAllMessagesData { [weak self] in
            self?.messagesTableView.reloadData()
        }
    }
    
    private func loadMessageData(forUser: String) {
        viewModel.getAllMessagesData(forUser: forUser) { [weak self] in
            self?.messagesTableView.reloadData()
        }
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
        
        cell.setCellWithValuesOf(message)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toMessageView", sender: indexPath)
    }
}

// MARK: - Search Bar
extension MessagesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search pressed....")
        
        // TODO: move into view model
        let apiService = ApiService()
        
        guard let searchBarText = searchBar.text else { return }
        
        loadMessageData(forUser: searchBarText)
    }
}

// MARK: - Segue
extension MessagesViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        
        case "toCreateMessage":
            let backItem = UIBarButtonItem()
            backItem.title = "Cancel"
            backItem.tintColor = UIColor.systemRed
            navigationItem.backBarButtonItem = backItem
            break
            
        case "toMessageView":
            let indexPaths = self.messagesTableView!.indexPathsForSelectedRows!
            let indexPath = indexPaths[0] as IndexPath
            let vc = segue.destination as! MessageDetailViewController
            vc.message = viewModel.cellForRowAt(indexPath: indexPath)
            
            let backItem = UIBarButtonItem()
            backItem.title = "Messages"
            backItem.tintColor = UIColor.systemBlue
            navigationItem.backBarButtonItem = backItem
            
            break
            
        default:
            break
        }
        
    }
}
