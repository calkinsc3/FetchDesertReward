//
//  DesertCell.swift
//  FetchDesertReward
//
//  Created by Bill Calkins on 6/17/22.
//

import UIKit

class DessertCell: UITableViewCell {
    
    @IBOutlet weak var desertName: UILabel!
    @IBOutlet weak var desertImage: UIImageView!
    
    var imageURL: URL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.getDessertImage()
    }
    
    override func prepareForReuse() {
        //self.getDessertImage()
    }
    
    private func getDessertImage() {
        
        guard let givenImageURL = self.imageURL else {
            return
        }
        
        Task {
            let desertFetcher = DessertFetcher()
            Task {
                do {
                    let desertImage = try await desertFetcher.getDesertImage(imageURL: givenImageURL)
                    // FIXME: weak reference will not work
                    self.desertImage = UIImageView(image: desertImage)
                    
                } catch {
                    Log.networkLogger.error("Unable to retrieve deserts from API")
                }
            }
        }
    }

}
