//
//  ExercicioManager.swift
//  CoreDataTeste
//
//  Created by Patricia de Abreu on 05/08/15.
//  Copyright (c) 2015 Patricia de Abreu. All rights reserved.
//

import UIKit
import CoreData

class ExercicioManager{
    
    static let sharedInstance = ExercicioManager()
    static let entityName: String = "Exercicio"
    
    lazy var managedContext: NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate.managedObjectContext!
    }()
    
    private init(){}
    
    func novoExercicio() -> Exercicio {
        return NSEntityDescription.insertNewObjectForEntityForName(ExercicioManager.entityName, inManagedObjectContext: managedContext) as! Exercicio
    }
    
    func buscarExercicios() -> Array<Exercicio> {
        let buscaRequest = NSFetchRequest(entityName: ExercicioManager.entityName)
        var erro: NSError?
        let buscaExercicios = managedContext.executeFetchRequest(buscaRequest, error: &erro) as? [NSManagedObject]
        if let exercicios = buscaExercicios as? [Exercicio] {
            return exercicios
        } else{
            println("Não foi possível encontrar esse exercicio. Erro: \(erro!.userInfo)")
        }
        NSFetchRequest(entityName: "FetchRequest")
        
        return Array<Exercicio>()
    }
    
    func buscaExercicio( index: Int) -> Exercicio {
        var exercicio: Exercicio = buscarExercicios()[index]
        return exercicio
    }
    
    func salvarExercicios(){
        var erro: NSError?
        managedContext.save(&erro)
        
        if let e = erro {
            println("Não foi possível salvar esse exercicio. Erro \(erro!.userInfo)")
        }
    }
    
    func removerTodos(){
        var arrayExercicio: Array<Exercicio> = buscarExercicios()
        for exercicio: Exercicio in arrayExercicio {
            managedContext.deleteObject(exercicio)
        }
    }
    
    func removerExercicio(index: Int){
        var arrayExercicio: Array<Exercicio> = buscarExercicios()
        managedContext.deleteObject(arrayExercicio[index] as NSManagedObject)
        salvarExercicios()
    }
    
    func salvarNovoExercicio(enunciado: String, video: String, audio: String, resultado: String){
        let exercicio = novoExercicio()
        
        exercicio.setValue(enunciado, forKey: "enunciado")
        exercicio.setValue(video, forKey: "video")
        exercicio.setValue(audio, forKey: "audio")
        exercicio.setValue(resultado, forKey: "resultado")
        salvarExercicios()
    }
}
