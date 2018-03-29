//
//  Future.swift
//  FunctionalFoundation
//
//  Created by Maxim Bazarov on 3/5/18.
//

import Foundation

/// It is a nice way to represent async operations.
/// I prefer version without implicit error handling
/// `Future<Result<T>>` Can be used when error need to be handled
final class Future<T> {
    
    /// Every future has some mutable state, so we need to protect it.
    private let queue = DispatchQueue(label: "private future queue")
    
    private var value: T?
    private var callbacks: [(T) -> ()] = []
    
    func onComplete(perform block: @escaping (T) -> ()) {
        /// Async is more safer from deadlocks, and provide some guaranteed
        /// `after scope` callback calling.
        queue.async {
            if let value = self.value {
                block(value)
            } else {
                self.callbacks.append(block)
            }
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    init(work: (@escaping (T) -> ()) -> ()) {
        work { value in
            self.queue.async {
                self.value = value
                self.callbacks.forEach { $0(value) }
                self.callbacks = []
            }
        }
    }
}

extension Future {
    func map<U>(_ transform: @escaping (T) -> U) -> Future<U> {
        return Future<U> { complete in
            self.onComplete { t in complete(transform(t)) }
        }
    }
}

extension Future {
    public func then<U>(_ execute: @escaping (T) -> Future<U>) -> Future<U> {
        return Future<U> { complete in
            self.onComplete { value in
                execute(value).onComplete(perform: complete)
            }
        }
    }
}

extension Future {
    public func and<U>(_ future: Future<U>) -> Future<(T, U)> {
        return Future<(T, U)> { complete in
            self.onComplete { (value: T) in
                future.onComplete { (anotherValue: U) in
                    complete((value, anotherValue))
                }
            }
        }
    }
}




