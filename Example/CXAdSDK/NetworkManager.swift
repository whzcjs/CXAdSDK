//
//  NetworkManager.swift
//  CXAdSDK_Example
//
//  Created by AustinYang on 2025/8/26.
//  Copyright © 2025 AustinYang. All rights reserved.
//

import Foundation
import Network

@objcMembers open class NetworkOnceTrigger: NSObject {

    @objc
    public static let shared = NetworkOnceTrigger()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "network.once.trigger")
    private var hasTriggered = false
    private var hasStarted = false

    private override init() {}

    @objc
    public func startMonitoringIfNeeded(_ onFirstConnected: @escaping @Sendable () -> Void) {
        guard !hasStarted else { return }
        hasStarted = true

        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }

            if path.status == .satisfied, !self.hasTriggered {
                self.hasTriggered = true
                DispatchQueue.main.async {
                    onFirstConnected()
                }
                self.monitor.cancel()
            }
        }

        monitor.start(queue: queue)
    }
}

@objcMembers class CXLoad: NSObject {
    func test() {
        
    }
}
