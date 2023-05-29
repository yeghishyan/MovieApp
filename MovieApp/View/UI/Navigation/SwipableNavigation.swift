//
//  SwipableNavigation.swift
//

import Foundation
import UIKit
import SwiftUI

//struct CustomNavigationView<ViewContent>: UIViewControllerRepresentable where ViewContent: View {
//    var content: () -> ViewContent
//
//    init(@ViewBuilder content: @escaping () -> ViewContent) {
//        self.content = content
//    }
//
//    func makeUIViewController(context: Context) -> UINavigationController {
//        let rootScene = UIHostingController(rootView: content())
//        let nvc = CustomTransitionsNavigationController(rootViewController: rootScene)
//        return nvc
//    }
//
//    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
//}
//
//fileprivate enum SwipeDirection {
//    case right
//    case left
//    case none
//}
//
//fileprivate class CustomTransitionsNavigationController: UINavigationController, UINavigationControllerDelegate {
//    private let pushAnimatorController: UIViewControllerAnimatedTransitioning? = nil
//    private let popAnimatorController: UIViewControllerAnimatedTransitioning = PopTransitionAnimatorController()
//
//    private var panGesture: UIPanGestureRecognizer! = nil
//    private var interactionController: UIPercentDrivenInteractiveTransition?
//
//    public override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.delegate = self
//
//        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
//        self.view.addGestureRecognizer(panGesture)
//    }
//
//    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return (operation == .pop) ? popAnimatorController : pushAnimatorController
//    }
//
//    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        return interactionController
//    }
//
//    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
//        guard let gestureView = gesture.view else {
//            return
//        }
//
//        let flickThreshold: CGFloat = 200.0
//        let distanceThreshold: CGFloat = 0.3
//
//        let velocity = gesture.velocity(in: gestureView)
//        let translation = gesture.translation(in: gestureView)
//        let percent = abs(translation.x / gestureView.bounds.size.width);
//
//        var swipeDirection: SwipeDirection = (velocity.x > 0) ? .right : .left
//
//        switch gesture.state {
//            case .began:
//                interactionController = UIPercentDrivenInteractiveTransition()
//
//                if swipeDirection == .right {
//                    if viewControllers.count > 1 {
//                        popViewController(animated: true)
//                    }
//                }
//
//            case .changed:
//                if let interactionController = self.interactionController {
//                    interactionController.update(percent)
//                }
//
//            case .cancelled:
//                if let interactionController = self.interactionController {
//                    interactionController.cancel()
//                }
//
//            case .ended:
//                if let interactionController = self.interactionController {
//                    if abs(percent) > distanceThreshold || abs(velocity.x) > flickThreshold {
//                        interactionController.finish()
//                    } else {
//                        interactionController.cancel()
//                    }
//
//                    self.interactionController = nil
//                    swipeDirection = .none
//                }
//
//            default:
//                break
//        }
//    }
//}
//
//
//fileprivate class PopTransitionAnimatorController: NSObject, UIViewControllerAnimatedTransitioning {
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return 0.4
//    }
//
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        popTransition(transitionContext)
//    }
//
//    private func popTransition(_ transitionContext: UIViewControllerContextTransitioning) {
//        guard let fromView = transitionContext.viewController(forKey: .from),
//              let toView = transitionContext.viewController(forKey: .to) else {
//            return
//        }
//
//        let initFromFrame = transitionContext.initialFrame(for: fromView)
//        let finalFromFrame = initFromFrame.offsetBy(dx: initFromFrame.width, dy: 0)
//
//        transitionContext.containerView.insertSubview(toView.view, belowSubview: fromView.view)
//
//        UIView.animate(withDuration: transitionDuration(using: transitionContext),
//                       animations: {
//                        fromView.view.frame = finalFromFrame
//                       },
//                       completion: { _ in
//                        guard transitionContext.transitionWasCancelled == true else {
//                            transitionContext.completeTransition(true)
//                            return
//                        }
//                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//                       })
//    }
//}
