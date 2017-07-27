//
//  ViewController.swift
//  BirdFly
//
//  Created by Hung CIE on 7/23/17.
//  Copyright © 2017 MICIE. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    var bird :UIImageView!
    var player: AVAudioPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setBackground()
        addBird()
        birdFlyUpDown()
        playSound()
    }
    
    func setBackground(){
        
        let background = UIImageView(image: UIImage(named: "jungle.jpg"))
        background.frame = self.view.bounds
        background.contentMode = .scaleAspectFill
        self.view.addSubview(background)
    }
    func addBird() {
        bird = UIImageView(frame: CGRect(x: 0, y: 0, width: 110, height: 68))
        
        bird.animationImages = [UIImage(named: "bird0.png")!,UIImage(named: "bird1.png")!,UIImage(named: "bird2.png")!,UIImage(named: "bird3.png")!,UIImage(named: "bird4.png")!,UIImage(named: "bird5.png")!]
        
        bird.animationRepeatCount = 0
        bird.animationDuration = 3
        bird.startAnimating()
        
        self.view.addSubview(bird)
    }
    func birdFlyUpDown() {
        // bay xuống điểm 1
        UIView.animate(withDuration: 3, animations: {self.bird.center = CGPoint(x:self.view.bounds.size.width,y: self.view.bounds.size.height - 30)}, completion: {
            (finished) in
            print("finished")
            //quay dau con chim
            self.bird.transform = self.bird.transform.scaledBy(x: -1, y: 1).concatenating(CGAffineTransform(rotationAngle: 0))
            //bay sang điểm 2
            UIView.animate(withDuration: 3, animations: {self.bird.center = CGPoint(x: 0,y: self.view.bounds.size.height - 20)}, completion: {
                (finished) in
                //bay lên điểm 3
                self.bird.transform = self.bird.transform.scaledBy(x: -1, y: 1).concatenating(CGAffineTransform(rotationAngle: -45))
                UIView.animate(withDuration: 3, animations: {self.bird.center = CGPoint(x: self.view.bounds.size.width ,y: 30)}, completion: {
                    (finished) in
                    //bay về điểm 0
                    self.bird.transform = self.bird.transform.scaledBy(x: -1, y: 1).concatenating(CGAffineTransform(rotationAngle: 45 ))
                    UIView.animate(withDuration: 3, animations: {self.bird.center = CGPoint(x: 30 ,y: 30)}, completion: {
                        (finished) in
                        self.bird.transform = CGAffineTransform.identity
                        self.birdFlyUpDown()
                    })
                })
                
                
            })
        })
    }
        func playSound() {
            let url = Bundle.main.url(forResource: "A+ – Chào Mào Mái Hót", withExtension: "mp3")!
            
            do {
                player = try AVAudioPlayer(contentsOf: url)
                guard let player = player else { return }
                
                player.prepareToPlay()
                player.play()
            } catch let error as NSError {
                print(error.description)
            }
        }
}

