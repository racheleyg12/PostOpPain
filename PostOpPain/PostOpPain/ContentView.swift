//
//  ContentView.swift
//  PostOpPain
//
//  Created by Rachel Goldman on 11/1/20.
//  Copyright © 2020 Rachel Goldman. All rights reserved.
//

import SwiftUI

//GLOBAL VARIABLES
//Booleans for if symptom is checked, since a Struct is a value type, and therefore it is immutable
private var backPainChecked:Bool = false; private var bladderPainChecked:Bool = false; private var urinaryFrequencyChecked:Bool = false; private var dysuriaChecked:Bool = false; private var hematuriaChecked:Bool = false; private var feverChecked:Bool = false;  private var chillsChecked:Bool = false; private var nauseaAndVomitingChecked:Bool = false; private var uncontrolledPainChecked:Bool = false;
private var symptomsChecked = [backPainChecked, bladderPainChecked, urinaryFrequencyChecked, dysuriaChecked, hematuriaChecked, feverChecked, chillsChecked, nauseaAndVomitingChecked, uncontrolledPainChecked]

//ALL SYMPTOM Checkboxes initialized
private let backPain = CheckboxField(id: 0, name: "Back pain/Flank pain", size: 20, textSize: 20)
private let bladderPain = CheckboxField(id: 1, name: "Bladder pain/Bladder spasm", size: 20, textSize: 14)
private let urinaryFrequency = CheckboxField(id: 2, name: "Urinary Frequency & Urgency", size: 20, textSize: 14)
private let dysuria = CheckboxField(id: 3, name: "Dysuria/Burning with urination", size: 20, textSize: 14)
private let hematuria = CheckboxField(id: 4, name: "Hematuria/Blood in the urine", size: 20, textSize: 14)
//Post operative symptoms to warrant medical assistance:
private let fever = CheckboxField(id: 5, name: "Fever over 101.5", size: 20, textSize: 14)
private let chills = CheckboxField(id: 6, name: "Chills", size: 20, textSize: 14)
private let nauseaAndVomiting = CheckboxField(id: 7, name: "Nausea & vomiting/ Inability to eat or drink fluids", size: 20, textSize: 14)
private let uncontrolledPain = CheckboxField(id: 8, name: "Uncontrolled pain", size: 20, textSize: 14)

//Pain Buttons Mild-Severe, Note: States do not save variables
//For Back Pain Buttons Mild-Severe
private var tapMildBackPainGlobal:Bool = false
private var tapModerateBackPainGlobal:Bool = false
private var tapSevereBackPainGlobal:Bool = false
//For Bladder Pain Buttons Mild-Severe
private var tapMildBladderPainGlobal:Bool = false
private var tapModerateBladderPainGlobal:Bool = false
private var tapSevereBladderPainGlobal:Bool = false

//HOME SCREEN---------------------------------------------------------------------------------------------
struct ContentView: View {
    //Change between Views
    @State private var selection: String? = nil
    var body: some View {
        NavigationView {
            VStack(spacing: 10){
                Image("HomeImg")
                
                NavigationLink(destination: CheckUpView(), tag: "First", selection: $selection) { EmptyView() }
                Button (action: {
                    self.selection = "First"
                }){
                    Text("Check Up")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(10)
                    .background(Color("DarkGreen"))
                    .foregroundColor(.white)
                    .font(.title)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                }
                
                NavigationLink(destination: ProcedureView(), tag: "Second", selection: $selection) { EmptyView() }
                Button (action: {
                    self.selection = "Second"
                }){
                    Text("Learning The Procedure")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(10)
                    .background(Color("DarkGreen"))
                    .foregroundColor(.white)
                    .font(.title)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                    
                }
                
                NavigationLink(destination: MedicationView(),tag: "Third", selection: $selection) { EmptyView() }
                Button (action: {
                    self.selection = "Third"
                }){
                    Text("Medication Options")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(10)
                    .background(Color("DarkGreen"))
                    .foregroundColor(.white)
                    .font(.title)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                    
                }
            }
            //.background(Color.blue)
            .padding(EdgeInsets(top: -80, leading: 0, bottom: 0, trailing: 0))
            .navigationBarTitle("Post Op Pain")
        }
    }
}

//Makes Checkbox Field for Symptoms
struct CheckboxField: View {
    let id: Int
    let name: String
    let size: CGFloat
    let color: Color
    let textSize: Int
    //var checked: Bool
    
    init(
        id: Int,
        name: String,
        size: CGFloat = 10,
        color: Color = Color.black,
        textSize: Int = 14
        ) {
        self.id = id
        self.name = name
        self.size = size
        self.color = color
        self.textSize = textSize
    }
    
    @State var isMarked:Bool = false    //Set as not checked
    
    //Makes button view
    var body: some View {
        Button(action:{
            //Checked or not
            if (!self.isMarked){         //If not checked set as checked
                self.isMarked = true
                symptomsChecked[self.id] = true
            } else {
                self.isMarked = false
                symptomsChecked[self.id] = false
            }
            
        }) { HStack(spacing: 10) {
                Image(systemName: self.isMarked ? "checkmark.square" : "square")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: self.size, height: self.size)
                Text(name)
                    .font(Font.system(size: size))
                Spacer()
            }.foregroundColor(self.color)
        }
        .foregroundColor(Color.white)
        .padding(.leading, 10)
    }
    //ALERT FOR SYMPTOMS TO WARRANT MEDICAL ASSISTANCE
}
//CHECK UP VIEW---------------------------------------------------------------------------------------------------------
struct CheckUpView: View {
    //When button is clicked
    @State private var showContentView:Bool = false
    //Go back to root
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    //For Back Pain Buttons Mild-Severe
    @State private var tapMildBackPain:Bool = false
    @State private var tapModerateBackPain:Bool = false
    @State private var tapSevereBackPain:Bool = false
    @State private var borderWidthsBackPain:[CGFloat] = [2, 2, 2]
    @State private var backgroundColorsBackPain:[Color] = [.white, .white, .white]
    //For Bladder Pain Buttons Mild-Severe
    @State private var tapMildBladderPain:Bool = false
    @State private var tapModerateBladderPain:Bool = false
    @State private var tapSevereBladderPain:Bool = false
    @State private var borderWidthsBladderPain:[CGFloat] = [2, 2, 2]
    @State private var backgroundColorsBladderPain:[Color] = [.white, .white, .white]
    //Makes sure user selects the textbox first
    @State private var showingTextboxAlertBack = false
    @State private var showingTextboxAlertBladder = false
    
