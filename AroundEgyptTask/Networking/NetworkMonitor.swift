//
//  NetworkMonitor.swift
//  AroundEgyptTask
//
//  Created by Mostafa Elemam on 27/06/2025.
//

import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitorQueue")
    
    private(set) var isConnected: Bool = false

    var onReconnect: (() -> Void)?

    // Prevent false trigger on first connection
    private var hasInitialized = false
    private var previousStatus: NWPath.Status = .requiresConnection

    private init() {
        startMonitoring()
    }

    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }

            let newStatus = path.status
            self.isConnected = newStatus == .satisfied

            if self.hasInitialized {
                if self.previousStatus != .satisfied && newStatus == .satisfied {
                    DispatchQueue.main.async {
                        self.onReconnect?()
                    }
                }
            } else {
                // First status received, now we can compare going forward
                self.hasInitialized = true
            }

            self.previousStatus = newStatus
        }

        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
