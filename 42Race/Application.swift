//
//  Application.swift
//  42Race
//
//  Created by Thomas on 01/02/2022.
//

import Foundation
import UIKit

final class Application {
    static let shared = Application()

    var window: UIWindow?

    func presentView(with window: UIWindow?) {
        self.window = window
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            self?.presentRootView()
        })
    }

    private func presentRootView() {
        guard let window = window else {
            return
        }

        UIView.transition(with: window, duration: 0.5,
                          options: .transitionFlipFromLeft,
                          animations: { [weak self] in
            self?.window?.rootViewController = ViewController()
        }, completion: nil)
    }
}