    var body: some View {
        ScrollView (.vertical) {
            VStack (spacing: 10){
                //Title
                Text("Check Up").fontWeight(.bold).font(.largeTitle)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: -15, leading: 10, bottom: 0, trailing: 20))
                HStack(spacing: 0){
                    //Icon
                    Image("CheckUpIconImg").resizable().frame(width: 55, height: 55)
                    //Subtitle
                    Text("Select the symptoms you are feeling:").font(.system(size: 25, weight: .bold))
                    .frame(width: 250, height: 60, alignment: .topLeading)
                    .padding(.leading, 10)
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 12, trailing: 0))
                //VStack does not allow over 10 items/views
                Group {
                    //Back Pain Check Boxes and Buttons Mild to Sever
                    backPain
                    //Buttons Mild to Sever
                    HStack(spacing: 10){
                        Button(action:{
                            if (!symptomsChecked[0]){
                                self.showingTextboxAlertBack = true
                            } else {
                                self.showingTextboxAlertBack = false
                            }
                            if (symptomsChecked[0] && !self.showingTextboxAlertBack){
                                //Turn white/unclick
                                if (self.tapMildBackPain){
                                    tapMildBackPainGlobal = false
                                    self.tapMildBackPain = false
                                    self.borderWidthsBackPain[0] = 2
                                    self.backgroundColorsBackPain[0] = .white
                                }
                                //Turn green/click
                                else if (!self.tapMildBackPain || (self.tapModerateBackPain || self.tapSevereBackPain)) {
                                    tapMildBackPainGlobal = true
                                    self.tapMildBackPain = true
                                    self.borderWidthsBackPain[0] = 0
                                    self.backgroundColorsBackPain[0] = Color("UVMMedicalCenterGreen")
                                    
                                    tapModerateBackPainGlobal = false
                                    self.tapModerateBackPain = false
                                    self.borderWidthsBackPain[1] = 2
                                    self.backgroundColorsBackPain[1] = .white
                                    
                                    tapSevereBackPainGlobal = false
                                    self.tapSevereBackPain = false
                                    self.borderWidthsBackPain[2] = 2
                                    self.backgroundColorsBackPain[2] = .white
                                }
                            }
                        }){
                            Text("Mild").font(.system(size: 16))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .foregroundColor(tapMildBackPain ? .white : .black)
                            .background(backgroundColorsBackPain[0])
                            .cornerRadius(6)
                            .font(.title)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.black, lineWidth: self.borderWidthsBackPain[0])
                            )
                            .alert(isPresented: $showingTextboxAlertBack) {
                                Alert(title: Text("Check Checkbox First"),message: Text("Please press the Back Pain/Flank Pain checkbox first"), dismissButton: .default(Text("Got it!")))
                            }
                        }
                        Button(action:{
                            if (!symptomsChecked[0]){
                                self.showingTextboxAlertBack = true
                            } else {
                                self.showingTextboxAlertBack = false
                            }
                            if (symptomsChecked[0] && !self.showingTextboxAlertBack){
                                //Turn white/unclick
                                if (self.tapModerateBackPain){
                                    tapModerateBackPainGlobal = false
                                    self.tapModerateBackPain = false
                                    self.borderWidthsBackPain[1] = 2
                                    self.backgroundColorsBackPain[1] = .white
                                }
                                //Turn green/click
                                else if (!self.tapModerateBackPain || (self.tapMildBackPain || self.tapSevereBackPain)){
                                    tapModerateBackPainGlobal = true
                                    self.tapModerateBackPain = true
                                    self.borderWidthsBackPain[1] = 0
                                    self.backgroundColorsBackPain[1] = Color("UVMMedicalCenterGreen")
                                    
                                    tapMildBackPainGlobal = false
                                    self.tapMildBackPain = false
                                    self.borderWidthsBackPain[0] = 2
                                    self.backgroundColorsBackPain[0] = .white
                                    
                                    tapSevereBackPainGlobal = false
                                    self.tapSevereBackPain = false
                                    self.borderWidthsBackPain[2] = 2
                                    self.backgroundColorsBackPain[2] = .white
                                }
                            }
                            
                        }){
                            Text("Moderate").font(.system(size: 16))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .foregroundColor(tapModerateBackPain ? .white : .black)
                            .background(backgroundColorsBackPain[1])
                            .cornerRadius(6)
                            .font(.title)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.black, lineWidth: self.borderWidthsBackPain[1])
                            )
                            .alert(isPresented: $showingTextboxAlertBack) {
                                Alert(title: Text("Check Checkbox First"),message: Text("Please press the Back Pain/Flank Pain checkbox first"), dismissButton: .default(Text("Got it!")))
                            }
                        }
                        Button(action:{
                            //Make sure to check checkbox first
                            if (!symptomsChecked[0]){
                                self.showingTextboxAlertBack = true
                            } else {
                                self.showingTextboxAlertBack = false
                            }
                            if (symptomsChecked[0] && !self.showingTextboxAlertBack){
                                //Turn white/unclick
                                if (self.tapSevereBackPain){
                                    tapSevereBackPainGlobal = false
                                    self.tapSevereBackPain = false
                                    self.borderWidthsBackPain[2] = 2
                                    self.backgroundColorsBackPain[2] = .white
                                //Turn green/click
                                } else if (!self.tapSevereBackPain || (self.tapMildBackPain || self.tapModerateBackPain)) {
                                    tapSevereBackPainGlobal = true
                                    self.tapSevereBackPain = true
                                    self.borderWidthsBackPain[2] = 0
                                    self.backgroundColorsBackPain[2] = Color("UVMMedicalCenterGreen")
                                    
                                    tapModerateBackPainGlobal = false
                                    self.tapModerateBackPain = false
                                    self.borderWidthsBackPain[1] = 2
                                    self.backgroundColorsBackPain[1] = .white
                                    
                                    tapMildBackPainGlobal = false
                                    self.tapMildBackPain = false
                                    self.borderWidthsBackPain[0] = 2
                                    self.backgroundColorsBackPain[0] = .white
                                }
                            }
                        }){
                            Text("Severe").font(.system(size: 16))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .foregroundColor(tapSevereBackPain ? .white : .black)
                            .background(backgroundColorsBackPain[2])
                            .cornerRadius(6)
                            .font(.title)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color.black, lineWidth: self.borderWidthsBackPain[2])
                            )
                            .alert(isPresented: $showingTextboxAlertBack) {
                                Alert(title: Text("Check Checkbox First"),message: Text("Please press the Back Pain/Flank Pain checkbox first"), dismissButton: .default(Text("Got it!")))
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 30))
                    
                    //Bladder Pain Checkbox & Buttons
                    Group{
                        bladderPain
                        //Buttons Mild to Sever
                        HStack(spacing: 10){
                            Button(action:{
                                //Make sure to check checkbox first
                                if (!symptomsChecked[1]){
                                    self.showingTextboxAlertBladder = true
                                } else {
                                    self.showingTextboxAlertBladder = false
                                }
                                if (symptomsChecked[1] && !self.showingTextboxAlertBack){
                                    //Turn white
                                    if (self.tapMildBladderPain){
                                        tapMildBladderPainGlobal = false
                                        self.tapMildBladderPain = false
                                        self.borderWidthsBladderPain[0] = 2
                                        self.backgroundColorsBladderPain[0] = .white
                                    }
                                    //Turn green
                                    else if (!self.tapMildBladderPain || (self.tapModerateBladderPain || self.tapSevereBladderPain)) {
                                        tapMildBladderPainGlobal = true
                                        self.tapMildBladderPain = true
                                        self.borderWidthsBladderPain[0] = 0
                                        self.backgroundColorsBladderPain[0] = Color("UVMMedicalCenterGreen")
                                        
                                        tapModerateBladderPainGlobal = false
                                        self.tapModerateBladderPain = false
                                        self.borderWidthsBladderPain[1] = 2
                                        self.backgroundColorsBladderPain[1] = .white
                                        
                                        tapSevereBladderPainGlobal = false
                                        self.tapSevereBladderPain = false
                                        self.borderWidthsBladderPain[2] = 2
                                        self.backgroundColorsBladderPain[2] = .white
                                        
                                    }
                                }
                            }){
                                Text("Mild").font(.system(size: 16))
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding(.vertical, 8)
                                .foregroundColor(tapMildBladderPain ? .white : .black)
                                .background(backgroundColorsBladderPain[0])
                                .cornerRadius(6)
                                .font(.title)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.black, lineWidth: self.borderWidthsBladderPain[0])
                                )
                                .alert(isPresented: $showingTextboxAlertBladder) {
                                    Alert(title: Text("Check Checkbox First"),message: Text("Please press the Bladder pain/Bladder spasm checkbox first"), dismissButton: .default(Text("Got it!")))
                                }
                            }
                            Button(action:{
                                //Make sure to check checkbox first
                                if (!symptomsChecked[1]){
                                    self.showingTextboxAlertBladder = true
                                } else {
                                    self.showingTextboxAlertBladder = false
                                }
                                if (symptomsChecked[1] && !self.showingTextboxAlertBack){
                                    if (self.tapModerateBladderPain){
                                        tapModerateBladderPainGlobal = false
                                        self.tapModerateBladderPain = false
                                        self.borderWidthsBladderPain[1] = 2
                                        self.backgroundColorsBladderPain[1] = .white
                                    }
                                    //Turn green
                                    else if (!self.tapModerateBladderPain || (self.tapMildBladderPain || self.tapSevereBladderPain)){
                                        tapModerateBladderPainGlobal = true
                                        self.tapModerateBladderPain = true
                                        self.borderWidthsBladderPain[1] = 0
                                        self.backgroundColorsBladderPain[1] = Color("UVMMedicalCenterGreen")
                                        
                                        tapMildBladderPainGlobal = false
                                        self.tapMildBladderPain = false
                                        self.borderWidthsBladderPain[0] = 2
                                        self.backgroundColorsBladderPain[0] = .white
                                        
                                        tapSevereBladderPainGlobal = false
                                        self.tapSevereBladderPain = false
                                        self.borderWidthsBladderPain[2] = 2
                                        self.backgroundColorsBladderPain[2] = .white
                                    }
                                }
                                
                            }){
                                Text("Moderate").font(.system(size: 16))
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding(.vertical, 8)
                                .foregroundColor(tapModerateBladderPain ? .white : .black)
                                .background(backgroundColorsBladderPain[1])
                                .cornerRadius(6)
                                .font(.title)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.black, lineWidth: self.borderWidthsBladderPain[1])
                                )
                                .alert(isPresented: $showingTextboxAlertBladder) {
                                    Alert(title: Text("Check Checkbox First"),message: Text("Please press the Bladder pain/Bladder spasm checkbox first"), dismissButton: .default(Text("Got it!")))
                                }
                            }
                            Button(action:{
                                //Make sure to check checkbox first
                                if (!symptomsChecked[1]){
                                    self.showingTextboxAlertBladder = true
                                } else {
                                    self.showingTextboxAlertBladder = false
                                }
                                if (symptomsChecked[1] && !self.showingTextboxAlertBack){
                                    if (self.tapSevereBladderPain){
                                        tapSevereBladderPainGlobal = false
                                        self.tapSevereBladderPain = false
                                        self.borderWidthsBladderPain[2] = 2
                                        self.backgroundColorsBladderPain[2] = .white
                                    } else if (!self.tapSevereBladderPain || (self.tapMildBladderPain || self.tapModerateBladderPain)) {
                                        tapSevereBladderPainGlobal = true
                                        self.tapSevereBladderPain = true
                                        self.borderWidthsBladderPain[2] = 0
                                        self.backgroundColorsBladderPain[2] = Color("UVMMedicalCenterGreen")
                                        
                                        tapModerateBladderPainGlobal = false
                                        self.tapModerateBladderPain = false
                                        self.borderWidthsBladderPain[1] = 2
                                        self.backgroundColorsBladderPain[1] = .white
                                        
                                        tapMildBladderPainGlobal = false
                                        self.tapMildBladderPain = false
                                        self.borderWidthsBladderPain[0] = 2
                                        self.backgroundColorsBladderPain[0] = .white
                                    }
                                }
                                
                            }){
                                Text("Severe").font(.system(size: 16))
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding(.vertical, 8)
                                .foregroundColor(tapSevereBladderPain ? .white : .black)
                                .background(backgroundColorsBladderPain[2])
                                .cornerRadius(6)
                                .font(.title)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.black, lineWidth: self.borderWidthsBladderPain[2])
                                )
                                .alert(isPresented: $showingTextboxAlertBladder) {
                                    Alert(title: Text("Check Checkbox First"),message: Text("Please press the Bladder pain/Bladder spasm checkbox first"), dismissButton: .default(Text("Got it!")))
                                }
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 30))
                    }
                    urinaryFrequency
                    dysuria
                    hematuria
                  
                    fever
                    chills
                    nauseaAndVomiting
                    uncontrolledPain
                }
            
                
                Button(action: {
                    //Print Statements
                    print("Submit Button Pressed:")
                    //Status of check boxes
                    print("\(backPain.name) is checked: \(symptomsChecked[backPain.id])")
                    print("\(bladderPain.name) is checked: \(symptomsChecked[bladderPain.id])")
                    print("\(urinaryFrequency.name) is checked: \(symptomsChecked[urinaryFrequency.id])")
                    print("\(dysuria.name) is checked: \(symptomsChecked[dysuria.id])")
                    print("\(hematuria.name) is checked: \(symptomsChecked[hematuria.id])")
                    print("\(fever.name) is checked: \(symptomsChecked[fever.id])")
                    print("\(chills.name) is checked: \(symptomsChecked[fever.id])")
                    print("\(nauseaAndVomiting.name) is checked: \(symptomsChecked[nauseaAndVomiting.id])")
                    print("\(uncontrolledPain.name) is checked: \(symptomsChecked[uncontrolledPain.id])")
                    
                    //Status of Buttons Mild - Severe:
                    print("\(backPain.name) is mild: \(tapMildBackPainGlobal)")
                    print("\(backPain.name) is moderate: \(tapModerateBackPainGlobal)")
                    print("\(backPain.name) is severe: \(tapSevereBackPainGlobal)")
                    
                    print("\(bladderPain.name) is mild: \(tapMildBladderPainGlobal)")
                    print("\(bladderPain.name) is moderate: \(tapModerateBladderPainGlobal)")
                    print("\(bladderPain.name) is severe: \(tapSevereBladderPainGlobal)")
                    
                    //Reset check symptoms
                    for index in 0...(symptomsChecked.count-1) {
                        symptomsChecked[index] = false
                    }
                    //Reset Buttons
                    tapMildBackPainGlobal = false
                    tapModerateBackPainGlobal = false
                    tapSevereBackPainGlobal = false
                    tapMildBladderPainGlobal = false
                    tapModerateBladderPainGlobal = false
                    tapSevereBladderPainGlobal = false
                    
                    //Back to main/home page/root
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    // How the button looks like
                    Text("Submit")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(10)
                    .background(Color("UVMMedicalCenterGreen"))
                    .foregroundColor(.white)
                    .font(.title)
                    .cornerRadius(10)
                    .padding(.horizontal, 50)
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                //POSSIBLY A THANK YOU, HAVE A NICE DAY FOR SUBMITTING SYMPTOMS
            
            }.padding(EdgeInsets(top: -35, leading: 20, bottom: 0, trailing: 20))
        
        }
    }
}
//PROCEDURE SCREEN----------------------------------------------------------------------------------------------
struct ProcedureView: View {
    //Navigation
    @State private var selection: String? = nil
    //When button is clicked
    @State private var showContentView:Bool = false
    //Go back to root
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView (.vertical) {
            //Change srceen between Views
            VStack (spacing: 10){   //The big one - for the whole screen
                //Title
                HStack (spacing: 5){
                    Text("Ureteroscopy Procedure").fontWeight(.bold).font(.largeTitle)
                    .frame(width: 218, height: 85, alignment: .topLeading)
                    .padding(EdgeInsets(top: 0, leading: -10, bottom: 0, trailing: 0))
                    
                    //Procedure Picture
                    //https://www.pngwave.com/png-clip-art-ceqdb/download
                    Image("ProcedureImg").resizable().frame(width: 91, height: 90)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .padding(.bottom, 10)
                        
                NavigationLink(destination: UnderstandingTheProcedureView(), tag: "First", selection: $selection) { EmptyView() }
                Button (action: {
                    self.selection = "First"
                }){
                    VStack{
                        Text("Understanding the")
                        Text("Procedure")
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(10)
                    .background(Color("UVMMedicalCenterGreen"))
                    .foregroundColor(.white)
                    .font(.title)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                }
                
                NavigationLink(destination: whatToExpectView(), tag: "Second", selection: $selection) { EmptyView() }
                Button (action: {
                    self.selection = "Second"
                }){
                    Text("What To Expect After")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(10)
                    .background(Color("UVMMedicalCenterGreen"))
                    .foregroundColor(.white)
                    .font(.title)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                    
                }
                
                NavigationLink(destination: whenToSeekHelpView(),tag: "Third", selection: $selection) { EmptyView() }
                Button (action: {
                    self.selection = "Third"
                }){
                    Text("When to Seek Help")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(10)
                    .background(Color("UVMMedicalCenterGreen"))
                    .foregroundColor(.white)
                    .font(.title)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
                    
                }
                
                Button(action: {
                    //Back to main/home page/root
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    // How the button looks like
                    Text("Back")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(10)
                    .background(Color("UVMMedicalCenterGreen"))
                    .foregroundColor(.white)
                    .font(.title)
                    .cornerRadius(10)
                    .padding(.horizontal, 100)
                }
                .padding(EdgeInsets(top: 25, leading: 0, bottom: 25, trailing: 0))
                //POSSIBLY A THANK YOU, HAVE A NICE DAY FOR SUBMITTING SYMPTOMS
            }
            //End of VStack
        }
    }
        
}
//UNDERSTANDING THE PROCEDURE View
struct UnderstandingTheProcedureView: View {
    //Go back to pervious screen
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        ScrollView (.vertical) {
            VStack {
                //Title
                Text("Understand the Procedure").font(.system(size: 30, weight: .bold))
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    //The frame around it
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                //https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcKdcCLKNs_K2RLIE25YYxPZsWKOQY1KxYcA&usqp=CAU
                //The Information
                VStack (alignment: .leading, spacing: 10){
                    //https://www.hopkinsmedicine.org/health/treatment-tests-and-therapies/ureteroscopy
                    Text("Ureteroscopy is a procedure to address kidney stones, and involves the passage of a small telescope, called a ureteroscope, through the urethra and bladder and up the ureter to the point where the stone is located. Ureteroscopy is typically performed under general anesthesia, and the procedure usually lasts from one to three hours.")
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                //https://kidneystonemelbourne.com.au/sites/default/files/styles/large/public/ureteroscopy-ureteropyeloscopy-pyeloscopy.jpg?itok=HkYiabTl
                //Ureteroscopy Image
                Image("UreteroscopyImg").resizable().frame(width: 350, height: 350)
                VStack (alignment: .leading, spacing: 15){
                    Text("If the stone is small, it may be snared with a basket device and removed whole from the ureter. If the stone is large, or if the diameter of the ureter is narrow, the stone will need to be fragmented, which is usually accomplished with a laser. Once the stone is broken into tiny pieces, these pieces are removed.")

                    Text("The passage of the ureteroscope may result in swelling in the ureter. Therefore, it may be necessary to temporarily leave a small tube, called a ureteral stent, inside the ureter temporarily to ensure that the kidney drains urine well.")
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                //https://images.squarespace-cdn.com/content/v1/53222c80e4b054545c86bec9/1424645280396-M5SQB21ECSCQKO2MSZVH/ke17ZwdGBToddI8pDm48kB80eW4KK5wgMfkTp6SjTNtZw-zPPgdn4jUwVcJE1ZvWQUxwkmyExglNqGp0IvTJZUJFbgE-7XRK3dMEBRBhUpxkEDnlqEYEiGVDb0kl5jpOJsm5iyfgdjNZyk67t96-U_4JMfIDDY8RGcVnRlrKExA/image-asset.jpeg
                //Ureteral stent Image
                Image("UreteralStentImg").resizable().frame(width: 350, height: 350)
                VStack (alignment: .leading, spacing: 10){
                    Text("Ureteroscopy usually can be performed as an outpatient procedure, however; patients may require an overnight hospital stay if the procedure proves lengthy or difficult.")
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            .padding(EdgeInsets(top: -55, leading: 0, bottom: 0, trailing: 0))
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                HStack{
                Image(systemName: "arrow.left")
                Text("Back").foregroundColor(.blue)
                    
                }
            })
            Button(action: {
                //Back to main/home page/root
                self.presentationMode.wrappedValue.dismiss()
            }) {
                // How the button looks like
                Text("Done")
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(10)
                .background(Color("UVMMedicalCenterGreen"))
                .foregroundColor(.white)
                .font(.title)
                .cornerRadius(10)
                .padding(.horizontal, 110)
                .padding(.top, 20)
                .padding(.bottom, 30)
            }
        }
    }
}
//WHAT TO EXPECT - Know what symptoms are to be expected - View
struct whatToExpectView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ScrollView (.vertical) {
            //WHAT TO EXPECT - Know what symptoms are to be expected
            //https://www.hopkinsmedicine.org/brady-urology-institute/specialties/divisions-programs/minimally-invasive-surgery/kidney-stones/ureteroscopy.html
            VStack {
                //Title
                Text("What To Expect").font(.system(size: 30, weight: .bold))
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
                    //The frame around it
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    //.background(Color.green)
                VStack (alignment: .leading, spacing: 25){
                    //https://www.hopkinsmedicine.org/health/treatment-tests-and-therapies/ureteroscopy
                    Text("Common Symptoms to Expect Post-Operation:").font(.system(size: 25, weight: .bold))
                    HStack{
                        Text("• Mild back/flank discomfort").font(.system(size: 21)).bold()
                        Image("BackPainImg").resizable().frame(width: 125, height: 125)
                            //.padding(.horizontal, 100)
                    }
                    HStack{
                        Text("• Urinary Frequency/urgency").font(.system(size: 21)).bold()
                        //https://thenounproject.com/term/pee-urgency/1926303/
                        Image("UrinationFrequencyImg").resizable().frame(width: 125, height: 125)
                            //.padding(.horizontal, 100)
                    }
                    HStack{
                        Text("• Irritation when urinating").font(.system(size: 21)).bold()
                        Image("IrritationImg").resizable().frame(width: 52, height: 125)
                            //.padding(.horizontal, 100)
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            .padding(EdgeInsets(top: -55, leading: 0, bottom: 0, trailing: 0))
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                HStack{
                Image(systemName: "arrow.left")
                Text("Back").foregroundColor(.blue)
                    
                }
            })
            
            Button(action: {
                //Back to main/home page/root
                self.presentationMode.wrappedValue.dismiss()
            }) {
                // How the button looks like
                Text("Done")
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(10)
                .background(Color("UVMMedicalCenterGreen"))
                .foregroundColor(.white)
                .font(.title)
                .cornerRadius(10)
                .padding(.horizontal, 110)
                .padding(.top, 20)
                .padding(.bottom, 30)
            }
        }
    }
}
//WHEN TO SEEK HELP - What symptoms that you need to seek assistance
struct whenToSeekHelpView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ScrollView (.vertical) {
            //https://4bgepg1xn2m716etsr27al3n-wpengine.netdna-ssl.com/wp-content/uploads/2019/01/warning_icon.png
            VStack {
                //Title
                Text("When To Seek Help").font(.system(size: 30, weight: .bold))
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
                    //The frame around it
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    //.background(Color.green)
                //Seek Help Img
                Image("SeekHelpImg").resizable().frame(width: 125, height: 125)
                VStack (alignment: .leading, spacing: 10){
                    //https://www.hopkinsmedicine.org/health/treatment-tests-and-therapies/ureteroscopy
                    Text("Symptoms to Call for Help:").font(.system(size: 25, weight: .bold))
                    Text("• Fevers").font(.system(size: 21)).bold()
                    Text("• Chills").font(.system(size: 21)).bold()
                    Text("• Nausea and Vomiting").font(.system(size: 21)).bold()
                    Text("• Inability to eat or drink fluids").font(.system(size: 21)).bold()
                    Text("• Inability to urinate").font(.system(size: 21)).bold()
                    Text("• Uncontrolled pain/Pain not controlled with meds given").font(.system(size: 21)).bold()
                    Text("• Large amounts of blood in the urine").font(.system(size: 21)).bold()
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Button(action: {
                    //Back to main/home page/root
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    // How the button looks like
                    Text("Done")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(10)
                    .background(Color("UVMMedicalCenterGreen"))
                    .foregroundColor(.white)
                    .font(.title)
                    .cornerRadius(10)
                    .padding(.horizontal, 110)
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                }
            
            }
            .padding(EdgeInsets(top: -55, leading: 0, bottom: 0, trailing: 0))
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                HStack{
                Image(systemName: "arrow.left")
                Text("Back").foregroundColor(.blue)
                    
                }
            })
        }
    }
}

