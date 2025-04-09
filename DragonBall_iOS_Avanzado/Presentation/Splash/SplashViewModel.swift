//
//  SplashViewModel.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 6/4/25.
//

import UIKit

enum SplashState {
    case loading
    case error
    case ready
}

final class SplashViewModel: UIViewController {
    
    var onStateChanged = Binding<SplashState>()
    private var secureData = SecureDataProvider()
    
    /// Flujo de entrada al ViewModel, ejecuta la acción de comprobar si hay token
    func load() {
        
        //Me pongo en el estado de estoy cargando
        onStateChanged.update(.loading)
        
        // Compruebo si hay token o no y digo que estoy ready.
        // Si hay token paso al listado y si no al login
        if secureData.getToken() != nil {
            // let heroesVC = HeroesViewController()
            print("Iríamos al listado de personajes")
            
            onStateChanged.update(.ready)
            
        } else {
            
            //et loginViewController = LoginBuilder().build()
            print("nos vamos al login")
            onStateChanged.update(.ready)
            //navigationController?.setViewControllers([loginViewController], animated: true)
             
           
        }
        
        
    }
    
}

