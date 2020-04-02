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
        var controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Second") as! SecondController
        self.transitioningDelegate = TransitionCoordinator.shared
        controller.transitioningDelegate = TransitionCoordinator.shared
        controller.modalPresentationStyle = .custom
//        self.navigationController?.transitioningDelegate = TransitionCoordinator.shared
//        controller.transitioningDelegate = animate
//        controller.modalPresentationStyle = .custom
//        self.navigationController?.present(controller, animated: true, completion: nil)
        self.present(controller, animated: true, completion: nil)
    }
    @IBAction func textAnimation(_ sender: Any) {
        label.animate(font: lable2.font, duration: 2)
    }
}
extension UILabel {
    func animate(font: UIFont, duration: TimeInterval)  {
        // let oldFrame = frame
        let labelScale = self.font.pointSize / font.pointSize
        self.font = font
        let oldTransform = transform
        transform = transform.scaledBy(x: labelScale, y: labelScale)
        // let newOrigin = frame.origin
        // frame.origin = oldFrame.origin // only for left aligned text
        // frame.origin = CGPoint(x: oldFrame.origin.x + oldFrame.width - frame.width, y: oldFrame.origin.y) // only for right aligned text
//        setNeedsUpdateConstraints()
//        return oldTransform
        UIView.animate(withDuration: duration) {
            //L self.frame.origin = newOrigin
            self.transform = oldTransform
//            self.layoutIfNeeded()
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
        
//        let stackFirst = (transitionContext.viewController(forKey: .from) as! ViewController).stack
        
//        let view = (transitionContext.viewController(forKey: .from) as! ViewController).VIEW
//
        let second = (transitionContext.viewController(forKey: .to) as! SecondController).label
        
//        let secondStack = (transitionContext.viewController(forKey: .to) as! SecondController).stack
        
        let secondView = (transitionContext.viewController(forKey: .to) as! SecondController).SUBVI
        
        let def = second!.frame
        let defaul = second!.font
//        let stackDef = secondStack!.frame
//        let viewDef = secondView!.frame
        
        second!.font = cont!.font
        second!.frame.origin = cont!.frame.origin
        second!.textAlignment = .left
        
//        secondStack?.frame = stackFirst!.frame
        
//        secondView?.frame = view!.frame
        let viewww = toView?.frame
        
        let labelScaleTrack = second!.font.pointSize / defaul!.pointSize
                    second!.font = defaul
                    let oldTransform = second!.transform
                    second!.transform = second!.transform.scaledBy(x: labelScaleTrack, y: labelScaleTrack)
        //
        
//        se.font = UIFont(descriptor: UIFontDescriptor(fontAttributes: [:]), size: lable2.font.pointSize)
//        label.transform = label.transform.scaledBy(x: 0.35, y: 0.35);
//
        
//        toView!.frame = CGRect(x: 0, y: 638, width: 39, height: 39)
        var animation = {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1) {
                toView!.frame = viewww!
//                secondStack!.frame = stackDef
//                secondView!.frame = viewDef
                second!.transform = oldTransform
                second!.frame = CGRect(x: 143, y: 415, width: 128, height: 66)
//                second!.textAlignment = .center
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
