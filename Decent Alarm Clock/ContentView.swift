import SwiftUI

struct ContentView: View {
    
    @State private var selectedTime = Date()
    @State private var alarmNotifierText = "Alarm Disabled"
    
    let _clock = Clock(alarmDateTime: Date.init(), alarmSet: false)
    
    var body: some View {
        VStack {
            DatePicker(
                selection: $selectedTime,
                displayedComponents: .hourAndMinute,
                label: { Text("Pick a Time") }
            )
            HStack {
                Button(
                    action:
                        {
                            _clock.set(alarmTime: selectedTime)
                            alarmNotifierText = "Alarm Set to " + selectedTime.description
                        }
                ) {
                    Text("Set")
                }
                Button(
                    action:
                        {
                            _clock.playSound()
                        }
                ) {
                    Text("Sound")
                }
                Button(
                    action:
                        {
                            _clock.stopSound()
                        }
                ) {
                    Text("De-Sound")
                }
            }
            Text($alarmNotifierText.wrappedValue)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
