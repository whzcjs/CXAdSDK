//
//  NetworkOnceTrigger.swift
//  CXAdSDKDemo
//
//  Created by AustinYang on 2025/7/25.
//

import Foundation
import Network

@objcMembers class NetworkOnceTrigger: NSObject {

    static let shared = NetworkOnceTrigger()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "network.once.trigger")
    private var hasTriggered = false
    private var hasStarted = false

    private override init() {}

    func startMonitoringIfNeeded(_ onFirstConnected: @escaping @Sendable () -> Void) {
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
