//
//  ContentView.swift
//  JokesApp
//
//  Created by Umayanga Alahakoon on 6/14/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var jokeVM = JokeVM()
    
    var body: some View {
        ZStack {
            
            // Background color
            Group {
                if jokeVM.hasError {
                    Color.red
                } else {
                    Color.mint
                }
            }
            .edgesIgnoringSafeArea(.all)
            
            
            VStack(spacing: 20) {
                Spacer()
                
                // Joke text
                if let joke = jokeVM.currentJoke {
                    Text(joke.setup)
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Text(joke.punchline)
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                } else {
                    Text("ERROR")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                // Joke generating button
                Button {
                    async {
                        await jokeVM.grabAJoke()
                    }
                } label: {
                    Image(systemName: "theatermasks.circle.fill")
                        .resizable()
                        .foregroundStyle(.white, (jokeVM.hasError ? .orange : .purple))
                        .frame(width: 75, height: 75)
                }

            }
            .padding(20)
            
            
        }
        .task {
            // Use .task instead of .onAppear
            await jokeVM.grabAJoke()
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
