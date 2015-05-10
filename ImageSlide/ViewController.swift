//
//  ViewController.swift
//  ImageSlide
//
//  Created by tutujiaw on 15/5/10.
//  Copyright (c) 2015年 tutujiaw. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var page: UIPageControl!
    
    var images:[UIImageView]?
    
    let imageCount = 5
    
    var timer:NSTimer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let imageWidth = self.scrollView.frame.size.width
        let imageHeight = self.scrollView.frame.size.height
        var x = CGFloat(0)
        var y = CGFloat(0)
        var lastImage:UIImage?
        
        for i in 0..<imageCount {
            x = CGFloat(i) * imageWidth
            let imageView = UIImageView(frame: CGRectMake(x, y, imageWidth, imageHeight))
            let imageName = "img_0" + String(i + 1)
            lastImage = UIImage(named: imageName)
            imageView.image = lastImage
            self.scrollView.addSubview(imageView)
        }
        
        self.scrollView.contentSize = CGSizeMake(CGFloat(imageCount) * imageWidth, imageHeight)
        self.scrollView.pagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.delegate = self
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "onTimer", userInfo: nil, repeats: true)
    }

    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        endTimer()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let x:CGFloat = scrollView.contentOffset.x
        let currentPage = (x + scrollView.frame.width / 2) / scrollView.frame.width
        page.currentPage = Int(currentPage)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    
    func onTimer() {
        var nextPage = page.currentPage + 1
        page.currentPage = nextPage % page.numberOfPages
        self.scrollView.contentOffset.x = CGFloat(page.currentPage) * self.scrollView.frame.width
    }
    
    func startTimer() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "onTimer", userInfo: nil, repeats: true)
    }
    
    func endTimer() {
        self.timer?.invalidate()
    }
}

