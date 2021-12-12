//
//  ViewController.swift
//  Concurrency
//
//  Created by Bhooshan Patil on 10/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    let url = "https://jsonplaceholder.typicode.com/users"
    
    // Sync
    override func viewDidLoad() {
        super.viewDidLoad()
        print("before async ")
        // in order to call async from sync
        Task {
            await asynCaller()
        }
        Thread.isMainThread ? print("Main Thread") : print("not on main thread")
        print("after async")
    }
    
    // Asyc
    private func asynCaller() async {
        print("inside async calling async")
        Thread.isMainThread ? print("Main Thread") : print("not on main thread")
        do {
            let _ = try await downloadTask()
        } catch  {
            print(error)
        }
    }
    
    // Async
    private func downloadTask() async throws -> (Data, URLResponse) {
        someSyncFunc()
        Thread.isMainThread ? print("Main Thread") : print("not on main thread")
        let requestURL = URL(string: url)!
        let request = URLRequest(url: requestURL)
        do {
            // swift introduced new HTTP-API for async-await
            let response = try await URLSession.shared.data(for: request)
            return response
        } catch {
            throw error
        }
    }
    
    // Sync
    private func someSyncFunc() {
        print("inside async calling sync")
        Thread.isMainThread ? print("Main Thread") : print("not on main thread")
    }
}