//MEDICATION SCREEN-----------------------------------------------------------------------------------
struct MedicationView: View {
    //Navigation
    @State private var selection: String? = nil
    //When button is clicked
    @State private var showContentView:Bool = false
    //Go back to root
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ScrollView (.vertical) {
            VStack (spacing: 10){   //The big one - for the whole screen
                Text("Medication Options").fontWeight(.bold).font(.largeTitle)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: -35, leading: 20, bottom: 0, trailing: 20))
                
                VStack (spacing: 10) {
                    //Tylenol
                    Group{
                        NavigationLink(destination: TylenolView(), tag: "First", selection: $selection) { EmptyView() }
                        Button (action: {
                            self.selection = "First"
                        }){
                            VStack (alignment: .leading){
                                Text("Tylenol").font(.system(size: 22)).bold().padding(.bottom, 1)
                                Text("Pain Reliever").font(.system(size: 20))
                                Text("Take as recommended on box").font(.system(size: 20))
                            }
                            //.padding(EdgeInsets(top: 5, leading: -25, bottom: 5, trailing: 20))
                            .padding(5)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            //.frame(minWidth: 0, maxWidth: .infinity)
                            .padding(5)
                            .background(Color("MedicationColor"))
                            .foregroundColor(.white)
                            .font(.title)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                        }
                    }
                    
                    //Ibuprophen
                    Group{
                        NavigationLink(destination: IbuprophenView(), tag: "Second", selection: $selection) { EmptyView() }
                        Button (action: {
                            self.selection = "Second"
                        }){
                            VStack (alignment: .leading){
                                Text("Ibuprophen").font(.system(size: 22)).bold().padding(.bottom, 1)
                                Text("Non-steroidal Anti-inflammatory").font(.system(size: 20))
                                Text("(NSAID)").font(.system(size: 20))
                                Text("400-600 mg every 4-6 hrs").font(.system(size: 20))
                            }
                            .padding(5)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(5)
                            .background(Color("MedicationColor"))
                            .foregroundColor(.white)
                            .font(.title)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                            
                        }
                    }
                    
                    //Diclofenac
                    Group{
                        NavigationLink(destination: DiclofenacView(),tag: "Third", selection: $selection) { EmptyView() }
                        Button (action: {
                            self.selection = "Third"
                        }){
                            VStack (alignment: .leading){
                                Text("Diclofenac").font(.system(size: 22)).bold().padding(.bottom, 1)
                                Text("Non-steroidal Anti-inflammatory").font(.system(size: 20))
                                Text("(NSAID)").font(.system(size: 20))
                                Text("50 mg twice daily").font(.system(size: 20))
                            }
                            //.padding(EdgeInsets(top: 5, leading: -25, bottom: 5, trailing: 0))
                            .padding(5)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(5)
                            .background(Color("MedicationColor"))
                            .foregroundColor(.white)
                            .font(.title)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                        }
                    }
                }
                
