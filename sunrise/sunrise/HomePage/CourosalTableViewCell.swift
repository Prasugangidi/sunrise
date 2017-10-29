//
//  CourosalTableViewCell.swift
//  sunrise
//
//  Created by reddys on 24/9/17.
//  Copyright © 2017 sunriseclick. All rights reserved.
//

import UIKit
import SwiftImageCarousel
import SDWebImage

class CourosalTableViewCell: UITableViewCell , UIScrollViewDelegate {
    
    @IBOutlet weak var courosalView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var timer : Timer?
    var currentPage = 0
    var imagesCount = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        pageControl.backgroundColor = UIColor.clear
        pageControl.currentPageIndicatorTintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.orange
        scrollView.delegate = self
    }
    
    func setGoodsGalleryData(goodsGalleryData : [[String : AnyObject]])
    {
        var imageURLs : [String] = []
        
        for gallery in goodsGalleryData {
            imageURLs.append(gallery["thumb"] as! String)
        }
        self.setImageUrls(imageURLs: imageURLs)
    }
    
    func setData(bannerData :  [[String : AnyObject]])
    {
       var imageURLs : [String] = []
        
        for seo in bannerData {
            imageURLs.append(seo["image_path"] as! String)
        }
        self.setImageUrls(imageURLs: imageURLs)
        
    }
    
    func setImageUrls(imageURLs : [String])
    {
        for subView in self.scrollView.subviews {
            subView.removeFromSuperview()
        }
        imagesCount = imageURLs.count
        pageControl.numberOfPages = imageURLs.count
        scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * CGFloat(imageURLs.count), height: self.scrollView.frame.size.height)
        var xChod : CGFloat = 0
        
        for imagePath in imageURLs {
            let imageView = UIImageView(frame: CGRect(x: xChod, y: 0, width: self.scrollView.frame.size.width, height: self.scrollView.frame.size.height))
            imageView.sd_setImage(with: URL(string: imagePath), placeholderImage: UIImage(named: "placeholder.png"));
            self.scrollView.addSubview(imageView)
            imageView.contentMode = .scaleAspectFit
            xChod += self.scrollView.frame.size.width
            
        }
        self.currentPage  = imagesCount
        if timer != nil        {
            timer!.invalidate()
            timer = nil
            
        }
        timer = Timer.scheduledTimer(timeInterval: 3 , target: self, selector: #selector(CourosalTableViewCell.loop), userInfo: nil, repeats: true)
        timer!.fire()
    }
    
    @objc func loop()
    {
        if self.currentPage == imagesCount
        {
            self.currentPage = 0
        }
        self.pageControl.currentPage = self.currentPage
        self.scrollToPage(self.currentPage)
        self.currentPage += 1
    }
    
    func scrollToPage(_ page: Int) {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset.x = self.scrollView.frame.width * CGFloat(page)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension CourosalTableViewCell: SwiftImageCarouselVCDelegate {
    func setupAppearance(forFirst firstPageControl: UIPageControl, forSecond secondPageControl: UIPageControl) {
        
        firstPageControl.backgroundColor = UIColor.clear
        firstPageControl.currentPageIndicatorTintColor = UIColor.red
        
        secondPageControl.backgroundColor = UIColor.clear
        secondPageControl.currentPageIndicatorTintColor = UIColor.red
        
    }
}
