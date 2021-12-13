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
    var _timer: Timer?
    
    func prettyFormatDate(calendar: Calendar, time: Date) -> String
    {
        // choose which date and time components are needed
        let requestedComponents: Set<Calendar.Component> = [
            .day,
            .hour,
            .minute
        ]

        // https://stackoverflow.com/a/33343958/11131120

        let dateTimeComponents = calendar.dateComponents(requestedComponents, from: time)
            
        var onWhichDay = "Today"
        // find if the alarm is supposed to sound tomorrow
        if dateTimeComponents.day! > calendar.dateComponents(requestedComponents, from: Date()).day!
        {
            onWhichDay = "Tomorrow"
        }
        
        let returnString = "Alarm set to " + onWhichDay + " at " + String(dateTimeComponents.hour!) + ":" + String(dateTimeComponents.minute!)
        
        return returnString
    }
    
    func set(alarmTime: Date) -> Date
    {
        _alarmDateTime = alarmTime
        _alarmSet = true
        
        if alarmTime.timeIntervalSinceNow < 0.0
        {
            print("Doing my job")
            _alarmDateTime = Calendar.current.date(byAdding: .hour, value: 24, to: alarmTime)!
            print(_alarmDateTime)
        }
        
        // https://stackoverflow.com/questions/38248941/how-to-get-time-hour-minute-second-in-swift-3-using-nsdate
        // *** create calendar object ***
        var calendar = Calendar.current

        // *** Get components using current Local & Timezone ***
        print("Alarm Date/Time:", (calendar.dateComponents([.year, .month, .day, .hour, .minute], from: _alarmDateTime)))
        // *** define calendar components to use as well Timezone to UTC ***
        calendar.timeZone = TimeZone(identifier: "GMT+3")!
        
        let delta = _alarmDateTime.timeIntervalSince(Date())
        print("Alarm will sound in " + String(delta) + "seconds")
        _timer = Timer.scheduledTimer(timeInterval: TimeInterval(delta), target: self, selector: #selector(playSound), userInfo: nil, repeats: false)
        
        return _alarmDateTime
    }
    
    @objc func playSound()
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
