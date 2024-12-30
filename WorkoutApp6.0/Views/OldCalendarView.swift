//
//  OldCalendarView.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/31/22.
//

import Foundation


//VStack(spacing: 35) {
//
//    // Header
//    ZStack {
//        Header(headerText: getCurrentMonth().getMonthAndYearFromDate())
//
//        // Buttons to switch months
//        HStack(spacing: screenWidth * 0.5) {
//            Button {
//                withAnimation { selectedDate = nil }
//                dateInfo.monthOffset -= 1
//            } label: {
//                Image(systemName: "chevron.left")
//                    .foregroundColor(.white)
//                    .font(.system(size: 20, weight: .semibold))
//            }
//
//            Button {
//                withAnimation { selectedDate = nil }
//                dateInfo.monthOffset += 1
//            } label: {
//                Image(systemName: "chevron.right")
//                    .foregroundColor(.white)
//                    .font(.system(size: 20, weight: .semibold))
//            }
//        }
//    }
//
//    // Days of week
//    HStack(spacing: 0) {
//        let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
//
//        ForEach(days, id: \.self) { day in
//            Text(day)
//                .font(.callout)
//                .fontWeight(.semibold)
//                .frame(maxWidth: .infinity)
//        }
//    }
//
//    // Days of month grid
//    let columns = Array(repeating: GridItem(.flexible()), count: 7)
//    LazyVGrid(columns: columns, spacing: 0) {
//
//        ForEach(self.extractDate()) { value in
//            // Day component
//            ZStack {
//                let dayIsSelected = selectedDate != nil && selectedDate!.getDay() == value.day
//                // Background circle for selected date
//                Circle()
//                    .fill(dayIsSelected ? defaultPurple : .white)
//                    .frame(width: screenWidth * 0.1)
//
//                // Prints day of month
//                VStack(spacing: 0) {
//                    Text("\(value.day)")
//                        .font(.system(size: 20))
//                        .padding(8)
//
//                    // Changes text color to white if day is selected
//                        .foregroundColor(dayIsSelected ? .white : .black)
//
//                    // Draws circles below number for corresponding tasks
//                    if !dayIsSelected {
//                        HStack {
//                            // Draws orange circle if ab workout was completed that day
//                            Circle()
//                                .fill(profile.abWorkoutDates.contains(getDate(value.date)) ? .orange : .clear)
//                                .frame(width: 5, height: 5)
//
//                        }
//                    }
//
//                }
//            }
//            .frame(width: screenWidth * 0.15, height: screenWidth * 0.15)
//            .opacity(value.day == -1 ? 0 : 1)
//            .onTapGesture {
//                // Sets selectedDate to day clicked on
//                let dateString = "\(getCurrentMonth().getMonthAndYearFromDate()) \(value.day)"
//                let formatter = DateFormatter()
//                formatter.dateFormat = "MMMM yyyy dd"
//                withAnimation { self.selectedDate = formatter.date(from: dateString) }
//            }
//
//
//        }
//    }
//
//    Spacer()
//
//    SelectedDateView(selectedDate: self.$selectedDate)
//
//
//}
