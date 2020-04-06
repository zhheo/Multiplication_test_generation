//
//  ContentView.swift
//  ChallengeFor35
//
//  Created by 张洪Hoo on 2020/4/5.
//  Copyright © 2020 张洪Hoo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var xnumber = [Multiplication(multiplierA: 1, multiplierB: 1)].shuffled()
    @State var questionNum = 5 //出题数量
    @State var xchoose = 1 //数字上限
    @State var score = 0
    
    @State var sheetShow = false
    
    
    var body: some View {
        NavigationView {
            Form {
                VStack {
                    Stepper(value: $xchoose, in: 1 ... 12) {
                        Text("乘法数字上限为 \(self.xchoose)")
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("请选择出题数量")
                    
                    Picker(selection: $questionNum, label: Text("生成的问题数")) {
                        Text("5").tag(5)
                        Text("10").tag(10)
                        Text("20").tag(20)
                        Text("全部").tag(4096)
                    }.pickerStyle(SegmentedPickerStyle())
                    
                }
                
                Text("当前得分 \(self.score)")
                
                Section(header: Text("题目列表")) {
//                    ForEach(self.xnumber) { item in
//                        Text("\(item.multiplierA) X \(item.multiplierB)")
//                    }
                    
                    if questionNum < xnumber.count {
                        ForEach(0 ..< self.questionNum, id: \.self){ item in
                            NavigationLink(destination: Answer(a: self.xnumber[item].multiplierA, b: self.xnumber[item].multiplierB, score: self.$score)) {
                            Text("\(self.xnumber[item].multiplierA) X \(self.xnumber[item].multiplierB)")
                            }
                            
                        }
                    }else{
                        ForEach(self.xnumber) { item in
                            NavigationLink(destination: Answer(a: item.multiplierA, b: item.multiplierB, score: self.$score)) {
                            Text("\(item.multiplierA) X \(item.multiplierB)")
                            }
                        }
                        
                        
                    }
                    
                    
                }
                

            }
            
            
            
            .navigationBarTitle(Text("乘法考题生成"), displayMode: .large)
            .navigationBarItems(trailing: Button(action: {
                self.questionMaker(maxnum: self.xchoose, in: self.questionNum)
                self.chooseQuestion()
                
            }) {
                Text("生成")
            })
        }
        
        .sheet(isPresented: $sheetShow){
            Answer(a: 1, b: 1, score: self.$score)
        }
    }
    
    func questionMaker(maxnum: Int, in questions: Int) {
        self.xnumber = [Multiplication]()
        
        for a in 1 ... maxnum {
            for b in 1 ... maxnum {
                self.xnumber.append(Multiplication(multiplierA: a, multiplierB: b))
                
            }
        }
    }
    
    func chooseQuestion() {
        xnumber.shuffle()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Multiplication: Identifiable {
    var id = UUID()
    var multiplierA: Int
    var multiplierB: Int
    var answer: Int {
        multiplierA * multiplierB
    }
}

