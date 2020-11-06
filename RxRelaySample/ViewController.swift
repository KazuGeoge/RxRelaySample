//
//  ViewController.swift
//  RxRelaySample
//
//  Created by 城島一輝 on 2020/11/06.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    // 初期値あり
    private let behaviorRelay = BehaviorRelay<Int>(value: 0)
    // 初期値無し
    private let publishRelay = PublishRelay<Int>()
    
    @IBOutlet weak var publishResult: UILabel!
    @IBOutlet weak var behaviorResult: UILabel!
    
    private let publishResultNum = 0
    private let behaviorResultNum = 0
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        behaviorRelay.asObservable()
            .map { String($0) }
            .subscribe { [weak self] event in
                self?.behaviorResult.text = event.element
            print("behaviorRelay:\(event)")
        }.disposed(by: disposeBag)
         
         
        publishRelay
            .map { String($0) }
            .subscribe { [weak self] event in
                self?.publishResult.text = event.element
            print("publishRelay:\(event)")
        }.disposed(by: disposeBag)
         
        // 実行結果(publishRelayの現在値0は流れてこない)
        // behaviorRelay next(1)
        
        behaviorRelay.accept(1)
        publishRelay.accept(1)
    }
}

