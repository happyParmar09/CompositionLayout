//
//  ViewController.swift
//  CompositionLayout
//
//  Created by gokulparmar on 25/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet{
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "HeaderView")
        }
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout{
        
        let layout = UICollectionViewCompositionalLayout { (index, environemt) -> NSCollectionLayoutSection? in
            return self.createSectionFor(index: index, environement: environemt)
        }
        
        return layout
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.collectionViewLayout = createCompositionalLayout()
        
    }
    
    func createSectionFor(index : Int , environement : NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection{
        
        if index%3==0 && index != 0 {
            return createShortsSection()
        }
        else {
            return createVideoSection()
        }
        
       
    }
    func createVideoSection() -> NSCollectionLayoutSection{
        let inset : CGFloat = 2.5
        
        //creating item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        //creating group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize , subitem : item , count: 1)
        
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func createShortsSection() -> NSCollectionLayoutSection{
        let inset : CGFloat = 2.5
        
        //creating item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        //creating group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        //suplementary
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize , elementKind: "header" , alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
}

//MARK: UICollectionDataSource Method


extension ViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section==0 || section%3 != 0 ? 1 : 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor(hue: CGFloat(drand48()), saturation: 1, brightness: 1, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView else {
            return UICollectionReusableView()
        }
        
        view.title = indexPath.section%3 == 0 && indexPath.section != 0 ? "SHORTS" : ""

        return view
    }
    
}
