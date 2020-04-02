//
//  ViewController.swift
//  Animation
//
//  Created by Виталий Скриганюк on 25.03.2020.
//  Copyright © 2020 Виталий Скриганюк. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var VIEW: UIView!
    @IBOutlet weak var imagee: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var stack: UIView!
    
    
    @IBOutlet weak var lable2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addCustom()
//        self.modalPresentationStyle = .custom
        // Do any additional setup after loading the view.
    }
    @IBAction func show(_ sender: UIButton) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Second") as! SecondController
        self.transitioningDelegate = TransitionCoordinator.shared
        controller.transitioningDelegate = TransitionCoordinator.shared
        controller.modalPresentationStyle = .custom

        self.present(controller, animated: true, completion: nil)
    }
    @IBAction func textAnimation(_ sender: Any) {
        label.animate(font: lable2.font, duration: 2)
    }
}
extension UILabel {
    func animate(font: UIFont, duration: TimeInterval)  {
        let labelScale = self.font.pointSize / font.pointSize
        self.font = font
        let oldTransform = transform
        transform = transform.scaledBy(x: labelScale, y: labelScale)
        UIView.animate(withDuration: duration) {
            self.transform = oldTransform
        }
    }
}


class TransitionCoordinator:NSObject, UIViewControllerTransitioningDelegate {
    
    static let shared = TransitionCoordinator()
    
    private override init() {
        
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animate()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return Animate()
    }
    
}

class Animate: NSObject,UIViewControllerAnimatedTransitioning {
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toView = transitionContext.view(forKey: .to)
        let conteiner = transitionContext.containerView
        conteiner.addSubview(toView!)
     
        
        let cont = (transitionContext.viewController(forKey: .from) as! ViewController).label

        let second = (transitionContext.viewController(forKey: .to) as! SecondController).label
        
        let secondView = (transitionContext.viewController(forKey: .to) as! SecondController).SUBVI
        
        let def = second!.frame
        let defaul = second!.font
        
        second!.font = cont!.font
        second!.frame.origin = cont!.frame.origin
        second!.textAlignment = .left

        let viewww = toView?.frame
        
        let labelScaleTrack = second!.font.pointSize / defaul!.pointSize
        second!.font = defaul
        let oldTransform = second!.transform
        second!.transform = second!.transform.scaledBy(x: labelScaleTrack, y: labelScaleTrack)
        
        let animation = {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1) {
                toView!.frame = viewww!
                second!.transform = oldTransform
                second!.frame = def
            }
        }

        UIView.animateKeyframes(withDuration: 5, delay: 0, options: .calculationModeCubic, animations: animation) { (Bool) in
            conteiner.addSubview(toView!)
        }
    }
    
}

protocol Tesr {
    func getFrame() -> CGRect
}

extension ViewController: Tesr {
    func getFrame() -> CGRect {
        return label.frame
    }
}
