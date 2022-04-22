//
//  StringExtension.swift
//  
//
//  Created by roy on 2022/4/22.
//

import Foundation

extension String {
    
    func match(_ regex: String) -> [[String]] {
        let nsString = self as NSString
        return (try? NSRegularExpression(pattern: regex))?
            .matches(in: self, options: [], range: NSMakeRange(0, nsString.length))
            .map { match in
                (0 ..< match.numberOfRanges).map {
                    match.range(at: $0).location == NSNotFound ? "" : nsString.substring(with: match.range(at: $0))
                }
            } ?? []
    }
    
    func ranges(regex pattern: String) -> [Range<String.Index>] {
        let nsString = self as NSString
        if let regex = try? NSRegularExpression(pattern: pattern) {
            return regex.matches(in: self, range: NSMakeRange(0, nsString.length)).compactMap {
                Range($0.range, in: self)
            }
        }
        return []
    }
}
