//
//  ViewController.swift
//  MoneyTapTask
//
//  Created by Anoop on 12/10/18.
//  Copyright © 2018 Anoop. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    var pageListArray = [WikiPage]()
    
    var searchController: UISearchController!
    @IBOutlet weak var list: UITableView!
    @IBOutlet weak var tableBottomConstraints :NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.regisetrForKeyBoardNotification()
        self.setupView()
    }
    
    //Setup view
    func setupView() {
        
        self.list.tableFooterView = UIView()

        //Navigation title
        self.navigationItem.title = "Pages"
        
        //Search Bar controller
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search pages"
        list.tableHeaderView = searchController.searchBar
        self.loadTable()

    }
    
    //Call web request here.
    func getPages(searchString: String)  {
        
        NetworkInterface.getPages(searchString: searchString) { (responseData, count, error) in
            
            if let error = error as NSError? {
                DispatchQueue.main.async {
                    AlertController.showAlertToUser( messageTitle: "Error", message: error.localizedDescription, controller: self)
                }
            }
            self.loadTable()
        }
    }
    
    func loadTable() {
        self.pageListArray = PersistantService.getSavedPageList()
        DispatchQueue.main.async {
            self.list.reloadData()
        }
    }
    
    //    MARK : - KEYBOARD NOTIFICATION
    func regisetrForKeyBoardNotification() {
        // Observe keyboard change
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        //Remove all registerd notification from Viewcontroller
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.tableBottomConstraints.constant = -keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.tableBottomConstraints.constant = 0
    }

}

//MARK: - SEARCH BAR
extension ViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // If we haven't typed anything into the search bar then do not filter the results
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            return
        }
        print("searchText")
        self.getPages(searchString: searchText)
    }
}

//MARK: - Tableview
extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pageListArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "PageListCell"
        var cell: PageListCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? PageListCell
        if cell == nil {
            tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PageListCell
        }
        let pageAtIndex = pageListArray[indexPath.row]
        if let pageTitle = pageAtIndex.pageTitle {
            cell.titleLbl.text = pageTitle
        }else{
            cell.titleLbl.text = "No title available"
        }
        if let pageDesc = pageAtIndex.pageDescription {
            cell.descriptionLbl.text = pageDesc
        }else{
            cell.descriptionLbl.text = "No Description available"
        }
        
        if let imageURL = pageAtIndex.pageImageUrl {
            cell.profileImg?.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.png"))
        }else{
            cell.profileImg?.image = UIImage(named: "placeholder.png")
        }
        cell.profileImg?.contentMode = .scaleAspectFit
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let selectedPage = pageListArray[indexPath.row]
        if let pageID = selectedPage.pageID {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let detailPageControllerObj = storyBoard.instantiateViewController(withIdentifier: "DetailPageViewController") as! DetailPageViewController
            detailPageControllerObj.loadWebView(pageUrl: pageID)
            self.navigationController?.pushViewController(detailPageControllerObj, animated: true)
            
        }else{
            AlertController.showAlertToUser(messageTitle: "Error", message: "Detail not found", controller: self)
        }
        
    }
}
