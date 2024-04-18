//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Yevhenii Burkovskyi on 16.04.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var scoreTitle = ""
    @State private var showScoreAlert = false
    
    @State private var score = 0
    @State private var questionNumber = 1
    
    var totalQuestions = 8
    
    func onPress (_ number: Int){
        
        if (number == correctAnswer){
            score+=1
        }else {
            scoreTitle = "Wrong, this is a flag of \(countries[number])"
            showScoreAlert = true
        }
        
        shuffleCards()
        
        if (questionNumber == 8 ){
            scoreTitle = "Your score is: \(score)"
            showScoreAlert = true
            return
        }
        
        questionNumber+=1
        
        
    }
    
    func onAlert (){
        if (questionNumber == totalQuestions){
            restartGame()
            return
        }
    }
    
    func shuffleCards (){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restartGame (){
        score = 0
        questionNumber = 1
        shuffleCards()
    }

    
    var body: some View {

        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack{
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                Text("Score \(score)")
                    .font(.title.weight(.bold))
                    .foregroundStyle(.white)
                Text("Question \(questionNumber) / \(totalQuestions)")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of").foregroundStyle(.secondary).font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer]).foregroundStyle(.secondary).font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0..<3) { number in
                        Button {
                           onPress(number)
                        } label: {
                            Image(countries[number])   .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                    
                }.alert(scoreTitle, isPresented: $showScoreAlert){
                    Button("Continue", action: onAlert)
                }.frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20)).padding()
            }
            
        }

        
    }
}

#Preview {
    ContentView()
}
