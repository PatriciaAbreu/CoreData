//
//  Exercicio.swift
//  CoreDataTeste
//
//  Created by Patricia de Abreu on 05/08/15.
//  Copyright (c) 2015 Patricia de Abreu. All rights reserved.
//

import Foundation
import CoreData

@objc(Exercicio)
class Exercicio: NSManagedObject {

    
    @NSManaged var enunciado: String
    @NSManaged var video: String
    @NSManaged var audio: String
    @NSManaged var resultado: String

}
