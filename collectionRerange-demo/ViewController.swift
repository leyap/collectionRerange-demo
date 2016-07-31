//
//  ViewController.swift
//  collectionRerange-demo
//
//  Created by LeeYaping on 16/6/29.
//  Copyright © 2016年 lisper. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

	@IBOutlet weak var collectionView: UICollectionView!
	var number = [String]()
	
	var longPress :UILongPressGestureRecognizer!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		for i in 0..<20 {
			number.append("\(i)")
		}
		
		longPress = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longAction(_:)))
		self.view.addGestureRecognizer(longPress)
	}
	
	@IBAction func managerAction(sender: UIBarButtonItem) {
		print("manager")
	}
	
	func longAction(sender:UILongPressGestureRecognizer) {
		print("ongPress")
		switch(sender.state) {
		case UIGestureRecognizerState.Began:
			guard let selectedIndexPath = self.collectionView.indexPathForItemAtPoint(sender.locationInView(self.collectionView)) else {
				break
			}
			collectionView.beginInteractiveMovementForItemAtIndexPath(selectedIndexPath)
			break
		case UIGestureRecognizerState.Changed:
			//collectionView.updateInteractiveMovementTargetPosition(sender.locationInView(sender.view))
			collectionView.updateInteractiveMovementTargetPosition(sender.locationInView(self.collectionView))
			break
		case UIGestureRecognizerState.Ended:
			collectionView.endInteractiveMovement()
			break
		default:
			collectionView.cancelInteractiveMovement()
		}
	}
	

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return number.count
	}
	
	
	func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
		let temp = number.removeAtIndex(sourceIndexPath.item)
		number.insert(temp, atIndex: destinationIndexPath.item)
	}

	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! Cell
		cell.label.text = number[indexPath.item]
		return cell
	}

}

