//
//  RollingText.swift
//  RollingCounterAnimation
//
//  Created by Daniel Spalek on 08/07/2022.
//

import SwiftUI

struct RollingText: View {
    
    // MARK: Text properties
    var font: Font = .largeTitle
    var weight: Font.Weight = .regular
    @Binding var value: Int
    
    // MARK: Animation properties
    @State var animationRange: [Int] = []
    
    var body: some View {
        HStack(spacing: 0){
            ForEach(0..<animationRange.count, id: \.self){ index in
                // MARK: to find text size for given font.
                // random number
                Text("8")
                    .font(font)
                    .fontWeight(weight)
                    .opacity(0)
                    .overlay{
                        GeometryReader{ proxy in
                            let size = proxy.size
                            
                            VStack(spacing: 0){
                                ForEach(0...9, id: \.self){ number in
                                    Text("\(number)")
                                        .font(font)
                                        .fontWeight(weight)
                                        .frame(width: size.width, height: size.height, alignment: .center)
                                }
                            }
                            // MARK: Setting offset
                            .offset(y: -CGFloat(animationRange[index]) * size.height)
                        }
                        .clipped()
                    }
            }
        }
        .onAppear{
            // MARK: Loading range
            animationRange = Array(repeating: 0, count: "\(value)".count)
            // we will start with a little delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.06){
                updateText()
            }
        }
        .onChange(of: value) { newValue in
            // MARK: Handling addition / removal of digit count from nunmber.
            let extra = "\(value)".count - animationRange.count
            if extra > 0{
                // adding extra digit
                for _ in 0..<extra{
                    withAnimation(.easeIn(duration: 0.1)){
                        animationRange.append(0)
                    }
                }
            }else{
                // removing digit
                for _ in 0..<(-extra){
                    withAnimation(.easeIn(duration: 0.1)){
                        animationRange.removeLast()
                    }
                }
            }
            
            // MARK: Adding a little delay for a nice look
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05){
                updateText()
            }
//            updateText()
        }
    }
    
    func updateText(){
        let stringValue = "\(value)"
        for (index, value) in zip(0..<stringValue.count, stringValue){
            // will build a pair containing index of number and the number itself
            
            // if the first value is 1, then offset will be applied for -1 so the text will move up to show the value 1.
            
            // MARK: DampingFraction depends on the index value.
            var fraction = Double(index) * 0.15
            // maximum is 0.5 and total is 1.5
            fraction = (fraction > 0.5 ? 0.5 : fraction)
            withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 1 + fraction, blendDuration: 1)){
                animationRange[index] = (String(value) as NSString).integerValue
            }
        }
    }
}

struct RollingText_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
