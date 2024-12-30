//
//  MealEntry.swift
//  WorkoutApp6.0
//
//  Created by Rohan Kumar on 8/25/22.
//

import SwiftUI

struct CustomEntryField: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State var entryString: String = ""
    @State var currentDate: Date = Date()
    
    @Binding var toggleSheet: Bool
    @Binding var titleText: String
    @Binding var entryText: String
    @Binding var entryLabel: String
    var submitFunc: (String, Date)->()
    var showDatePicker: Bool
    
    init(_ titleText: Binding<String>, showDatePicker: Bool = true, entryText: Binding<String>, entryLabel: Binding<String>, toggleSheet: Binding<Bool>, submitFunc: @escaping (String, Date)->()) {
        self._titleText = titleText
        self.showDatePicker = showDatePicker
        self._entryText = entryText
        self._entryLabel = entryLabel
        self._toggleSheet = toggleSheet
        self.submitFunc = submitFunc
    }
    
    
    
    var body: some View {
        let darkColor = colorScheme == .light ? Color.black : .white
        VStack(spacing: 0) {
            
            // Header
            ZStack {
                Header(headerText: self.titleText)
                
                // X and check buttons
                HStack(spacing: screenWidth * 0.8) {
                    Button {
                        withAnimation { self.toggleSheet = false }
                    } label: {
                        Image(systemName: "xmark")
                    }
                        
                    Button {
                        self.submitFunc(self.entryString, self.currentDate)
                        self.entryString = ""
                        withAnimation { self.toggleSheet = false }
                    } label: {
                        Image(systemName: "checkmark")
                    }
                }
                .foregroundColor(.white)
            }
            
            
            Group {
            // Main entry field
                ZStack {
                    (darkColor.opacity(0.02))
                    
                    HStack {
                        Text(self.entryText)
                            .padding(.leading)
                        
                        Spacer()
                        
                        TextField("", text: self.$entryString)
                            .frame(width: self.entryText == "Username" ? 120 : 50)
                            .padding(5)
                            .background(darkColor.opacity(0.05))
                            .onSubmit {
                                submitFunc(self.entryString, self.currentDate)
                                self.entryString = ""
                            }
                        
                        Text(self.entryLabel)
                            .padding(.trailing)
                    }
                    .font(.system(size: 15))

                }
                if self.showDatePicker {
                    // Date picker field
                    ZStack {
                        darkColor.opacity(0.02)
                        
                        HStack {
                            Text("Date")
                                .font(.system(size: 15))
                                .padding(.leading)
                            
                            Spacer()
                            
                            DatePicker("", selection: self.$currentDate, displayedComponents: .date)
                                .padding(.trailing)
                        }
                    }
                }
            }
            .frame(height: UIScreen.main.bounds.height * 0.07)

            
            
            
            Spacer()
        }
    }
}

struct MealEntry_Previews: PreviewProvider {
    static var previews: some View {
        CustomEntryField(.constant("Enter Calories"), entryText: .constant("Meal Entry"), entryLabel: .constant("Calories"), toggleSheet: .constant(true)) { (text, date) in
            print(text)
        }
    }
}
