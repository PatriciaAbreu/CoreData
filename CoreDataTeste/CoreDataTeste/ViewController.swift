//
//  ViewController.swift
//  CoreDataTeste
//
//  Created by Patricia de Abreu on 05/08/15.
//  Copyright (c) 2015 Patricia de Abreu. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation


class ViewController: UIViewController {

    @IBOutlet weak var txfNome: UITextField!
    @IBOutlet weak var txfVideo: UITextField!
    @IBOutlet weak var txfAudio: UITextField!
    @IBOutlet weak var txfResultado: UITextField!
    @IBOutlet weak var txfTipoVideo: UITextField!
    @IBOutlet weak var txfTipoAudio: UITextField!
    
    @IBOutlet weak var testeBolo: UIImageView!
    
    @IBOutlet weak var corRoxo: UILabel!
    @IBOutlet weak var corLaranja: UILabel!
    @IBOutlet weak var corAzul: UILabel!
    
    var exercicio: Exercicio!
    
    var movie: MPMoviePlayerController?
    
    var audio: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ExercicioManager.sharedInstance.removerTodos()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func imprimir(sender: AnyObject) {
        
        playMovie(txfVideo.text, tipo: txfTipoVideo.text)
        movie?.play()
        playAudio(txfAudio.text, tipo: txfTipoAudio.text)
        
        ExercicioManager.sharedInstance.salvarNovoExercicio(txfNome.text, video: txfVideo.text, audio: txfAudio.text, resultado: txfResultado.text)
        
        exercicio = ExercicioManager.sharedInstance.buscaExercicio(0)
        
        println("\(exercicio)")
        
        
    }
    
    func playMovie(var nomeVideo: String, var tipo: String){
        
        if let path = NSBundle.mainBundle().pathForResource(nomeVideo, ofType: tipo), let url = NSURL.fileURLWithPath(path), let movie = MPMoviePlayerController(contentURL: url) {
           
            self.movie = movie
            movie.view.frame = CGRect(x: 250, y: 500, width: 300, height: 300)
//            movie.view.layer.position.x = 380
//            movie.view.layer.position.y = 250
//            movie.view.frame = view.frame
            movie.scalingMode = .AspectFill
//            movie.prepareToPlay()
            self.view.addSubview(movie.view)
        }else{
            debugPrint("Video não encontrado")
        }
    }
    
    func playAudio(var nomeAudio: String, var tipo: String){
        
        let path = NSBundle.mainBundle().pathForResource(nomeAudio, ofType: tipo)
        let file = NSURL(fileURLWithPath: path!)
        self.audio = AVAudioPlayer(contentsOfURL: file, error: nil)
        self.audio.prepareToPlay()
        self.audio.play()
        println("TOCANDOOO")
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        var touch = touches.first as! UITouch
        let point = touch.locationInView(view)
        
        for views in self.view.subviews {
            let viewsFrame = self.view.convertRect(views.frame, toView: views.superview)
            if (CGRectContainsPoint(viewsFrame, point)) {
                switch views.tag {
                case 2:
                    testeBolo.backgroundColor = UIColor.purpleColor()
                case 3:
                    testeBolo.backgroundColor = UIColor.orangeColor()
                case 4:
                    testeBolo.backgroundColor = UIColor.blueColor()
                default:
                    println("nada")
                }                
            }
        }
    }
}

