//
//  MemeCollectionViewController.swift
//  MemeMe_app
//
//  Created by Alfredo M. on 1/23/17.
//  Copyright © 2017 Alfredo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MemeCollectionViewController: UICollectionViewController {

    var memes: [Meme]!

    @IBOutlet var memeCollectionView: UICollectionView!
    @IBOutlet weak var memeCollectionFlow: UICollectionViewFlowLayout!

    override func viewDidLoad() {
        super.viewDidLoad()

        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        memeCollectionFlow.minimumInteritemSpacing = space
        memeCollectionFlow.minimumLineSpacing = space
        memeCollectionFlow.itemSize = CGSize(width: dimension, height: dimension)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        memeCollectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as! MemeCollectionViewCell

        cell.memedImage.image = memes[(indexPath as NSIndexPath).row].memedImage

        // Configure the cell
        return cell
    }

    @IBAction func performPushSegue(_ sender: Any) {

        let controller = self.storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        self.navigationController!.pushViewController(controller, animated: true)
    }
}
