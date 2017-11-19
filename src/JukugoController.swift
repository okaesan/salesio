//
//  ViewController.swift
//  YOJIJUKUGO
//
//  Created by 岡江 仁 on 2017/11/15.
//  Copyright © 2017年 岡江 仁. All rights reserved.
//

import UIKit

class JukugoController: UIViewController {
    
    var jukugo: [String]?
    var imi: [String]?
    
    var counterRandom: [Int] = [0]
    
    @IBOutlet weak var jukugoText: UILabel!
    @IBOutlet weak var imiText: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let JukugoMenu = JukugoMenuController.self
        
        jukugo = JukugoMenuController().dicJukugo[JukugoMenu.selectWeek]
        imi = JukugoMenuController().dicImi[JukugoMenu.selectWeek]
        
        for i in 1 ... Int(jukugo!.count) {
            counterRandom.append(i)
        }
        
        for _ in 0 ... 30 {
            counterRandom
                .swapAt(Int(arc4random_uniform(UInt32(counterRandom.count-1))),
                        Int(arc4random_uniform(UInt32(counterRandom.count-1))))
        }
        
        changeText()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeText(){
        let JukugoMenu = JukugoMenuController.self
        
        if JukugoMenu.orNormalRandom {
            if JukugoMenu.orJukugoImi {
                jukugoText.text = "□□□□"
                imiText.text = imi![JukugoMenu.counter]
            }else{
                jukugoText.text = jukugo![JukugoMenu.counter]
                imiText.text = "?"
            }
        }else{
            if JukugoMenu.orJukugoImi {
                jukugoText.text = "□□□□"
                imiText.text = imi![counterRandom[JukugoMenu.counter]]
            }else{
                jukugoText.text = jukugo![counterRandom[JukugoMenu.counter]]
                imiText.text = "?"
            }
        }
    }
    
    @IBAction func answerButton(_ sender: Any) {
        let JukugoMenu = JukugoMenuController.self
        
        if JukugoMenu.counter == -1 {
            return;
        }
        if JukugoMenu.orNormalRandom {
            if JukugoMenu.orJukugoImi {
                jukugoText.text = jukugo![JukugoMenu.counter]
            }else{
                imiText.text = imi![JukugoMenu.counter]
            }
        }else{
            if JukugoMenu.orJukugoImi {
                jukugoText.text = jukugo![counterRandom[JukugoMenu.counter]]
            }else{
                imiText.text = imi![counterRandom[JukugoMenu.counter]]
            }
        }
    }
    
    @IBAction func nextQuestion(_ sender: Any) {
        let JukugoMenu = JukugoMenuController.self
        
        if JukugoMenu.counter == jukugo!.count-1 {
            jukugoText.text = ""
            imiText.text = "\"タイトルに戻る\" を押すと戻れます\n\n 続けて \"次へ\" を押すと同じ順番でもう一周します"
            JukugoMenu.counter = -1
        }else{
            JukugoMenu.counter += 1
            changeText()
        }
    }
    
    @IBAction func toTitle(_ sender: Any) {
        let JukugoMenu = JukugoMenuController.self
        
        JukugoMenu.orJukugoImi = true
        JukugoMenu.counter = 0
        JukugoMenu.selectWeek = 1
    }
}

