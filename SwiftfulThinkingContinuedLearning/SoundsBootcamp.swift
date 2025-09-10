//
//  SoundsBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Lahiru Amarasooriya on 2025-09-10.
//

import SwiftUI
import AVKit

class SoundManager {
    
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case tada
        case badum
        
    }
    
    func playSound(sound: SoundOption) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error playing sound. \(error.localizedDescription)")
        }
        
    }
}

struct SoundsBootcamp: View {
    
    var soundManager = SoundManager.instance
    
    var body: some View {
        VStack {
            Button("Play sound 1") {
                soundManager.playSound(sound: .tada)
            }
            
            Button("Play sound 2") {
                soundManager.playSound(sound: .badum)
            }
        }
    }
}

#Preview {
    SoundsBootcamp()
}
