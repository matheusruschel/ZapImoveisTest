//
//  Estado.swift
//  ZapImoveisTest
//
//  Created by Matheus Ruschel on 8/19/16.
//  Copyright © 2016 Matheus Ruschel. All rights reserved.
//

import Foundation

struct Endereco {
    
    var logradouro:     String?
    var numero:         String?
    var complemento:    String?
    var cep:            String?
    var bairro:         String?
    var cidade:         String?
    var estado:         String?
}

extension Endereco : Wrappable {
    
    init?(data: AnyObject) {
        
        guard
            let logradouro   = data["Logradouro"] as? String,
            let numero = data["Numero"] as? String,
            let complemento = data["Complemento"] as? String,
            let cep = data["CEP"] as? String,
            let bairro = data["Bairro"] as? String,
            let cidade = data["Cidade"] as? String,
            let estado = data["Estado"] as? String else {
                return nil
        }
        
        self.init(
            logradouro:logradouro,
            numero:numero,
            complemento:complemento ,
            cep:cep,
            bairro:bairro,
            cidade:cidade,
            estado:estado )
        
    }
}