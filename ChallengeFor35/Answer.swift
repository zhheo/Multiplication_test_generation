//
//  Answer.swift
//  ChallengeFor35
//
//  Created by 张洪Hoo on 2020/4/6.
//  Copyright © 2020 张洪Hoo. All rights reserved.
//

import SwiftUI

struct Answer: View {
    var a = 0
    var b = 0
    @State private var input = ""
    @Binding var score: Int
    var trueAnswer: Int{
        a * b
    }
    
    @State private var alertShow = false
    @State private var alertTitle = "回答正确！"
    @State private var alertMessage = "1 X 1 = 1"
    
    var body: some View {
            Form {
                Section(header: Text("请输入 \(a) X \(b) 的答案"))  {
                    TextField("请输入答案", text: $input)
                        .keyboardType(.numberPad)
          }
        }
        .navigationBarTitle(Text("输入答案"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                if Int(self.input) == self.trueAnswer {
                    self.score += 1
                    self.alertTitle = "回答正确！"
                }else{
                    self.score += -1
                    self.alertTitle = "回答错误！"
                }
                
                self.alertMessage = "\(self.a) X \(self.b) = \(self.trueAnswer)"
                self.alertShow.toggle()
            }) {
                Text(self.input == "" ? "" : "提交")
        })
        
                .alert(isPresented: $alertShow){
                    Alert(title: Text(self.alertTitle), message: Text(self.alertMessage), dismissButton: .default(Text("确定")))
        }
    }
}

struct Answer_Previews: PreviewProvider {
    
    static var previews: some View {
        Answer(score: .constant(0))
    }
}
