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
    @State private var currentWordIndex = 0
    @State private var wordToGuess = ""
    @State private var revealedWord = ""
    @State private var lettersGuessed = ""
    @State private var guessesRemaining = 8
    @State private var gameStatusMessage = "How many Guesses to Uncover the Hidden Word?"
    @State private var guessedLetter = ""
    @State private var imageName = "flower8"
    @State private var playAgainHidden = true
    @State private var playAgainButtonLabel = "Another Word?"
    @FocusState private var textFieldIsFocused: Bool
    
    private let wordstoGuess = ["SWIFT", "DOG", "CAT"]
    private let maximumGuesses = 8
    
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
                .font(.title)
                .multilineTextAlignment(.center)
                .frame(height: 80)
                .minimumScaleFactor(0.5)
                .padding()
            
            Spacer()
            
            // TODO: Switch to wordsToGuess[currentWord]
            Text(revealedWord)
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
                        .keyboardType(.asciiCapable)
                        .submitLabel(.done)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.characters)
                        .onChange(of: guessedLetter) {
                            guessedLetter = guessedLetter.trimmingCharacters(in: .letters.inverted)
                            guard let lastChar = guessedLetter.last else {
                                return
                            }
                            guessedLetter = String(lastChar).uppercased()
                        }
                        .onSubmit {
                            guard guessedLetter != "" else {
                                return
                            }
                            guessALetter()
                            updateGamePlay()
                        }
                        .focused($textFieldIsFocused)
                    
                    Button("Guess a letter"){
                        guessALetter()
                        updateGamePlay()
                    }
                    .buttonStyle(.bordered)
                    .tint(.mint)
                    .disabled(guessedLetter.isEmpty)
                }
            } else {
                Button(playAgainButtonLabel) {
                    
                    // If all words have been guessed...
                    if currentWordIndex == wordstoGuess.count {
                        currentWordIndex = 0
                        wordsGuessed = 0
                        wordsMissed = 0
                        playAgainButtonLabel = "Another Word?"
                    }
                    
                    // Reset after a word was guessed or missed
                    wordToGuess = wordstoGuess[currentWordIndex]
                    revealedWord = "_" + String(repeating: " _", count: wordToGuess.count - 1)
                    lettersGuessed = ""
                    guessesRemaining = maximumGuesses
                    imageName = "flower\(guessesRemaining)"
                    gameStatusMessage = "How many Guesses to Uncover the Hidden Word?"
                    playAgainHidden = true
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
        .onAppear() {
            wordToGuess = wordstoGuess[currentWordIndex]
            revealedWord = "_" + String(repeating: " _", count: wordToGuess.count-1)
            guessesRemaining = maximumGuesses
        }
    }
    
    func guessALetter() {
        textFieldIsFocused = false
        lettersGuessed += guessedLetter
        
        revealedWord = ""
        
        /* Iterate wordToGuess, checking if the letter appears in the list of guesses.
         If it does, add the letter and a space to revealedWord. if the letter hasn't
         been guessed yet, add an underscore and a space to revealedWord. */
        
        // Loop through all letters in wordToGuess
        for letter in wordToGuess {
            
            // Check letter in wordToGuess
            if lettersGuessed.contains(letter) {
                
                // Add letter and space to revealedWord
                revealedWord += "\(letter) "
                
            } else {
                // Add underscore and space to revealedWord
                revealedWord += "_ "
            }
        }
        revealedWord.removeLast()
        
    }
    
    func updateGamePlay () {
        
        //Decrement counter and update image
        if !wordToGuess .contains(guessedLetter) {
            guessesRemaining -= 1
            imageName = "flower\(guessesRemaining)"
        }
        
        // When do we play another word?
        if !revealedWord.contains("_") { // Guessed when no _ in revealedWord
            gameStatusMessage = "You've Guessed it! It Took You \(lettersGuessed.count) Guesses to Guess the Word"
            wordsGuessed += 1
            currentWordIndex += 1
            playAgainHidden = false
        } else if guessesRemaining == 0 { // Word missed
            gameStatusMessage = "So Sorry. You're All Out of Guesses."
            wordsMissed += 1
            playAgainHidden = false
        } else { // Keep guessing
            gameStatusMessage = "You've made \(lettersGuessed.count) guess\(lettersGuessed.count == 1 ? "" : "es")"
        }
        
        if currentWordIndex == wordstoGuess.count {
            playAgainButtonLabel = "Restart Game?"
            gameStatusMessage = "/nYou've Tried All the Words. Restart from the Beginning?"
        }
        
        //Clear letter from TextField
        guessedLetter = ""
        currentWordIndex += 1
    }
}

#Preview {
    ContentView()
}
