//
//  ResultFunction.swift
//  GithubUsers-Redux
//
//  Created by Shabir Jan on 3/28/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

/// This is simple apply like function.
/// It main goal to avoid code like this:
///
/// ```
/// let x = { ... }()
/// ```
///
/// Instead you can write:
/// ```
/// let x = result { ... }
/// ```
func result<Result>(from block: () -> Result) -> Result {
    return block()
}

