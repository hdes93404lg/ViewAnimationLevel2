//
//  ViewController.swift
//  ViewAnimationLevel2
//
//  Created by cm0640 on 2021/1/5.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    // MARK: - UI Properties

    private lazy var pieceView: UIView = {
        return UIView()
    }()
    
    private lazy var animationView: AnimationView = {
        return AnimationView()
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPieceView()
        setupAnimationView()
        setupStartButton()
    }
}

// MARK: - Setup Methods

extension ViewController {
    
    private func setupPieceView() {
        pieceView.backgroundColor = .red
        pieceView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pieceView)
        pieceView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        pieceView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pieceView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        pieceView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    private func setupAnimationView() {
        animationView.contentMode = .scaleAspectFill
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
    }
    
    private func setupStartButton() {
        startButton.setTitle("開始", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startButton)
        startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}

// MARK: - Action Methods

extension ViewController {
 
    @objc func startButtonTapped() {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "PieceView Animation", style: .default, handler: { (_) in
            
            self.animationView.stop()
            self.animationView.isHidden = true
            self.handlePieceViewAnimation()
        }))
        
        alertController.addAction(UIAlertAction(title: "Lottie Animation 1", style: .default, handler: { (_) in
            
            self.animationView.isHidden = false
            self.animationView.animation = Animation.named("LottieLogo1", subdirectory: "TestAnimations")
            self.animationView.play()
        }))
        
        alertController.addAction(UIAlertAction(title: "Lottie Animation 2", style: .default, handler: { (_) in
            
            self.animationView.isHidden = false
            self.animationView.animation = Animation.named("Boat_Loader", subdirectory: "TestAnimations")
            self.animationView.play()
        }))
        
        alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (_) in
            
        }))
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func handlePieceViewAnimation() {
        
        let start = pieceView.center
        
        UIView.animateKeyframes(withDuration: 5, delay: 0, options: .layoutSubviews, animations: {

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                self.pieceView.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.maxY)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.25) {
                self.pieceView.transform = self.pieceView.transform.rotated(by: 120)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.25) {
                self.pieceView.transform = self.pieceView.transform.scaledBy(x: 1.5, y: 1.5)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                self.pieceView.center = CGPoint(x: self.view.bounds.width, y: start.y)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                self.pieceView.center = start
                self.pieceView.transform = .identity
            }
        })
    }
}
