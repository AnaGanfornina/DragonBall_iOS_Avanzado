//
//  Binding.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 7/4/25.
//

import Foundation

/// Aqui nos aseguraremos de llevar las cosas de UI al hilo principal
/// lo hacemos generico para poder usarlo para otras pantallas
final class Binding<T: Equatable> {
    typealias Completion = (T) -> Void
    
    private var completion: Completion?
    
    ///Función donde registramos la closure que lleva el estado para luego ejecutarla dentro del update
    func bind(completion: @escaping Completion) {
        self.completion = completion // Registramos la closure para luego ejecutarla dentro del update
    }
    
    ///Función que traduce el hilo en el que está y lo pasa al hilo principal
    func update(_ state: T){
        if Thread.current.isMainThread {
            completion?(state)
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.completion?(state) // Ejecutamos la closure
            }
        }
    }
}
