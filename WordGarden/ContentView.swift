//
//  ContentView.swift
//  WordGarden
//
//  Created by David Veeneman on 10/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var wordsGuessed = 0
    @State private var wordsMissed = 0
    @State private var wordstoGuess = ["SWIFT", "DOG", "CAT"]
    @State private var currentWord = 0
    @State private var gameStatusMessage = "How many Guesses to Uncover the Hidden Word?"
    @State private var guessedLetter = ""
    @State private var imageName = "flower8"
    @State private var playAgainHidden = true
    
    var body: some View {
        VStack {
            HStack{
                VStack(alignment: .leading) {
                    Text("Words Guessed: \(wordsGuessed)")
                    Text("Words Missed: \(wordsMissed)")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Words to Guess: \(wordstoGuess.count - (wordsGuessed + wordsMissed))")
                    Text("Words in Game: \(wordstoGuess.count)")
                }
            }
            .padding()
            
            Spacer()
            
            Text(gameStatusMessage)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)
                .padding(/*@START_MENU_TOKEN@*/EdgeInsets()/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
            // TODO: Switch to wordsToGuess[currentWord]
            Text("_ _ _ _ _")
                .font(.title)
            
            if playAgainHidden {
                HStack {
                    TextField("", text: $guessedLetter)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 30)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.gray, lineWidth: 2)
                        }
                    
                    Button("Guess a letter"){
                        // TODO: Guess a Letter Button action here
                        playAgainHidden = false // TEMP
                    }
                    .buttonStyle(.bordered)
                    .tint(.mint)
                }
            } else {
                
                Button("Another Word?") {
                    // TODO: Another Word Button action here
                    playAgainHidden = true // TEMP
               }
                .buttonStyle(.borderedProminent)
                .tint(.mint)
                
            }
            Spacer()
            
            Image(imageName)
                .resizable()
                .scaledToFit()
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    ContentView()
}
