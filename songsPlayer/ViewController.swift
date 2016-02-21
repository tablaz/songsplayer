//
//  ViewController.swift
//  songsPlayer
//
//  Created by Ricardo on 21/02/2016.
//  Copyright © 2016 Tablaz. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {

    private var reproductor:AVAudioPlayer!
    
    @IBOutlet var coverImage: UIImageView!
    
    @IBOutlet var songsPickerView: UIPickerView!
    @IBOutlet var songName: UILabel!
    
    var songs : Array<Array<String>> = Array<Array<String>>()
    var volumen:Float = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songs.append(["Adele", "Hello", "helloAdele", "mp3"])
        songs.append(["Carlos Santana", "Maria Maria", "mariamariaSantana", "mp3"])
        songs.append(["Billy Joel", "Piano Man","pianoManBillyJoel", "mp3"])
        songs.append(["Shakira", "La La La", "lalalaShakira", "mp3"])
        self.loadSongData (songs[0])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
        
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.songs.count
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.songs[row][0]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        self.loadSongData(self.songs[row])
        
    }

    
    private func loadSongData (sData: NSArray){
        let songName = sData[1] as! String
        let songUrl = sData[2] as! String
        let songExt = sData[3] as! String
        // Set Song name
        self.songName.text = songName
        // Set Player
        let myURL = NSBundle.mainBundle().URLForResource(songUrl, withExtension: songExt)
        do {
            try reproductor = AVAudioPlayer(contentsOfURL: myURL!)
        } catch {
            print("Error")
        }
        // Set Cover Image
        // Process Book Cover
        let imageUrls = "\(sData[2]).jpg"
        self.coverImage.image = UIImage(named: imageUrls)
    }
    
    @IBAction func playSong() {
        if !reproductor.playing{
            reproductor.play()
        }
    }
    
    @IBAction func pauseSong() {
        if reproductor.playing{
            reproductor.pause()
        }
    }
    
    @IBAction func stopSong() {
        if reproductor.playing{
            reproductor.stop()
            reproductor.currentTime = 0.0
        }
    }
    
    @IBAction func volumenUp() {
        if volumen < 1 {
            volumen += 0.1
        }
        reproductor.volume = volumen
    }
    
    @IBAction func volumenDown() {
        if volumen > 0 {
            volumen -= 0.1
        }
        reproductor.volume = volumen
    }
    
    @IBAction func randomSong() {
        
        let diceRoll = Int(arc4random_uniform(4))
        self.loadSongData(self.songs[diceRoll])
        self.songsPickerView.selectRow(diceRoll, inComponent: 0, animated: false)
    }
    
    
}

