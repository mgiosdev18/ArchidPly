//
//  HomeViewController.swift
//  ARCHIDPLY
//
//  Created by Ganesh on 26/04/18.
//  Copyright © 2018 Ganesh. All rights reserved.
//

import UIKit
import QuartzCore
class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var CollectionVC: UICollectionView!
    
    let numberOfCellsPerRow: CGFloat = 2
    let arrImages = [#imageLiteral(resourceName: "Daily Visit Entry"),#imageLiteral(resourceName: "Add New Client"),#imageLiteral(resourceName: "Edit PJP"),#imageLiteral(resourceName: "View Weekly PJP"),#imageLiteral(resourceName: "Client History"),#imageLiteral(resourceName: "Sales details")]
    let arrTitles = [" Daily Visit Entry "," Add New Client "," Edit PJP "," View Weekly PJP "," Client History "," Sales Details "]
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.shadowImage = UIColor.getCustomOrangeColor().as1ptImage()
        navigationItem.hidesBackButton = true
 
    }
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeViewCell", for: indexPath as IndexPath) as! HomeCollectionViewCell
      
        cell.layer.cornerRadius = 5
        
        cell.imgview.image = arrImages[indexPath.row]
        cell.imgview.layer.cornerRadius = 5
        
        cell.lblTitle.text = arrTitles[indexPath.row]
        cell.lblTitle.layer.backgroundColor = UIColor.getCustomOrangeColor().cgColor
        cell.lblTitle.layer.cornerRadius = 15
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? HomeCollectionViewCell
        
        switch indexPath.row {
        case 0:
            print("You selected : \(String(describing: cell?.lblTitle.text))")
            self.performSegue(withIdentifier: "DailyVisitEntry", sender: self)
            break
        case 1:
            print("You selected : \(String(describing: cell?.lblTitle.text!))")
            self.performSegue(withIdentifier: "AddNewClient", sender: self)
            break
        case 2:
            print("You selected : \(String(describing: cell?.lblTitle.text!))")
            self.performSegue(withIdentifier: "EditPJP", sender: self)
            break
        case 3:
            print("You selected : \(String(describing: cell?.lblTitle.text!))")
            self.performSegue(withIdentifier: "ViewWeeklyPJP", sender: self)
            break
        case 4:
            print("You selected : \(String(describing: cell?.lblTitle.text!))")
            self.performSegue(withIdentifier: "ClientHistory", sender: self)
            break
        case 5:
            print("You selected : \(String(describing: cell?.lblTitle.text!))")
            self.performSegue(withIdentifier: "SalesDetails", sender: self)
            break
        default:
            break
            
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = CollectionVC.frame.size.width / numberOfCellsPerRow
        
        let height = CollectionVC.frame.size.width / numberOfCellsPerRow
        
        return CGSize(width: width-10, height: height-10)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

}