                Text("For Urinary Pain")
                .font(.system(size: 22)).bold().padding(.top, 5)
                .padding(.leading, 22)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                //Phenazopyridine
                Group{
                    NavigationLink(destination: PhenazopyridineView(),tag: "Fourth", selection: $selection) { EmptyView() }
                    Button (action: {
                        self.selection = "Fourth"
                    }){
                        VStack (alignment: .leading){
                            Text("Phenazopyridine").font(.system(size: 22)).bold().padding(.bottom, 1)
                            Text("Urinary Pain Relief").font(.system(size: 20))
                            Text("200 mg up to three times a day").font(.system(size: 20))
                        }
                        //.padding(EdgeInsets(top: 5, leading: -25, bottom: 5, trailing: 0))
                        .padding(5)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        //.frame(minWidth: 0, maxWidth: .infinity)
                        .padding(5)
                        .background(Color("MedicationColor"))
                        .foregroundColor(.white)
                        .font(.title)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        
                    }
                }
                
                Text("For Stent Related Pain")
                .font(.system(size: 22)).bold().padding(.top, 5)
                .padding(.leading, 22)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                //Tamsulosin
                Group{
                    NavigationLink(destination: TamsulosinView(),tag: "Fifth", selection: $selection) { EmptyView() }
                    Button (action: {
                        self.selection = "Fifth"
                    }){
                        VStack (alignment: .leading){
                            Text("Tamsulosin").font(.system(size: 22)).bold().padding(.bottom, 1)
                            Text("Alpha-blocker Relaxes Urinary Muscles").font(.system(size: 20))
                            Text("0.4 mg once daily").font(.system(size: 20))
                        }
                        //.background(Color.blue)
                        //.padding(EdgeInsets(top: 5, leading: -25, bottom: 5, trailing: 0))
                        //.background(Color.red)
                        .padding(5)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        //.background(Color.green)
                        .padding(5)
                        .background(Color("MedicationColor"))
                        .foregroundColor(.white)
                        .font(.title)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        
                    }
                }
                
