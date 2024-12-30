//
//  OldWeightTrackerView.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/31/22.
//

import Foundation

//VStack {
//    Header(headerText: "Weight Trend")
//
//    // Average weight text
//    HStack(alignment: .top) {
//        VStack(alignment: .leading) {
//            Text("Average")
//                .font(.system(size: 15, weight: .medium))
//                .foregroundColor(.black.opacity(0.7))
//
//            HStack {
//                Text(String(format: "%.1f", self.getAverage()))
//                    //.id(self.graphModeSelected)
//                    .font(.system(size: 45, weight: .semibold))
//
//                Text("lbs")
//                    .foregroundColor(.black.opacity(0.7))
//            }
//
//            Text("Jun 17 - Jul 24, 2022")
//                .foregroundColor(.black.opacity(0.7))
//        }
//        .padding()
//
//        Spacer()
//    }
//
//    // Graph
//    let data = self.createGraphDataset()
//    ZStack {
//        Color.init(white: 0.98)
//
//
//        LineChart(chartData: data)
//                        .pointMarkers(chartData: data)
//                        .touchOverlay(chartData: data, specifier: "%.0f")
//                        .xAxisGrid(chartData: data)
//                        .yAxisGrid(chartData: data)
//                        //.xAxisLabels(chartData: data)
//                        .yAxisLabels(chartData: data)
//                        .infoBox(chartData: data)
//                        .headerBox(chartData: data)
//                        .legends(chartData: data, columns: [GridItem(.flexible()), GridItem(.flexible())])
//                        .id(data.id)
//    }
//    .frame(width: screenWidth * 0.9, height: screenHeight * 0.4)
//
//
//
//    // Buttons to change graph mode
//    HStack(spacing: 0) {
//        let graphModes = ["1 W", "1 M", "3 M", "6 M", "1 Y", "All"]
//        ForEach(0..<graphModes.count, id: \.self) { i in
//            ZStack {
//                Circle()
//                    .fill(self.graphModeSelected == i ? .black : .black.opacity(0.1))
//                    .frame(width: screenWidth * 0.12, height: screenWidth * 0.12)
//
//                Text(graphModes[i])
//                    .foregroundColor(self.graphModeSelected == i ? .white : .black)
//                    .font(.system(size: 15, weight: .bold))
//            }
//            .frame(maxWidth: .infinity)
//            .onTapGesture { withAnimation { self.graphModeSelected = i } }
//        }
//    }
//    .padding(.top)
//
//    Spacer()
//}
