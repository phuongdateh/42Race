//
//  Debouncer.swift
//  42Race
//
//  Created by Thomas on 10/02/2022.
//

import Foundation

final class Debouncer: NSObject {
    var delay: Double
    weak var timer: Timer?
 
    init(delay: Double) {
        self.delay = delay
    }
 
    func call(action: @escaping (() -> Void)) {
        timer?.invalidate()
        let nextTimer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
            action()
        }
        timer = nextTimer
    }
}