                Text("For Bladder Spasm, Urgency, and Frequency")
                .font(.system(size: 22)).bold().padding(.top, 5)
                .padding(.leading, 22)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                //Oxybutynin
                Group{
                    NavigationLink(destination: OxybutyninView(),tag: "Sixth", selection: $selection) { EmptyView() }
                    Button (action: {
                        self.selection = "Sixth"
                    }){
                        VStack (alignment: .leading){
                            Text("Oxybutynin").font(.system(size: 22)).bold().padding(.bottom, 1)
                            Text("Anticholinergic Reduces Muscle Spasms of the Bladder and Urinary Track")
                            .font(.system(size: 20))
                            Text("5 mg 2-3 times daily").font(.system(size: 20))
                        }
                        //.padding(EdgeInsets(top: 5, leading: -25, bottom: 5, trailing: 15))
                        .padding(5)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(5)
                        .background(Color("MedicationColor"))
                        .foregroundColor(.white)
                        .font(.title)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)

                    }
                }
                
                
                Group{
                Text("Specify for Breakthrough Pain")
                .font(.system(size: 22)).bold().padding(.top, 5)
                .padding(.leading, 22)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                //Opioids
                
                    NavigationLink(destination: OpioidsView(),tag: "Seventh", selection: $selection) { EmptyView() }
                    Button (action: {
                        self.selection = "Seventh"
                    }){
                        VStack (alignment: .leading){
                            Text("Opioid: Dilaudid").font(.system(size: 22)).bold().padding(.bottom, 1)
                            Text("2 mg every 6 hrs").font(.system(size: 20))
                        }
                        //.padding(EdgeInsets(top: 5, leading: -25, bottom: 5, trailing: 20))
                        .padding(5)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(5)
                        .background(Color("MedicationColor"))
                        .foregroundColor(.white)
                        .font(.title)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)

                    }
                }
                
                //Back Button
                Button(action: {
                    //Back to main/home page/root
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    // How the button looks like
                    Text("Back")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(10)
                    .background(Color("MedicationColor"))
                    .foregroundColor(.white)
                    .font(.title)
                    .cornerRadius(10)
                    .padding(.horizontal, 100)
                }
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
                
            }
            .padding(EdgeInsets(top: -15, leading: 0, bottom: 0, trailing: 0))
                        
        }
    }
}

