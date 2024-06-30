//
//  String+Extensions.swift
//  ToDo
//
//  Created by BS00484 on 30/6/24.
//

import Foundation

extension String {
    var isEmptyOrWhitespace: Bool {
        
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
    }
}
