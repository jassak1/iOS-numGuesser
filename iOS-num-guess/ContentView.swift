//
//  ContentView.swift
//  GuessTheNum
//
//  Created by Kardan on 13/09/2020.
//  Copyright © 2020 Kardan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var nums:Array=["10","20","30","40","50"]
    @State private var field=Int.random(in: 0...4)
    @State private var picked=Int()
    @State private var inft=String()
    @State private var scoring:Int=0
    @State private var isUp:Bool=false
    @State private var dontRepeat:Bool=false
    @State private var alterter:Bool=false
    @State private var hintup=String()
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue,.red]), startPoint:.top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Guess the number on a card")
                    .padding()
                Picker("Choose a number",selection: $picked){
                    ForEach(0..<5){
                        Text(self.nums[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 20)
                Button(action:{
                    self.outmsg()
                    self.isUp=true
                    self.dontRepeat=true
                }){
                    //Rectangle(height:100,weight:100)
                    Text("Submit")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .padding(.horizontal,10)
                        .padding(.vertical,5)
                        .background(LinearGradient(gradient: Gradient(colors: [.gray,.black]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(5)
                        .shadow(color: .white, radius: 0.2, x: 1, y: 1)
                        .shadow(color: .black, radius: 0.2, x: -1, y: -1)
                        .padding(.top,30)
                }
                Button(action:{
                    self.field=Int.random(in: 0...4)
                    self.isUp=false
                    self.dontRepeat=false
                    self.inft="Guess a number"
                }){
                    self.imgreturn()
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Capsule())
                        .shadow(color:.white,radius: 20)
                        .padding(.top, 70)
                        .padding(.horizontal, 20)
                }
                Text(inft)
                    .font(.title)
                    .fontWeight(.black)
                    .padding(.top,50)
                Text("Your score: \(scoring)")
                    .padding(.top,50)
                Button(action:{
                    self.alterter=true
                }){
                    Text("Hint")
                }
                .padding(.top,100)
                .alert(isPresented: $alterter){
                    Alert(title: Text("HINT"),message: hintfield(),dismissButton:.default(Text("OK")))
                }
                    
                Spacer()
            }
        }
        
    }
    
    func outmsg(){
        if (nums[picked]==nums[field] && dontRepeat==false){
            inft="Correct!"
            scoring+=1
        }
        else if (nums[picked] != nums[field] && dontRepeat==false){
            inft="Try again!"
            (scoring>0) ? (scoring-=1) : (scoring=0)
        }
    }
    
    func imgreturn() -> Image {
        if isUp==true {
            return Image(nums[field])
        }
        else{
            return Image("rear")
        }
    }
    
    func hintfield()->Text{
        if (Int(nums[field]) ?? 0 >= 30) {
            return Text("Number is above (or equal) 30")
        }
        else{
            return Text("Number is below 30")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



