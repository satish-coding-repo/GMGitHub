//
//  HomeViewController.swift
//  GMGitProject
//
//  Created by Satish on 17/01/21.
//

import UIKit
import Network

class HomeViewController: UIViewController {
    // MARK: - Base URL
    let baseURL = "https://api.github.com/repos/"
    
    @IBOutlet weak var commitsTableView: UITableView!
    
    private var commits: GMCommits = [] {
        didSet {
            DispatchQueue.main.async {
                self.commitsTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        monitornetwork()
    }
    
    // MARK: - Network Monitor
    private func monitornetwork() {
        //All type of network
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.getCommentsDataFromServer(repo: "Explore", owner: "satish-coding-repo")
            }
            else {
                self.errorAlertWithMessage(self, message: "You Disconnected from the Internet, Please check your connectivity", title: "Internet Alert")
            }
        }
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
    
    // MARK: - Commits Service Call
    func getCommentsDataFromServer(repo: String, owner: String) {
        let url = baseURL + owner + "/" + repo + "/" + "commits"
        let networkManager = GMServiceManager(url)
        networkManager.getCommentsData { result in
            switch result {
            case .failure(let error):
                print(error)
                self.errorAlertWithMessage(self, message: "Please Try Again After Sometime", title: "Service Failure")
            case .success(let commitsData):
                self.commits = commitsData
            }
        }
    }
}

// MARK: - GMCommits - TableView Delegate & DataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? GMTableViewcellTableViewCell else {return UITableViewCell()}
        let dataModel = commits[indexPath.row]
        cell.initializeDataWithModel(dataModel)
        return cell
    }
}

// MARK: - Commit Common error
extension UIViewController {
    func errorAlertWithMessage(_ viewController: UIViewController, message: String, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(defaultAction)
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}

