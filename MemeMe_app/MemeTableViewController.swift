//
//  MemeTableViewController.swift
//  MemeMe_app
//
//  Created by Alfredo M. on 1/23/17.
//  Copyright © 2017 Alfredo. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var memes:[Meme]!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes

        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell") as! MemeTableViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.memedImageView?.image = meme.memedImage
        cell.labelView?.text = "\(meme.topText)  \(meme.bottomText)"
        
        return cell
    }
    
    @IBAction func performPushSegue(_ sender: Any) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
