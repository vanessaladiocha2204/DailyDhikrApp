//
//  File.swift
//  SmartDhikr
//
//  Created by Vanessa Ladiocha on 15/04/22.
//

import Foundation
import SwiftUI
import Combine

struct Counter : View {
    @State var dhikrName : String = ""
    @State var target : String = ""
    @State var count = 0
    
    
var body: some View {
    ZStack {
        Image("Count Design")
            .ignoresSafeArea()
        
        VStack{
            
            Text("\(dhikrName)")
                .frame(width: 318, height: 100, alignment: .center)
                .font(.system(size: 30, weight: .bold))
                //.foregroundColor(Color("Text"))
                //.padding(.bottom)
            CircleView(target: Float(target)!, count: count )
        }
    }
}

struct ProgressBar: View {
    @State var target : Float = 0.0
    @State var count : Int = 0
    @Binding var progress: Float
    var check : String = "Target Completed"
    var color: Color = Color.green
    var body: some View {
        
     
            Button(action: {
                count = 0
                self.progress = 0
            }, label: {
                Text("Reset")
                    .bold()
            })
            
            .padding(6)
            .foregroundColor(.white)
            .background(.red)
            .cornerRadius(10)
            .padding(.bottom, 125)
      
        
        
        ZStack(alignment: .center) {
           
            Button(action: {
               
                count += 1
                if (progress) < 1.0 {
                    self.progress += 1 / target
                }
                
               if count == Int(target){
                    let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                    impactHeavy.impactOccurred()
                }
                    }, label: {
                        Text("\(count)")
                            .font(.system(size: 100, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 300, height: 300)
                            .background(.yellow)
                            .clipShape(Circle())
            })
            
            Text("Tap")
                .bold()
                .padding(.top, 170)
                .font(.system(size: 20))
                .foregroundColor(.white)
                
            
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.20)
                .foregroundColor(Color.gray)
                .frame(width: 300, height: 300)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 0.5))
                .frame(width: 300, height: 300)
            
            if count == Int(target) || count >= Int(target) {
                Text(check)
                    .bold()
                    .foregroundColor(.brown)
                    .frame(width: 200, height: 200, alignment: .center)
                    .padding(.top, 400)
                }
        }
        .padding(.bottom, 150)
    }
}


struct CircleView: View {
    @State var target : Float = 0.0
    @State var count : Int = 0
    @State var progressValue: Float = 0.0
    var body: some View {
        VStack {
            ProgressBar(target: target, count: count, progress: self.$progressValue)
                .frame(width: 160.0, height: 160.0)
                .padding(20.0).onAppear() {
                    self.progressValue = 0.0
                }
            }
        }
    }
}

