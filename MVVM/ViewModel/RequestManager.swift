//
//  RequestManager.swift
//  MVVM
//
//  Created by Yonusa iOS on 13/01/22.
//

import Foundation

class RequestManager {
    //1.- Se crea metodo para enlazar vista con modelo de vista
    var refreshData = { () -> () in }
    var dataArray: [SimpsonsModel] = [] {
        didSet {
            refreshData()
        }
    }
    
    func getSimpsonData() {
        guard let url = URL(string: "https://thesimpsonsquoteapi.glitch.me/quotes?count=10") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let json = data
            //Serializar Datos
            do {
                let decoder = JSONDecoder()
                self.dataArray = try decoder.decode([SimpsonsModel].self, from: json!)
                
            } catch let error {
                debugPrint("Error en \(#function) = \(error.localizedDescription)")
            }
        }.resume()
    }
    
}
