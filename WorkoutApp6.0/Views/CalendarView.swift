//
//  CalendarView.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/25/22.
//

import SwiftUI

class DateInfo: ObservableObject {
    @Published var currentDate: Date = Date()
    @Published var monthOffset = 0
}

struct CalendarView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var profile: ProfileManager
    @StateObject var dateInfo = DateInfo()
    @State var selectedDate: Date? = Date()
    
    var body: some View {
        let darkColor = colorScheme == .light ? Color.black : .white
        let lightColor = colorScheme == .light ? Color.white : .black
        
        ZStack {
            defaultPurple.opacity(0.5).ignoresSafeArea()
            // All info in view
            ScrollView {
                
                // Header
                ZStack {
                    HStack {
                        // Advances month by -1
                        Button {
                            withAnimation(Animation.easeInOut(duration: 0.3)) {
                                dateInfo.monthOffset -= 1
                                self.selectedDate = nil
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: screenWidth * 0.05))
                                .foregroundColor(darkColor)
                        }
                        .padding(.leading)
                        
                        Spacer()
                        
                        Text(getDate(getCurrentMonth(), format: "MMMM yyyy"))
                            .font(.system(size: screenWidth * 0.05, weight: .bold))
                            .padding(.horizontal)
                        
                        Spacer()
                        // Advances month by 1
                        Button {
                            withAnimation(Animation.easeInOut(duration: 0.3)) {
                                dateInfo.monthOffset += 1
                                self.selectedDate = nil
                            }
                        } label: {
                            Image(systemName: "chevron.right")
                                .font(.system(size: screenWidth * 0.05))
                                .foregroundColor(darkColor)
                        }
                        .padding(.trailing)
                            
                    }
                    .padding(.vertical, 7)
                    .frame(width: screenWidth * 0.7)
                    .background(
                            Capsule()
                                .fill(lightColor)
                        )
                    .shadow(color: footerPurple.opacity(0.3), radius: 30, x: 10, y: 30)
                    
                }
                
                // Calendar + rounded rectangle background
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(lightColor)
                        .shadow(color: footerPurple.opacity(0.2), radius: 30, x: 10, y: 30)

                    
                    // Calendar view
                    VStack(spacing: 0) {
                        
                        //Days of week
                        HStack(spacing: 0) {
                            let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
                            
                            ForEach(days, id: \.self) { day in
                                Text(day)
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .padding(.top)
                        .padding(.bottom, screenHeight * 0.05)
                        
                        
                        // Days of month grid
                        let columns = Array(repeating: GridItem(.flexible()), count: 7)
                        LazyVGrid(columns: columns, spacing: 0) {
                            
                            ForEach(self.extractDate()) { value in
                                // Day component
                                ZStack {
                                    let dayIsSelected = selectedDate != nil && selectedDate!.getDay() == value.day
                                    // Background circle for selected date
                                    Circle()
                                        .fill(dayIsSelected ? defaultPurple : lightColor)
                                        .frame(width: screenWidth * 0.1)
                                    
                                    // Prints day of month
                                    VStack(spacing: 0) {
                                        Text("\(value.day)")
                                            .font(.system(size: 20))
                                            .padding(8)
                                        // Changes text color to white if day is selected
                                            .foregroundColor(dayIsSelected ? lightColor : darkColor)
                                            .opacity(value.date > Date() && !dayIsSelected ? 0.3 : 1)
                                        
                                        // Draws circles below number for corresponding tasks
                                        if !dayIsSelected {
                                            HStack {
                                                let getColor = [0: Color.clear, 1: Color.red, 2: Color.yellow, 3: Color.green]
                                                
                                                // Draws circle based on tasks completed that day
                                                Circle()
                                                    .foregroundColor(getColor[calcTasksCompleted(value.date)] ?? Color.clear)
                                                    .frame(width: 5, height: 5)
                                                
                                            }
                                        }
                                        
                                    }
                                }
                                .frame(width: screenWidth * 0.15, height: screenWidth * 0.15)
                                .opacity(value.day == -1 ? 0 : 1)
                                .onTapGesture {
                                    // Sets selectedDate to day clicked on
                                    let dateString = "\(getCurrentMonth().getMonthAndYearFromDate()) \(value.day)"
                                    let formatter = DateFormatter()
                                    formatter.dateFormat = "MMMM yyyy dd"
                                    let date = formatter.date(from: dateString) ?? Date()
                                    
                                    if Date() > date {
                                        withAnimation(Animation.easeInOut(duration: 0.3)) {
                                            self.selectedDate = formatter.date(from: dateString)
                                        }
                                    }
                                }
                                
                            }
                        }
                        
                        Spacer()
                    
                    }
                    .padding(.horizontal)
                }
                .frame(width: screenWidth * 0.95)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top)

                
                
                
            }
            .frame(height: screenHeight * 0.9, alignment: .bottom)
            
            // Selected date pop up
            VStack {
                Spacer()
                SelectedDateView(selectedDate: self.$selectedDate)
                    .environmentObject(profile)
            }

        }
        .foregroundColor(darkColor)
        .frame(width: screenWidth, height: screenHeight)
        
    }
    
    // Gets current month based on current date offset by number of clicks on chevron left and right buttons
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: dateInfo.monthOffset, to: Date()) else { return Date() }
        
        return currentMonth
    }
    
    // Returns array of DateValues containing info of all dates in the month
    func extractDate() -> [DateValue] {
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getDaysInMonth().compactMap { date -> DateValue in
            let day = Calendar.current.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        let firstWeekday = Calendar.current.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday-1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
        
    }
    
    // Returns number of tasks completed on date inputted
    func calcTasksCompleted(_ date: Date) -> Int {
        var tasksCompleted = 0
        // Adds tasks based on whether or not they were completed
        if profile.abWorkoutDates.contains(getDate(date)) { tasksCompleted += 1}
        if profile.weightHistoryDates.contains(getDate(date)) { tasksCompleted += 1}
        if let i = profile.caloriesEatenHistoryDates.firstIndex(of: getDate(date)) {
            if i < profile.caloriesEatenHistory.count && profile.caloriesEatenHistory[i] > 0 { tasksCompleted += 1}
        }
        
        return tasksCompleted
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            CalendarView()
                .environmentObject(ProfileManager())
                .preferredColorScheme(.dark)
            Footer()
                .environmentObject(NavigationManager())
        }
    }
}
