//
//  ContentView.swift
//  gemini
//
//  Created by 堀内翔矢 on 2024/01/12.
//

import SwiftUI
import GoogleGenerativeAI
struct ContentView: View {
    let model = GenerativeModel(name: "gemini-pro", apiKey: "AIzaSyDIDuvo0DehKr4-FFk_9MA50oS5-OTUwbs")
    @State var textInput = ""
    @State var aiResponse = "GCHATへようこそ\n何をお手伝いしましょうか"
    var body: some View {
        VStack {
            Image(.GCHAT)
                .resizable()
                .scaledToFit()
                .frame(width: 400)
            ScrollView{
                Text(aiResponse)
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
            }
            HStack {
                TextField("テキストを入力してください", text: $textInput)
                    .fontWeight(.bold)
                    .textFieldStyle(.roundedBorder)
                    .foregroundStyle(.black)
                Button(action: sendMessage, label: {
                    Image(systemName: "paperplane.fill")
                })
            }
        }
        .foregroundStyle(.white)
        .padding()
        .background() {
            ZStack {
                Color.teal
                    .ignoresSafeArea()
            }
        }
    }
    
    func sendMessage(){
        aiResponse = ""
        Task{
            do{
                let response = try await model.generateContent(textInput)
                guard let text = response.text else {
                    textInput = "sorry Please try again"
                    return
                }
                textInput = ""
                aiResponse = text
            } catch {
                aiResponse = "Something went wrong.\n\(error.localizedDescription)"
            }
        }
    }
}

#Preview {
    ContentView()
}
