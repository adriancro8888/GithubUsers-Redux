//
//  NetworkService.swift
//  GithubUsers-Redux
//
//  Created by Shabir Jan on 3/28/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import Foundation
func getURL<T: Decodable>(url: URL) -> Future<T> {
    return Future { complete in
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            let value = try! JSONDecoder().decode(T.self, from: data!)
            complete(value)
        }
        
        task.resume()
    }
}
