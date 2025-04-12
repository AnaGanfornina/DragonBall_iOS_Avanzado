//
//  AsyncImage.swift
//  DragonBall_iOS_Avanzado
//
//  Created by Ana on 11/4/25.
//

import UIKit

final class AsyncImage: UIImageView {
    /// Es el proceso actual que yo tenga de descarga de la imagen
    var currentWorkItem : DispatchWorkItem?
    
    func setImage(_ image: String){
        // si mi string es una url
        if let url = URL(string: image){
            self.setImage(url) //Esto es lo que se llama una sobrecarga de métodos
        }
    }
    
    func setImage(_ image: URL) {
        cancel()
        self.image = UIImage() // Debo vaciarme la imagen para no mostrar la imagen de la anterior descarga
        let workItem = DispatchWorkItem {
            let image = (try? Data(contentsOf:image)).flatMap { UIImage(data: $0) } // El flatMap sirve para que si el contenido de la imagen es nulo no le añade otro opcional mas (que es lo que haría si solo pusieramos un .map)
            
            // Para renderizar la foto me la llevo al hilo principal manualmenate
            DispatchQueue.main.async {[weak self] in
                self?.image = image ?? UIImage()
                self?.currentWorkItem = nil // libero la instancia de la referencia pues he temrinado de ejecutarme
            }
        }
        
        DispatchQueue.global().async(execute: workItem)
        currentWorkItem = workItem
    }
    
    /// Función de cancelar la descarga de la imagen para que no flikee
    func cancel() {
        currentWorkItem?.cancel() //cancela le proceso si lo tienes
        currentWorkItem = nil //  Elimino la referencia
    }
}
