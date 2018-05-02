//
//  WalkthroughViewController.swift
//  Project Enigma
//
//  Created by Lennart Philipp on 08.03.18.
//  Copyright © 2018 Lennart Philipp. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var delegate: WalkthroughViewControllerDelegate?
    
//    var walkthroughPageVC: WalkthroughPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = .clear
        
        outerView.clipsToBounds = false
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowRadius = 10
        outerView.layer.shadowOffset = CGSize.zero
        outerView.layer.shadowOpacity = 0.5
        outerView.backgroundColor = .clear
        
        nextBtn.layer.cornerRadius = nextBtn.frame.height / 2
        
        let storyboard = UIStoryboard(name: "ExtraViewControllers", bundle: nil)
        
        let walkthroughPageVC = storyboard.instantiateViewController(withIdentifier: "WalkthroughPageVC") as! WalkthroughPageViewController
//        walkthroughPageVC = (storyboard.instantiateViewController(withIdentifier: "WalkthroughPageVC") as! WalkthroughPageViewController)
        delegate = walkthroughPageVC
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: 10).cgPath
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if let index = delegate?.currentIndex() {
            print("Here... \(index)")
            switch index {
            case 0...1:
                print("Forwarding...")
//                walkthroughPageVC?.forwardPage()
                delegate?.forwardPage()
            case 2:
                dismiss(animated: true, completion: nil)
            default: break
            }
        }
        
        updateUI()
    }
    
    func updateUI() {
        if let index = delegate?.currentIndex() {
            switch index {
            case 0...1:
                nextBtn.setTitle("NEXT", for: .normal)
                skipBtn.isEnabled = true
                skipBtn.alpha = 1
            case 2:
                nextBtn.setTitle("GET STARTED", for: .normal)
                skipBtn.isEnabled = false
                skipBtn.alpha = 0
            default: break
            }
            pageControl.currentPage = index
        }
    }
    
    @IBAction func skipButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

protocol WalkthroughViewControllerDelegate {
    func forwardPage()
    func currentIndex() -> Int
}
