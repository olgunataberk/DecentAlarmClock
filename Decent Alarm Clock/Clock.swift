//
//  Clock.swift
//  Decent Alarm Clock
//
//  Created by Ataberk Olgun on 5.12.2021.
//

import Foundation
import AVFoundation

var player: AVAudioPlayer?


class Clock
{
    internal init(alarmDateTime: Date, alarmSet: Bool) {
        self._alarmDateTime = alarmDateTime
        self._alarmSet = alarmSet
    }
    
    var _audioPlayer: AVAudioPlayer?
    var _alarmDateTime: Date
    var _alarmSet: Bool
    
    func set(alarmTime: Date)
    {
        _alarmDateTime = alarmTime
        print(_alarmDateTime)
        _alarmSet = true
    }
    
    func playSound()
    {
        let url = Bundle.main.url(forResource: "alarm", withExtension: "mp3")!
        do {
            _audioPlayer = try AVAudioPlayer(contentsOf: url)
            _audioPlayer?.prepareToPlay()
            _audioPlayer?.play()
            print("Playing sound")
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func stopSound()
    {
        if _audioPlayer != nil
        {
            _audioPlayer?.stop()
            print("Stopping sound")
        }
        else
        {
            print("Could not stop sound")
        }
    }
    
    func clear()
    {
        _alarmSet = false
    }
}
