//
//  WalkthroughPageViewController.swift
//  Project Enigma
//
//  Created by Lennart Philipp on 03.04.18.
//  Copyright © 2018 Lennart Philipp. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, WalkthroughViewControllerDelegate {
    
    var vcs: [UIViewController] = {
        var array = [UIViewController]()
        let storyboard = UIStoryboard(name: "ExtraViewControllers", bundle: nil)
        
        let buttonsVC = storyboard.instantiateViewController(withIdentifier: "ButtonsVC") as! WalkthroughButtonsViewController
        let encryptVC = storyboard.instantiateViewController(withIdentifier: "EncryptVC") as! WalkthroughEncryptViewController
        let decryptVC = storyboard.instantiateViewController(withIdentifier: "DecryptVC") as! WalkthroughDecryptViewController
        
        array.append(buttonsVC)
        array.append(encryptVC)
        array.append(decryptVC)
        
        return array
    }()
    
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ViewDidLoad")
        
        let storyboard = UIStoryboard(name: "ExtraViewControllers", bundle: nil)

        let walktroughViewController = storyboard.instantiateViewController(withIdentifier: "WalkthroughViewController") as! WalkthroughViewController
        walktroughViewController.delegate = self
        
        self.dataSource = self
        delegate = self
        
        view.backgroundColor = .white
        
        setViewControllers([vcs[0]], direction: .forward, animated: true, completion: nil)
    
    }
    
    func forwardPage() {
        print("Start")
        currentPage = self.currentIndex() + 1
        print(vcs[currentPage])
        self.setViewControllers([vcs[currentPage]], direction: .forward, animated: true) { (true) in
            print("Done")
        }
    }
    
    func currentIndex() -> Int {
        return currentPage
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.vcs.index(of: viewController) {
            if viewControllerIndex == 0 {
                return nil
            } else {
                return vcs[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.vcs.index(of: viewController) {
            if viewControllerIndex < self.vcs.count - 1 {
                return vcs[viewControllerIndex + 1]
            } else {
                return nil
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let viewControllers = pageViewController.viewControllers {
                if let viewControllerIndex = self.vcs.index(of: viewControllers[0]) {
                    currentPage = viewControllerIndex
                    print(viewControllerIndex)
                    //pageVCDelegate?.didUpdatePageIndex(currentIndex: viewControllerIndex)
                }
            }
        }
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


protocol walkthroughPageViewControllerDelegate {
    func didUpdatePageIndex(currentIndex: Int)
}
