//
//  CommonRepository.swift
//  TimetableScheduler
//
//  Created by Hiago Chagas on 26/11/23.
//

import Foundation

protocol CommonRepository {
    associatedtype T
    func getAll() -> [T]
    func addModel(model: T)
    func removeModel(model: T)
    func updateModel(model: T)
}
