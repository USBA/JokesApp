//
//  JokeVM.swift
//  JokesApp
//
//  Created by Umayanga Alahakoon on 6/14/21.
//

import SwiftUI

class JokeVM: ObservableObject {
    @Published var currentJoke: Joke?
    @Published var hasError: Bool = false
    
    func grabAJoke() async {
        guard let url = URL(string: "https://official-joke-api.appspot.com/random_joke") else {
            hasError = true
            errorHaptic()
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let joke = try JSONDecoder().decode(Joke.self, from: data)
            currentJoke = joke
            hasError = false
        } catch {
            hasError = true
            errorHaptic()
            print(error)
        }
        
    }
    
    
    // MARK: - Haptic feedback for errors
    let generator = UINotificationFeedbackGenerator()
    
    func errorHaptic() {
        DispatchQueue.main.async {
            self.generator.notificationOccurred(.error)
        }
    }
    
}
