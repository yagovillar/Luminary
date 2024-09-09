//
//  CustomSlider.swift
//  Luminary
//
//  Created by Yago Vanzan on 08/09/24.
//

import SwiftUI

struct CustomSlider: View {
    @Binding var value: Double
    var range: ClosedRange<Double> = 0...10
    var trackColor: Color = .white
    var sliderHeight: CGFloat = 5

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let progress = CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound)) * width
            
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(trackColor.opacity(0.3)) // Background track color
                    .frame(height: sliderHeight)
                
                Rectangle()
                    .fill(trackColor) // Filled track color
                    .frame(width: progress, height: sliderHeight)
            }
            .gesture(DragGesture(minimumDistance: 0).onChanged { gesture in
                let newValue = range.lowerBound + Double(gesture.location.x / width) * (range.upperBound - range.lowerBound)
                value = min(max(range.lowerBound, newValue), range.upperBound)
            })
        }
        .frame(height: sliderHeight)
    }
}


#Preview {
    CustomSlider(value: .constant(5.0))
}
