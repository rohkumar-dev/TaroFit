//
//  ProfileView.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/25/22.
//

import SwiftUI
import SwiftUICharts

struct WeightTrackerView: View {
    @Environment(\.colorScheme) var colorScheme

    @EnvironmentObject var profile: ProfileManager
    @State private var graphModeSelected = 0
    @State private var averageWeight: String = ""
    @State private var dateIntervalStr: String = ""
    
    
    var body: some View {
        let darkColor = colorScheme == .light ? Color.black : .white
        let lightColor = colorScheme == .light ? Color.white : .black
        
        ZStack {
            defaultPurple.opacity(0.5).ignoresSafeArea()

            ScrollView {
                VStack(spacing: screenHeight * 0.02) {
                    Text("Weight Trend")
                        .font(.system(size: 16, weight: .bold))
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background(
                            Capsule()
                                .fill(lightColor)
                        )
                        .shadow(color: footerPurple.opacity(0.3), radius: 10, x: 0, y: 10)
                    
                    
                    ZStack {
                        // White rounded rectangle background
                        RoundedRectangle(cornerRadius: 30)
                            .fill(lightColor)
                            .shadow(color: footerPurple.opacity(0.2), radius: 30, x: 10, y: 30)
                        
                        VStack(spacing: 0) {
                            
                            // Average weight text
                            HStack(alignment: .top) {
                                VStack(alignment: .leading) {
                                    Text("Average")
                                        .font(.system(size: 15, weight: .medium))
                                    
                                    HStack {
                                        Text(String(format: "%.1f", self.getAverage()))
                                            .font(.system(size: 45, weight: .semibold))
                                            .foregroundColor(darkColor)

                                        
                                        Text("lbs")
                                    }
                                    
                                    Text("\(getDate(self.calcFirstDate() ?? Date(), format: "MMM dd, yyyy")) - \(getDate(format: "MMM dd, yyyy"))")
                                }
                                .padding(.horizontal)
                                .padding(.top)
                                .foregroundColor(darkColor.opacity(0.7))

                                
                                Spacer()
                            }
                            
                            
                            
                            // Graph
                            let data = self.createGraphDataset()
                            ZStack {
                                
                                LineChart(chartData: data)
                                    .pointMarkers(chartData: data)
                                    .touchOverlay(chartData: data, specifier: "%.1f", unit: .suffix(of: "lbs"))
                                    .xAxisGrid(chartData: data)
                                    .yAxisGrid(chartData: data)
                                    .yAxisLabels(chartData: data)
                                    .infoBox(chartData: data, height: 1)
                                    .headerBox(chartData: data)
                                    .id(data.id)
                                    .yAxisPOI(chartData: data, markerName: "Goal Weight", markerValue: profile.goalWeight, labelColour: darkColor, labelBackground: lightColor, lineColour: .green.opacity(0.6))

                                
                            }
                            .frame(width: screenWidth * 0.85, height: screenHeight * 0.5)
                            
                            Spacer()
                            
                            // Buttons to change graph mode
                            HStack(spacing: 0) {
                                let graphModes = ["1 W", "1 M", "3 M", "6 M", "1 Y", "All"]
                                ForEach(0..<graphModes.count, id: \.self) { i in
                                    ZStack {
                                        Circle()
                                            .fill(darkColor.opacity(self.graphModeSelected == i ? 1 : colorScheme == .light ? 0.1 : 0.2))
                                            .frame(width: screenWidth * 0.12, height: screenWidth * 0.12)
                                        
                                        Text(graphModes[i])
                                            .foregroundColor(self.graphModeSelected == i ? lightColor : darkColor)
                                            .font(.system(size: 15, weight: .bold))
                                    }
                                    .frame(maxWidth: .infinity)
                                    .onTapGesture { withAnimation { self.graphModeSelected = i } }
                                }
                            }
                            .padding(.bottom)
                            
                        
                            
                        }
                        
                        
                    }
                    .frame(width: screenWidth * 0.95, height: screenHeight * 0.77)

                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(colorScheme == .light ? .black : .white)
    }
    
    
    func getAverage() -> Double {
        let firstDateDataPoint = calcFirstDate()
        var subArray: [Double] = []
        for i in 0..<profile.weightHistoryDates.count {
            if let currDate = getDate(profile.weightHistoryDates[i]), let firstDate = firstDateDataPoint {
                if currDate < firstDate {
                    continue
                }
            }
            
            subArray.append(profile.weightHistory[i])
        }
        
        return subArray.average
    }
    
    func calcFirstDate() -> Date? {
        var firstDateDataPoint: Date?
        let calendar = Calendar.current
        // Calculates first date of graph based on user graph mode
        switch self.graphModeSelected {
        case 0:
            firstDateDataPoint = calendar.date(byAdding: .weekOfYear, value: -1, to: Date())
        case 1:
            firstDateDataPoint = calendar.date(byAdding: .month, value: -1, to: Date())
        case 2:
            firstDateDataPoint = calendar.date(byAdding: .month, value: -3, to: Date())
        case 3:
            firstDateDataPoint = calendar.date(byAdding: .month, value: -6, to: Date())
        case 4:
            firstDateDataPoint = calendar.date(byAdding: .year, value: -1, to: Date())
        default:
            if profile.weightHistoryDates.count == 0 {
                firstDateDataPoint = Date()
            } else {
                firstDateDataPoint = getDate(profile.weightHistoryDates[0])
            }
        }
        
        return firstDateDataPoint
    }
    
    func createGraphDataset() -> LineChartData {
        var dataset = LineDataSet(
            dataPoints: [],
            pointStyle: PointStyle(),
            style: LineStyle(lineColour: ColourStyle(colour: defaultPurple), lineType: .curvedLine))
        
        let firstDateDataPoint = calcFirstDate()
        
        // Populates dataset and subArray
        for i in 0..<profile.weightHistoryDates.count {
            // Does not add current date and data if does not satisfy condition
            if let currDate = getDate(profile.weightHistoryDates[i]), let firstDate = firstDateDataPoint {
                
                if currDate < firstDate { continue }
            }
            
            dataset.dataPoints.append(
                LineChartDataPoint(
                    value: profile.weightHistory[i],
                    xAxisLabel: profile.weightHistoryDates[i],
                    date: getDate(profile.weightHistoryDates[i]),
                    pointColour: PointColour(border: shadowColor, fill: defaultPurple)))
        }
        
        let gridStyle  = GridStyle(numberOfLines: 7, lineColour: Color(.lightGray).opacity(0.5), lineWidth: 1, dash: [8], dashPhase: 0)
        
        let chartStyle = LineChartStyle(
                infoBoxPlacement    : .infoBox(isStatic: false),
                infoBoxValueColour: .black,
                infoBoxBackgroundColour: .white,
                infoBoxBorderColour : .black.opacity(0.4),
                infoBoxBorderStyle  : StrokeStyle(lineWidth: 1),
                
                
                                          
                markerType          : .vertical(attachment: .line(dot: .style(DotStyle()))),
                                          
                xAxisGridStyle      : gridStyle,
                xAxisLabelPosition  : .bottom,
                xAxisLabelColour    : Color.primary,
                xAxisLabelsFrom     : .dataPoint(rotation: .degrees(0)),
                                          
                yAxisGridStyle      : gridStyle,
                yAxisLabelPosition  : .leading,
                yAxisLabelColour    : Color.primary,
                yAxisNumberOfLabels : 7,
                                          
                baseline            : .minimumWithMaximum(of: profile.goalWeight != 0 ? profile.goalWeight : 100000),
                topLine             : .maximumValue,
                                          
                                          globalAnimation     : .easeOut(duration: 1))

        return LineChartData(dataSets       : dataset,
                             chartStyle     : chartStyle)
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        WeightTrackerView()
            .environmentObject(ProfileManager())
            .preferredColorScheme(.dark)
    }
}
