
import Foundation

class APIThrottler {
    private var lastRequestTime: Date?
    private let minimumInterval: TimeInterval
    
    init(minimumInterval: TimeInterval) {
        self.minimumInterval = minimumInterval
    }
    
    func throttle(completion: @escaping () -> Void) {
        let now = Date()
        if let lastRequestTime = lastRequestTime,
           now.timeIntervalSince(lastRequestTime) < minimumInterval {
            let delay = minimumInterval - now.timeIntervalSince(lastRequestTime)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.lastRequestTime = Date()
                completion()
            }
        }
        else {
            self.lastRequestTime = now
            completion()
        }
    }
}
