//
//  SecondController.swift
//  Animation
//
//  Created by Виталий Скриганюк on 25.03.2020.
//  Copyright © 2020 Виталий Скриганюк. All rights reserved.
//

import UIKit

class SecondController: UIViewController {

//    let con = TransitionCoordinator()
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var SUBVI: UIView!
    
    @IBOutlet weak var stack: UIView!
    
    @IBOutlet weak var main: UIView!
    @IBOutlet weak var subview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addCustom()
//        self.transitioningDelegate = con
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIViewController {
    static var s = TransitionCoordinator.shared
    
    func addCustom() {
        self.transitioningDelegate = UIViewController.s
        self.modalPresentationStyle = .custom
    }
}
