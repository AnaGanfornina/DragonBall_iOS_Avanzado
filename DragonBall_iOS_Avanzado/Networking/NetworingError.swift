//
//  NetworingError.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 8/4/25.
//

enum NetworingError: Error {
    case invalidURL
    case serverError(error: Error)
    case responseError(code: Int?)
    case noDataRecived
    case errorParsingData
    case sessionTokenMissed
    case decodingFailed
    
}