//TYLENOL--------------------------------------------------------
struct TylenolView: View {
    //Go Back to Pervious Screen
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ScrollView (.vertical) {
            VStack {
                Text("Tylenol").font(.system(size: 30, weight: .bold))
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    //The frame around it
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40, alignment: .leading)
                    //.background(Color.green)
                Image("TylenolImg").resizable().frame(height: 200)
                
                //BETTER SPACING?
                VStack (alignment: .leading, spacing: 5){
                    //Text("Tylenol").font(.system(size: 17, weight: .semibold, design: .serif))
                    Text("Information:").font(.system(size: 30, weight: .bold))
                        //.background(Color.yellow)
                    Text("Tylenol (acetaminophen) is a pain reliever and a fever reducer. Tylenol is used to treat many conditions such as headache, muscle aches, arthritis, backache, toothaches, sore throats, colds, flu, and fevers.")
                    //.background(Color.orange)
                    
                    //https://www.drugs.com/tylenol.html <- Amazing resource
                    Text("Warnings/Side Effects:").font(.system(size: 30, weight: .bold))
                    Text("Adults and teenagers who weigh at least 110 pounds should not take more than 1000 milligrams (mg) at one time, or more than 4000 mg in 24 hours.")
                    Text("Side effects are rare, but may include:")
                        .font(.system(size: 18, weight: .bold))
                    Text("Nausea, Headache, Stomach pain, Rash")
                    //https://www.drugs.com/sfx/acetaminophen-side-effects.html
                    
                    //MORE INFORMATION?
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                //The frame around it
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                //Done Button
                Button(action: {
                    //Back to main/home page/root
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    // How the button looks like
                    Text("Done")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(10)
                    .background(Color("MedicationColor"))
                    .foregroundColor(.white)
                    .font(.title)
                    .cornerRadius(10)
                    .padding(.horizontal, 110)
                }
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 30, trailing: 0))
                
            }
            .padding(.top, -55)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                HStack{
                Image(systemName: "arrow.left")
                Text("Back").foregroundColor(.blue)
                    
                }
            })
        }
    }
}
//Ibuprofen -----------------------------------------------------
struct IbuprophenView: View {
    //Go Back to Pervious Screen
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ScrollView (.vertical) {
            VStack{
                Text("Ibuprofen").font(.system(size: 30, weight: .bold))
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                //The frame around it
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40, alignment: .leading)

                Image("IbuprofenImg").resizable().frame(width:200, height: 355)
                    //.background(Color.blue)

                //BETTER SPACING?
                VStack (alignment: .leading, spacing: 5){
                    //Text("Tylenol").font(.system(size: 17, weight: .semibold, design: .serif))
                    Text("Information:").font(.system(size: 30, weight: .bold))
                    Text("Ibuprofen is a nonsteroidal anti-inflammatory drug (NSAID). It works by reducing hormones that cause inflammation and pain in the body. Ibuprofen is used to reduce fever and treat pain or inflammation caused by many conditions such as headache, toothache, back pain, arthritis, menstrual cramps, or minor injury.")
                    //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 240)

                    HStack{
                        Text("Generic Name:").font(.system(size: 20, weight: .bold))
                        Text("Ibuprofen")
                    }

                    VStack {
                        HStack {
                            Text("Brand Name:").font(.system(size: 20, weight: .bold))
                            Text("Advil, Midol, Motrin, ")
                        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Text("Motrin IB, Motrin Migraine Pain, Proprinal, Smart Sense Children's Ibuprofen, PediaCare Children’s Pain Reliever/Fever Reducer, PediaCare Infant’s Pain Reliever/Fever Reducer")
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                            //.background(Color.purple)
                    }
                    //.background(Color.red)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    //.background(Color.blue)

                    //https://www.drugs.com/ibuprofen.html <- Amazing resource
                    Text("Warnings/Side Effects:").font(.system(size: 30, weight: .bold))
                    Text("Ibuprofen can increase your risk of fatal heart attack or stroke, especially if you use it long term or take high doses, or if you have heart disease. Do not use this medicine just before or after heart bypass surgery (coronary artery bypass graft, or CABG).")
                    //https://www.medicalnewstoday.com/articles/161071#side-effects
                    Text("Ibuprofen is not suitable for people who: are sensitive to aspirin or any other NSAID have, or have had, a peptic ulcer have severe heart failure")
                    Text("Most common side effects:").font(.system(size: 18, weight: .bold))

                    Text("diarrhea,nausea, vomiting, dyspepsia, involving upper abdominal pain, bloating, and indigestion pain in the stomach or intestines")
                    //https://www.drugs.com/sfx/acetaminophen-side-effects.html

                    //MORE INFORMATION?
                }
                //.background(Color.red)
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                //The frame around it
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                //.background(Color.blue)
                
                //Done Button
                Button(action: {
                    //Back to main/home page/root
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    // How the button looks like
                    Text("Done")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(10)
                    .background(Color("MedicationColor"))
                    .foregroundColor(.white)
                    .font(.title)
                    .cornerRadius(10)
                    .padding(.horizontal, 110)
                }
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 30, trailing: 0))
            }
            .padding(.top, -55)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                HStack{
                Image(systemName: "arrow.left")
                Text("Back").foregroundColor(.blue)
                    
                }
            })
        }
    }
}
//Diclofenac--------------------------------------------------------
struct DiclofenacView: View {
    //Go Back to Pervious Screen
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ScrollView (.vertical) {
            VStack {
                Text("Diclofenac").font(.system(size: 30, weight: .bold))
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    //The frame around it
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40, alignment: .leading)
                    //.background(Color.green)
                
                
                Image("diclofenacImg").resizable().frame(width: 260, height: 175)
                    .background(Color.blue)
                //.padding(.vertical, 20)
                
                //BETTER SPACING?
                VStack (alignment: .leading, spacing: 5){
                    //Text("Tylenol").font(.system(size: 17, weight: .semibold, design: .serif))
                    Text("Information:")
                        .font(.system(size: 30, weight: .bold))
                        //.background(Color.yellow)
                    Text("Diclofenac is a nonsteroidal anti-inflammatory drug (NSAID). This medicine works by reducing substances in the body that cause pain and inflammation.")
                    //.background(Color.orange)
                    
                    //https://www.drugs.com/diclofenac.html <- Amazing resource
                    Text("Warnings/Side Effects:")
                        .font(.system(size: 30, weight: .bold))
                    Text("You should not use diclofenac if you are allergic to it, or if you have ever had an asthma attack or severe allergic reaction after taking aspirin or an NSAID.")
                    Text("Side effects are rare, but may include:")
                        .font(.system(size: 18, weight: .bold))
                    Text("Diarrhea, Constipation, Gas or bloating, Headache, Dizziness, Ringing in the ears")
                    Text("Tell your doctor if any of these symptoms are severe or do not go away").bold()
                    //https://medlineplus.gov/druginfo/meds/a689002.html#side-effects
                    
                    //MORE INFORMATION?
                }
                //.background(Color.red)
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                //The frame around it
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                //.background(Color.red)
                
                //Done Button
                Button(action: {
                    //Back to main/home page/root
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    // How the button looks like
                    Text("Done")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(10)
                    .background(Color("MedicationColor"))
                    .foregroundColor(.white)
                    .font(.title)
                    .cornerRadius(10)
                    .padding(.horizontal, 110)
                }
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 30, trailing: 0))
                
            }
            //.background(Color.blue)
            .padding(.top, -55)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                HStack{
                Image(systemName: "arrow.left")
                Text("Back").foregroundColor(.blue)
                    
                }
            })
        }
    }
}
//Phenazopyridine -----------------------------------------------------
struct PhenazopyridineView: View {
    //Go Back to Pervious Screen
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ScrollView (.vertical) {
            VStack {
                Text("Phenazopyridine").font(.system(size: 30, weight: .bold))
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                //The frame around it
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40, alignment: .leading)

                Image("PhenazopyridineImg").resizable().frame(width:194, height: 250)
                    //.background(Color.blue)

                //BETTER SPACING?
                VStack (alignment: .leading, spacing: 5){
                    //Text("Tylenol").font(.system(size: 17, weight: .semibold, design: .serif))
                    Text("Information:").font(.system(size: 30, weight: .bold))
                    Text("Phenazopyridine is a pain reliever that affects the lower part of your urinary tract (bladder and urethra). Phenazopyridine is used to treat urinary symptoms such as pain or burning, increased urination, and increased urge to urinate. These symptoms can be caused by infection, injury, surgery, catheter, or other conditions that irritate the bladder.")
                    //.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 240)

                    HStack{
                        Text("Generic Name:").font(.system(size: 20, weight: .bold))
                        Text("Phenazopyridine")
                    }

                    VStack {
                        HStack {
                            Text("Brand Name:").font(.system(size: 20, weight: .bold))
                            Text("AZO Urinary Pain Relief, ")
                        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Text("Azo-Gesic, Baridium, Prodium, Pyridium, Re-Azo, Uricalm, Viridium, Eridium, Pyridiate, Urogesic, Phenazo, Urodol, Urinary Analgesic, Uristat, AZO Urinary Pain Relief Max Strength, Urinary Pain Relief Maximum Strength")
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                            //.background(Color.purple)
                    }
                    //.background(Color.red)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    //.background(Color.blue)

                    //https://www.drugs.com/mtm/phenazopyridine.html <- Amazing resource
                    Text("Warnings/Side Effects:").font(.system(size: 30, weight: .bold))
                    Text("You should not use phenazopyridine if you are allergic to it, or if you have kidney disease. To make sure phenazopyridine is safe for you, tell your doctor if you have: liver disease, diabetes, or a genetic enzyme deficiency called glucose-6-phosphate dehydrogenase (G6PD) deficiency.")
                    Text("Most common side effects:").font(.system(size: 18, weight: .bold))
                    Text("headache, dizziness, or upset stomach.")
                    Text("Stop using Phenazopyridine and contact your doctor if you have:").font(.system(size: 18, weight: .bold))
                    Text("Little or no urinating, Swelling, rapid weight gain, Confusion, Loss of appetite, Pain in your side or lower back, Fever, Pale or yellowed skin, Stomach pain, Nausea and vomiting, or Blue or purple appearance of your skin.")
                    //Text("This is not a complete list of side effects and others may occur. Call your  doctor for medical advice about side effects. You may report side effects to    FDA at 1-800-FDA-1088.").bold()
                    //MORE INFORMATION?
                }
                //.background(Color.red)
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                //The frame around it
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                //.background(Color.blue)
                
                //Done Button
                Button(action: {
                    //Back to main/home page/root
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    // How the button looks like
                    Text("Done")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(10)
                    .background(Color("MedicationColor"))
                    .foregroundColor(.white)
                    .font(.title)
                    .cornerRadius(10)
                    .padding(.horizontal, 110)
                }
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 30, trailing: 0))
                
            }
            .padding(.top, -55)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                HStack{
                Image(systemName: "arrow.left")
                Text("Back").foregroundColor(.blue)
                    
                }
            })
        }
    }
}
//Tamsulosin -----------------------------------------------------
struct TamsulosinView: View {
    //Go Back to Pervious Screen
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ScrollView (.vertical) {
            VStack {
                Text("Tamsulosin").font(.system(size: 30, weight: .bold))
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                //The frame around it
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40, alignment: .leading)
                //https://5.imimg.com/data5/AE/UJ/LS/SELLER-3527263/tamsulosin-hcl-0-4-mg-500x500.png
                Image("TamsulosinImg").resizable().frame(width:288, height: 200)
                    //.background(Color.blue)

                //BETTER SPACING?
                VStack (alignment: .leading, spacing: 5){
                    //Text("Tylenol").font(.system(size: 17, weight: .semibold, design: .serif))
                    Text("Information:").font(.system(size: 30, weight: .bold))
                    Text("Tamsulosin (Flomax) is an alpha-blocker that relaxes the muscles in the prostate and bladder neck, making it easier to urinate. Tamsulosin is not FDA approved for use in women or children.")
                    HStack{
                        Text("Generic Name:").font(.system(size: 20, weight: .bold))
                        Text("Tamsulosin")
                    }
                    VStack {
                        HStack {
                            Text("Brand Name:").font(.system(size: 20, weight: .bold))
                            Text("Flomax")
                        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    }
                    //.background(Color.red)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    //.background(Color.blue)

                    //https://www.drugs.com/tamsulosin.html
                    Text("Warnings/Side Effects:").font(.system(size: 30, weight: .bold))
                    Text("You should not use this medication if you are allergic to tamsulosin. Do not take tamsulosin with other similar medicines such as alfuzosin (Uroxatral), doxazosin (Cardura), prazosin (Minipress), silodosin (Rapaflo), or terazosin (Hytrin).Tamsulosin may cause dizziness or fainting, especially when you first start taking it or when you start taking it again. Be careful if you drive or do anything that requires you to be alert.")
                    Text("Most common side effects:").font(.system(size: 18, weight: .bold))
                    Text("Low blood pressure, Dizziness, Drowsiness, Weakness, Nausea, Diarrhea, Headache, Chest pain, Back pain, Blurred vision, Tooth problems, Fever, Chills, Body aches, Flu symptoms, Runny or stuffy nose, Sinus pain, Sore throat, Cough, Sleep problems (insomnia)")
                    Text("Stop using Tamsulosin and contact your doctor if you have:").font(.system(size: 18, weight: .bold))
                    Text("A light-headed feeling/like you might pass out, Severe skin reaction, Fever, sore throat, Swelling in your face or tongue, Burning in your eyes, Skin pain followed by a red or purple skin rash that spreads (especially in the face or upper body) and causes blistering and peeling.")
                    //MORE INFORMATION?
                }
                //.background(Color.red)
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                //The frame around it
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                //.background(Color.blue)
                
                //STICKY
                //Done Button
                Button(action: {
                    //Back to main/home page/root
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    // How the button looks like
                    Text("Done")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(10)
                    .background(Color("MedicationColor"))
                    .foregroundColor(.white)
                    .font(.title)
                    .cornerRadius(10)
                    .padding(.horizontal, 110)
                }
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 30, trailing: 0))
                
            }
            .padding(.top, -55)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                HStack{
                Image(systemName: "arrow.left")
                Text("Back").foregroundColor(.blue)
                    
                }
            })
        }
    }
}
//Oxybutynin -----------------------------------------------------
struct OxybutyninView: View {
    //Go Back to Pervious Screen
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ScrollView (.vertical) {
            VStack {
                Text("Oxybutynin").font(.system(size: 30, weight: .bold))
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                //The frame around it
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40, alignment: .leading)
                //https://lh3.googleuserconten.com/proxy/L7qJ8MWv0EkvDQKyIL33KE6CPHPNOWPmoQe4oLhudfsNZ4rbIPTC1LDdji4AaM-nhyN5A5qUhnQlDMdIGNFpRVAwllB_VD83Nf8mqU7O5Q
                Image("OxybutyninImg").resizable().frame(width: 300, height: 300)
                VStack (alignment: .leading, spacing: 5){
                    //Text("Tylenol").font(.system(size: 17, weight: .semibold, design: .serif))
                    Text("Information:").font(.system(size: 30, weight: .bold))
                    Text("Oxybutynin reduces muscle spasms of the bladder and urinary tract. Oxybutynin is used to treat symptoms of overactive bladder, such as frequent or urgent urination, incontinence (urine leakage), and increased night-time urination.")
                    HStack{
                        Text("Generic Name:").font(.system(size: 20, weight: .bold))
                        Text("Oxybutynin")
                    }
                    HStack {
                        Text("Brand Name:").font(.system(size: 20, weight: .bold))
                        Text("Ditropan XL")
                    }
                    //https://www.drugs.com/tamsulosin.html
                    Text("Warnings/Side Effects:").font(.system(size: 30, weight: .bold))
                    Text("You should not use oxybutynin if you have untreated or uncontrolled narrow-angle glaucoma, a blockage in your digestive tract (stomach or intestines), or if you are unable to urinate. Before using oxybutynin, tell your doctor if you have glaucoma, liver or kidney disease, an enlarged prostate, myasthenia gravis, ulcerative colitis, a blockage in your stomach or intestines, or a stomach disorder such as gastroesophageal reflux disease (GERD) or slow digestion.Avoid becoming overheated or dehydrated during exercise and in hot weather. Oxybutynin can decrease perspiration and you may be more prone to heat stroke.")
                    Text("Most common side effects:").font(.system(size: 18, weight: .bold))
                    Text("Dizziness, Drowsiness, Blurred vision, Dry mouth, Diarrhea, Constipation")
                    Text("Stop using and contact your doctor if you have:").font(.system(size: 18, weight: .bold))
                    Text("Severe stomach pain or constipation, Blurred vision, Tunnel vision, Eye pain, Seeing halos around lights, Little or no urination, Painful or difficult urination, Dehydration symptoms--feeling very thirsty or hot, being unable to urinate, heavy sweating, or hot and dry skin")
                    //MORE INFORMATION?
                }
                //.background(Color.red)
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                //The frame around it
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                //.background(Color.blue)
                
                //Done Button
                Button(action: {
                    //Back to main/home page/root
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    // How the button looks like
                    Text("Done")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(10)
                    .background(Color("MedicationColor"))
                    .foregroundColor(.white)
                    .font(.title)
                    .cornerRadius(10)
                    .padding(.horizontal, 110)
                }
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 30, trailing: 0))
                
            }
            .padding(.top, -55)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                HStack{
                Image(systemName: "arrow.left")
                Text("Back").foregroundColor(.blue)
                    
                }
            })
        }
    }
}
//Opioids -----------------------------------------------------
struct OpioidsView: View {
    //Go Back to Pervious Screen
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ScrollView (.vertical) {
            VStack {
                Text("Opioids").font(.system(size: 30, weight: .bold))
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                //The frame around it
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 40, alignment: .leading)
                //https://lh3.googleuserconten.com/proxy/L7qJ8MWv0EkvDQKyIL33KE6CPHPNOWPmoQe4oLhudfsNZ4rbIPTC1LDdji4AaM-nhyN5A5qUhnQlDMdIGNFpRVAwllB_VD83Nf8mqU7O5Q
                Image("OpioidsImg").resizable().frame(width: 300, height: 200)
                VStack (alignment: .leading, spacing: 5){
                    //Text("Tylenol").font(.system(size: 17, weight: .semibold, design: .serif))
                    Text("Information:").font(.system(size: 30, weight: .bold))
                    //https://www.cdc.gov/drugoverdose/data/prescribing.html
                    Text("Prescription opioids are often used to treat chronic and acute pain and, when used appropriately, can be an important component of treatment. However, serious risks are associated with their use, and it is essential to carefully consider the risks of using prescription opioids alongside their benefits. These risks include misuse, opioid use disorder (addiction), overdoses, and death.")
                    //https://www.asam.org/docs/default-source/education-docs/opioid-names_generic-brand-street_it-matttrs_8-28-17.pdf?sfvrsn=7b0640c2_2
                    VStack {
                        HStack {
                            Text("Generic Name:").font(.system(size: 20, weight: .bold))
                            Text("Fentanyl, Methadone")
                        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Text(" hydrochloride, Morphine sulfate , Oxymorphone hydrochloride")
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                            //.background(Color.purple)
                    }
                    VStack {
                        HStack {
                            Text("Brand Name:").font(.system(size: 20, weight: .bold))
                            Text("Abstral, Actiq, Avinza")
                        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        Text("Butrans,Demerol Dilaudid, Dolophine, Duragesic, Fentora, Hysingla, Methadose, Morphabond, Nucynta ER, Onsolis, Oramorph, Oxaydo, Roxanol-T, Sublimaze, Xtampza ER, Zohydro ER ")
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                            //.background(Color.purple)
                    }
                    //.background(Color.red)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    //.background(Color.blue)
                    //https://www.cdc.gov/drugoverdose/opioids/prescribed.html
                    Text("Warnings/Side Effects:").font(.system(size: 30, weight: .bold))
                    Text("Addiction & Overdose").font(.system(size: 25, weight: .bold))
                    Text("Anyone who takes prescription opioids can become addicted to them. In fact, as many as one in four patients receiving long-term opioid therapy in a primary care setting struggles with opioid addiction. Once addicted, it can be hard to stop. In 2016, more than 11.5 million Americans reported misusing prescription opioids in the past year. Taking too many prescription opioids can stop a person’s breathing—leading to death.")
                    Text("Side effects:").font(.system(size: 18, weight: .bold))
                    Text("Tolerance—meaning you might need to take more of the medication for the same pain relief, Physical dependence—meaning you have symptoms of withdrawal when the medication is stopped, Increased sensitivity to pain, Constipation, Nausea, Vomiting, and Dry mouth, Sleepiness and dizziness, Confusion, Depression, and strength, Itching and sweating")
                    //MORE INFORMATION?
                }
                //.background(Color.red)
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                //The frame around it
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
                //.background(Color.blue)
                
                //Done Button
                Button(action: {
                    //Back to main/home page/root
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    // How the button looks like
                    Text("Done")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(10)
                    .background(Color("MedicationColor"))
                    .foregroundColor(.white)
                    .font(.title)
                    .cornerRadius(10)
                    .padding(.horizontal, 110)
                }
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 30, trailing: 0))
                
            }
            .padding(.top, -55)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action : {
                self.mode.wrappedValue.dismiss()
            }){
                HStack{
                Image(systemName: "arrow.left")
                Text("Back").foregroundColor(.blue)
                    
                }
            })

        }
    }
}
