//
//  ContentView.swift
//  JokesAppForWatch WatchKit Extension
//
//  Created by Umayanga Alahakoon on 6/21/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var jokeVM = JokeVM()
    
    var body: some View {
        VStack {
            Spacer()
            
            // Joke text
            if let joke = jokeVM.currentJoke {
                ScrollView {
                    Text(joke.setup)
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.semibold)
                        .lineLimit(nil)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: false)
                    
                    Text(joke.punchline)
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.semibold)
                        .lineLimit(nil)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: false)
                }
            } else if jokeVM.hasError {
                Text("ERROR")
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            } else {
                Image(systemName: "ellipsis")
                    .font(.title)
                    .foregroundColor(.white)
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
                    .frame(width: 30, height: 30)
            }
            .buttonStyle(.borderless)

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
