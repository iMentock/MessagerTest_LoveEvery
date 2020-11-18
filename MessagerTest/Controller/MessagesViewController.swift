//
//  MessagesViewController.swift
//  MessagerTest
//
//  Created by Virgil Martinez on 11/15/20.
//

import UIKit

class MessagesViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: Instantiate
    private var viewModel = MessageViewModel()
    private let refreshControl = UIRefreshControl()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Set delegates
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        searchBar.delegate = self
        
        configureUI()
        configureRefreshAction()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAllMessagesData()
    }
    
    // MARK: Helpers
    @objc func addTapped() {
        self.performSegue(withIdentifier: "toCreateMessage", sender: self)
    }
    
    private func configureUI() {
        // Customize bar button to conform to color scheme and add action
        let barButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addTapped))
        barButton.tintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        navigationItem.rightBarButtonItem = barButton
        
        // Remove border for more flat look and customize search field color
        searchBar.backgroundImage = UIImage()
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = #colorLiteral(red: 0.9971526265, green: 0.9834153056, blue: 0.9434879422, alpha: 1)
            textfield.textColor = #colorLiteral(red: 0.3494816422, green: 0.3450542688, blue: 0.3407886624, alpha: 1)
        }
    }
    
    private func configureRefreshAction() {
        // Allow user to pull down to refresh
        refreshControl.addTarget(self, action: #selector(loadAllMessagesData), for: .valueChanged)
        refreshControl.tintColor = #colorLiteral(red: 0.3261150122, green: 0.8584199548, blue: 0.8048429489, alpha: 1)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching messages...", attributes: [NSAttributedString.Key.foregroundColor: UIColor(cgColor: #colorLiteral(red: 0.3494816422, green: 0.3450542688, blue: 0.3407886624, alpha: 1))])
        if #available(iOS 10.0, *) {
            messagesTableView.refreshControl = refreshControl
        } else {
            messagesTableView.addSubview(refreshControl)
        }
    }

    /**
     Loads all messages from AWS service with no regard to user and updates table view.
     */
    @objc private func loadAllMessagesData() {
        searchBar.text = nil
        viewModel.getAllMessagesData { [weak self] error in
            
            if let _ = error {
                DispatchQueue.main.async {
                    self?.presentError(withMessage: "There was an error retrieving the messages. Please try again later.")
                }
            } else {
                self?.messagesTableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        
        }
    }
    
    /**
     Loads all messages by one user from AWS service and updates table view.
     
     - Parameter forUser: the username to filter/search by.
     */
    private func loadMessageData(forUser: String) {
        viewModel.getAllMessagesData(forUser: forUser) { [weak self] error in
            
            if let _ = error {
                DispatchQueue.main.async {
                    self?.presentError(withMessage: "There was an error getting the messages for user \(forUser). Please try again later.")
                }
                
            } else {
                self?.messagesTableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
           
        }
    }
    
    private func presentError(withMessage: String) {
        let alert = UIAlertController(title: "Sorry!", message: withMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
        guard let searchBarText = searchBar.text else { return }
        if searchBarText.count < 1 {
            return
        }
        searchBar.resignFirstResponder()
        loadMessageData(forUser: searchBarText)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Catch if user eliminates text in search bar and refresh to ALL messages
        if searchText == "" {
            loadAllMessagesData()
        }
    }
}

// MARK: - Segue
extension MessagesViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        
        // This is to fix the behavior of one preperation persisting for next prep
        case "toCreateMessage":
            let backItem = UIBarButtonItem()
            backItem.title = "Cancel"
            backItem.tintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            navigationItem.backBarButtonItem = backItem
            break
            
        case "toMessageView":
            let indexPaths = self.messagesTableView!.indexPathsForSelectedRows!
            let indexPath = indexPaths[0] as IndexPath
            let vc = segue.destination as! MessageDetailViewController
            vc.message = viewModel.cellForRowAt(indexPath: indexPath)
            
            let backItem = UIBarButtonItem()
            backItem.title = "Messages"
            backItem.tintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            navigationItem.backBarButtonItem = backItem
            
            break
            
        default:
            break
        }
        
    }
}
