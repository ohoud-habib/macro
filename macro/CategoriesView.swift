////
////  CategoriesView.swift
////  macro
////
////  Created by Maryam Bahwal on 10/11/1446 AH.
////
//import SwiftUI
//
//struct CategoriesView: View {
//    @State private var selectedStationIndex: Int? = nil
//    let stations = ["Art_in_History", "Legends_and_Myths", "Medicine_and_Mind", "Human_Rights"]
//
//    var body: some View {
//        NavigationStack {
//            GeometryReader { geometry in
//                ZStack(alignment: .bottomTrailing) {
//                    // Background Image (based on language)
//                    Image(getLanguagePreference() == .arabic ? "categoriesBG_ar" : "categoriesBG_en")
//                        .resizable()
//                        .scaledToFill()
//                        .ignoresSafeArea()
//
//                    VStack {
//                        // Top bar icons
//                        HStack {
//                            NavigationLink(destination: ProfileView().navigationBarBackButtonHidden(true)) {
//                                Image("profileIcon")
//                                    .resizable()
//                                    .frame(width: 60, height: 60)
//                            }
//
//                            Spacer()
//
//                            NavigationLink(destination: SettingsView().navigationBarBackButtonHidden(true)) {
//                                Image("settingIcon")
//                                    .resizable()
//                                    .frame(width: 60, height: 60)
//                            }
//                        }
//                        .padding(.horizontal)
//                        .padding(.top, geometry.safeAreaInsets.top + 40)
//
//                        Spacer()
//
//                        // Station Dots
//                        GeometryReader { geometry in
//                                           ZStack {
//                                               ForEach(stations.indices, id: \.self) { index in
//                                                   let positions: [(CGFloat, CGFloat)] = [
//                                                       (0.24, 0.489), // Art_in_History
//                                                       (0.34, 0.489), // Legends_and_Myths
//                                                       (0.44, 0.489), // Medicine_and_Mind
//                                                       (0.537, 0.489)  // Human_Rights
//                                                   ]
//
//                                                   let (x, y) = positions[index]
//
//                                                   Circle()
//                                                       .fill(selectedStationIndex == index ? Color.green : Color.black)
//                                                       .frame(width: 16, height: 16)
//                                                       .position(x: geometry.size.width * x,
//                                                                 y: geometry.size.height * y - 18.5)
//
//                                                       .onTapGesture {
//                                                           selectedStationIndex = index
//                                                       }
//                                               }
//                                           }
//                                       }
//                                       .ignoresSafeArea()
//                    }
//
//
//                    // Bottom-right "Next" button
//                    if let selectedIndex = selectedStationIndex {
//                        NavigationLink(destination: TrainDoorView(selectedCategory: stations[selectedIndex])) {
//                            Image("nextIcon")
//                                .resizable()
//                                .frame(width: 50, height: 50)
//                                .padding(.trailing, 40)
//                                .padding(.bottom, 30)
//                        }
//                    }
//                }
//                .frame(width: geometry.size.width, height: geometry.size.height)
//            }
//            .ignoresSafeArea()
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//}
//
//#Preview {
//    CategoriesView()
//}
//
//New code
//import SwiftUI
//
//struct CategoriesView: View {
//    var localizedNames: [String] {
//        getLanguagePreference() == .arabic ? namesAr : namesEn
//    }
//    
//    let namesEn = ["Art in History", "Legends and Myths", "Medicine and Mind", "Human Rights"]
//    let namesAr = ["الفن في التاريخ", "الأساطير والخرافات", "الدواء والعقل", "حقوق الإنسان"]
//    // Improved accessibility label function
//    func getStationAccessibilityLabel(index: Int, isLocked: Bool) -> String {
//        let name = getLanguagePreference() == .arabic ? namesAr[index] : namesEn[index]
//        
//        if getLanguagePreference() == .arabic {
//            return isLocked ? "\(name)، محطة مقفلة" : "\(name)، محطة متاحة"
//        } else {
//            return isLocked ? "\(name), Locked station" : "\(name), Available station"
//        }
//    }
//    
//    // Accessibility hint function
//    func getStationAccessibilityHint(index: Int, isLocked: Bool) -> String {
//        if getLanguagePreference() == .arabic {
//            return isLocked ? "اضغط مرتين لفتح نافذة الشراء" : "اضغط مرتين لتحديد هذه المحطة"
//        } else {
//            return isLocked ? "Double tap to open purchase window" : "Double tap to select this station"
//        }
//    }
//    
//    enum PaidCategory: String, Identifiable {
//        case medicineAndMind = "Medicine_and_Mind"
//        case humanRights = "Human_Rights"
//        
//        var id: String { self.rawValue }
//        
//        var displayName: String {
//            switch getLanguagePreference() {
//            case .arabic:
//                switch self {
//                case .medicineAndMind: return "الدواء والعقل"
//                case .humanRights: return "حقوق الإنسان"
//                }
//            case .english:
//                switch self {
//                case .medicineAndMind: return "Medicine & Mind"
//                case .humanRights: return "Human Rights"
//                }
//            }
//        }
//        
//        var modes: String {
//            switch getLanguagePreference() {
//            case .arabic:
//                switch self {
//                case .medicineAndMind: return "مثالي / سوداوي، قصص مصورة"
//                case .humanRights: return "مثالي / سوداوي، رعب"
//                }
//            case .english:
//                switch self {
//                case .medicineAndMind: return "Utopian / Dystopian, Comics"
//                case .humanRights: return "Utopian / Dystopian, Horror"
//                }
//            }
//        }
//    }
//    
//    @State private var paymentSheetID = UUID()
//    @State private var selectedPaidCategory: PaidCategory? = nil
//    @State private var selectedStationIndex: Int? = nil
//    
//    @AppStorage("isMedicineAndMindPaid") private var isMedicineAndMindPaid = false
//    @AppStorage("isHumanRightsPaid") private var isHumanRightsPaid = false
//    
//    let stations = ["Art_in_History", "Legends_and_Myths", "Medicine_and_Mind", "Human_Rights"]
//    
//    
//    var body: some View {
//            NavigationStack {
//                GeometryReader { geometry in
//                    ZStack(alignment: .bottomTrailing) {
//                        // Background image
//                        Image(getLanguagePreference() == .arabic ? "categoriesBG_ar" : "categoriesBG_en")
//                            .resizable()
//                            .scaledToFill()
//                            .ignoresSafeArea()
//                            .accessibilityHidden(true)
//                        
//                        VStack {
//                            // Header buttons
//                            HStack {
//                                NavigationLink(destination: ProfileView()) {
//                                    Image("profileIcon")
//                                        .resizable()
//                                        .frame(width: 60, height: 60)
//                                }
//                                Spacer()
//                                NavigationLink(destination: SettingsView()) {
//                                    Image("settingIcon")
//                                        .resizable()
//                                        .frame(width: 60, height: 60)
//                                }
//                            }
//                            .padding(.trailing, 45)
//                            .padding(.top, geometry.safeAreaInsets.top + 40)
//                            
//                            Spacer()
//                            
//                            // Stations grid
//                            GeometryReader { geo in
//                                let positions: [(CGFloat, CGFloat)] = [
//                                    (0.24, 0.52), (0.34, 0.52),
//                                    (0.437, 0.52), (0.536, 0.52)
//                                ]
//                                
//                                ForEach(Array(stations.enumerated()), id: \.offset) { index, category in
//                                    let isPaid = isCategoryPaid(category)
//                                    let isPaidCategory = isPaidCategory(category)
//                                    let isSelected = selectedStationIndex == index
//                                    let position = CGPoint(
//                                        x: geo.size.width * positions[index].0,
//                                        y: geo.size.height * positions[index].1 - 18.5
//                                    )
//                                    
//                                    // Station button with proper accessibility
//                                    Button(action: {
//                                        handleStationTap(index: index, category: category, isPaid: isPaid, isPaidCategory: isPaidCategory)
//                                    }) {
//                                        // Visual representation only
//                                        StationDotView(
//                                            isSelected: isSelected,
//                                            isLocked: !isPaid && isPaidCategory
//                                        )
//                                        // Hidden accessibility elements
//                                        .accessibility(hidden: true)
//                                    }
//                                    .accessibilityElement(children: .ignore)
//                                    .accessibilityLabel(createStationLabel(index: index, isLocked: !isPaid && isPaidCategory))
//                                    .accessibilityHint(createStationHint(isLocked: !isPaid && isPaidCategory))
//                                    .position(position)
//                                    .background(
//                                        // Hidden text for VoiceOver to detect
//                                        Text(getLanguagePreference() == .arabic ? namesAr[index] : namesEn[index])
//                                            .font(.system(size: 1))
//                                            .foregroundColor(.clear)
//                                            .accessibility(hidden: false)
//                                    )
//                                }
//                            }
//                            .ignoresSafeArea()
//                        }
//                        
//                        // Next button
//                        if let selectedIndex = selectedStationIndex {
//                            NavigationLink(destination: TrainDoorView(selectedCategory: stations[selectedIndex])) {
//                                Image("nextIcon")
//                                    .resizable()
//                                    .frame(width: 50, height: 50)
//                                    .padding(.trailing, 40)
//                                    .padding(.bottom, 30)
//                            }
//                        }
//                    }
//                    .sheet(item: $selectedPaidCategory) { paidCategory in
//                        PaymentSheetView(category: paidCategory) {
//                            markCategoryAsPaid(paidCategory.rawValue)
//                            if let index = stations.firstIndex(of: paidCategory.rawValue) {
//                                selectedStationIndex = index
//                            }
//                            selectedPaidCategory = nil
//                        }
//                    }
//                }
//            }
//            .navigationBarBackButtonHidden(true)
//        }
//        
//        // MARK: - Subviews
//        private var backgroundImage: some View {
//            Image(getLanguagePreference() == .arabic ? "categoriesBG_ar" : "categoriesBG_en")
//                .resizable()
//                .scaledToFill()
//                .ignoresSafeArea()
//                .accessibilityHidden(true)
//        }
//        
//        private func mainContent(geometry: GeometryProxy) -> some View {
//            VStack {
//                headerButtons(geometry: geometry)
//                Spacer()
//                stationsGrid
//            }
//        }
//        
//        private func headerButtons(geometry: GeometryProxy) -> some View {
//            HStack {
//                profileButton
//                Spacer()
//                settingsButton
//            }
//            .padding(.trailing, 45)
//            .padding(.top, geometry.safeAreaInsets.top + 40)
//        }
//        
//        private var profileButton: some View {
//            NavigationLink(destination: ProfileView().navigationBarBackButtonHidden(true)) {
//                Image("profileIcon")
//                    .resizable()
//                    .frame(width: 60, height: 60)
//                    .accessibilityLabel(getLanguagePreference() == .arabic ? "الملف الشخصي" : "Profile")
//                    .accessibilityHint(getLanguagePreference() == .arabic ? "افتح الملف الشخصي" : "Open profile")
//            }
//        }
//        
//        private var settingsButton: some View {
//            NavigationLink(destination: SettingsView().navigationBarBackButtonHidden(true)) {
//                Image("settingIcon")
//                    .resizable()
//                    .frame(width: 60, height: 60)
//                    .accessibilityLabel(getLanguagePreference() == .arabic ? "الإعدادات" : "Settings")
//                    .accessibilityHint(getLanguagePreference() == .arabic ? "افتح الإعدادات" : "Open settings")
//            }
//        }
//        
//        private var stationsGrid: some View {
//            GeometryReader { geo in
//                let positions: [(CGFloat, CGFloat)] = [
//                    (0.24, 0.52), (0.34, 0.52),
//                    (0.437, 0.52), (0.536, 0.52)
//                ]
//                
//                ForEach(Array(stations.enumerated()), id: \.offset) { index, category in
//                    stationButton(index: index, category: category, geo: geo, positions: positions)
//                }
//            }
//            .ignoresSafeArea()
//        }
//        
//        private func stationButton(index: Int, category: String, geo: GeometryProxy, positions: [(CGFloat, CGFloat)]) -> some View {
//            let isPaid = isCategoryPaid(category)
//            let isPaidCategory = isPaidCategory(category)
//            let isSelected = selectedStationIndex == index
//            let position = CGPoint(
//                x: geo.size.width * positions[index].0,
//                y: geo.size.height * positions[index].1 - 18.5
//            )
//            
//            return Button(action: {
//                handleStationTap(index: index, category: category, isPaid: isPaid, isPaidCategory: isPaidCategory)
//            }) {
//                ZStack {
//                    StationDotView(
//                        isSelected: isSelected,
//                        isLocked: !isPaid && isPaidCategory
//                    )
//                    .accessibilityHidden(true)
//                    
//                    Text(getLanguagePreference() == .arabic ? namesAr[index] : namesEn[index])
//                        .font(.system(size: 1))
//                        .foregroundColor(.clear)
//                        .accessibilityHidden(false)
//                }
//            }
//            .accessibilityElement(children: .combine)
//            .accessibilityLabel(createStationLabel(index: index, isLocked: !isPaid && isPaidCategory))
//            .accessibilityHint(createStationHint(isLocked: !isPaid && isPaidCategory))
//            .position(position)
//        }
//        
//        private var nextButtonIfNeeded: some View {
//            Group {
//                if let selectedIndex = selectedStationIndex {
//                    NavigationLink(destination: TrainDoorView(selectedCategory: stations[selectedIndex])) {
//                        Image("nextIcon")
//                            .resizable()
//                            .frame(width: 50, height: 50)
//                            .padding(.trailing, 40)
//                            .padding(.bottom, 30)
//                            .accessibilityLabel(getLanguagePreference() == .arabic ? "التالي" : "Next")
//                            .accessibilityHint(getLanguagePreference() == .arabic ? "اذهب إلى المحطة المحددة" : "Go to the selected station")
//                    }
//                }
//            }
//        }
//        
//        private func paymentSheet(for category: PaidCategory) -> some View {
//            PaymentSheetView(category: category) {
//                markCategoryAsPaid(category.rawValue)
//                if let index = stations.firstIndex(of: category.rawValue) {
//                    selectedStationIndex = index
//                }
//                selectedPaidCategory = nil
//            }
//            .presentationDetents([.fraction(0.35)])
//            .presentationDragIndicator(.visible)
//            .presentationBackground(.clear)
//        
//            
//        
//        .navigationBarBackButtonHidden(true)
//    }
//        
//        private func createStationLabel(index: Int, isLocked: Bool) -> String {
//            let name = getLanguagePreference() == .arabic ? namesAr[index] : namesEn[index]
//            let status = isLocked ?
//                (getLanguagePreference() == .arabic ? "محطة مقفلة" : "Locked station") :
//                (getLanguagePreference() == .arabic ? "محطة متاحة" : "Available station")
//            
//            return "\(name). \(status)"
//        }
//        
//        private func createStationHint(isLocked: Bool) -> String {
//            if getLanguagePreference() == .arabic {
//                return isLocked ? "اضغط مرتين لفتح نافذة الشراء" : "اضغط مرتين لتحديد هذه المحطة"
//            } else {
//                return isLocked ? "Double tap to open purchase window" : "Double tap to select this station"
//            }
//        }
//        
//        private func handleStationTap(index: Int, category: String, isPaid: Bool, isPaidCategory: Bool) {
//            if isPaidCategory && !isPaid {
//                paymentSheetID = UUID()
//                selectedPaidCategory = PaidCategory(rawValue: category)
//            } else {
//                selectedStationIndex = index
//                let name = getLanguagePreference() == .arabic ? namesAr[index] : namesEn[index]
//                let message = getLanguagePreference() == .arabic ?
//                    "تم اختيار محطة \(name)" : "Selected station \(name)"
//                UIAccessibility.post(notification: .announcement, argument: message)
//            }
//        }
//    func isPaidCategory(_ category: String) -> Bool {
//        return category == "Medicine_and_Mind" || category == "Human_Rights"
//    }
//    //    private func announceSelection(_ index: Int) {
//    //        let message = getLanguagePreference() == .arabic ?
//    //        "تم اختيار \(namesAr[index])" : "Selected \(namesEn[index])"
//    //        UIAccessibility.post(notification: .announcement, argument: message)
//    //    }
//    
//    func isCategoryPaid(_ category: String) -> Bool {
//        switch category {
//        case "Medicine_and_Mind": return isMedicineAndMindPaid
//        case "Human_Rights": return isHumanRightsPaid
//        default: return true
//        }
//    }
//    
//    func markCategoryAsPaid(_ category: String) {
//        switch category {
//        case "Medicine_and_Mind": isMedicineAndMindPaid = true
//        case "Human_Rights": isHumanRightsPaid = true
//        default: break
//        }
//    }
////    private func handleStationTap(index: Int, category: String, isPaid: Bool, isPaidCategory: Bool) {
////        if isPaidCategory && !isPaid {
////            paymentSheetID = UUID()
////            selectedPaidCategory = PaidCategory(rawValue: category)
////        } else {
////            selectedStationIndex = index
////            announceSelection(index)
////        }
////    }
//    
//    private func stationAccessibilityLabel(index: Int, isLocked: Bool) -> String {
//        let name = getLanguagePreference() == .arabic ? namesAr[index] : namesEn[index]
//        
//        if getLanguagePreference() == .arabic {
//            let status = isLocked ? "محطة مقفلة" : "محطة متاحة"
//            return "\(name)، \(status)"
//        } else {
//            let status = isLocked ? "Locked station" : "Available station"
//            return "\(name), \(status)"
//        }
//    }
//    
//    private func stationAccessibilityHint(isLocked: Bool) -> String {
//        if getLanguagePreference() == .arabic {
//            return isLocked ? "اضغط مرتين لفتح نافذة الشراء" : "اضغط مرتين لتحديد هذه المحطة"
//        } else {
//            return isLocked ? "Double tap to open purchase window" : "Double tap to select this station"
//        }
//    }
//    
//    private func announceSelection(_ index: Int) {
//        let name = getLanguagePreference() == .arabic ? namesAr[index] : namesEn[index]
//        let message = getLanguagePreference() == .arabic ?
//        "تم اختيار محطة \(name)" : "Selected station \(name)"
//        UIAccessibility.post(notification: .announcement, argument: message)
//    }
//}
//
//
//struct StationDotView: View {
//    let isSelected: Bool
//    let isLocked: Bool
//    
//    var body: some View {
//        ZStack {
//            Circle()
//                .fill(isSelected ? Color.green : Color.black)
//                .frame(width: 25, height: 25)
//            if isLocked {
//                Image(systemName: "lock.fill")
//                    .foregroundColor(.white)
//                    .font(.system(size: 12, weight: .bold))
//            }
//        }
//        .accessibility(hidden: true) // Important: Hide from VoiceOver
//    }
//}
//
//
//private struct StationAccessibilityView: UIViewRepresentable {
//    let name: String
//    let isLocked: Bool
//    let isSelected: Bool
//    
//    func makeUIView(context: Context) -> UIView {
//        let view = UIView()
//        DispatchQueue.main.async {
//            let label = isLocked ? "\(name)، مغلق، اضغط للشراء" : "\(name)، محطة متاحة"
//            view.accessibilityLabel = label
//            view.isAccessibilityElement = true
//            UIAccessibility.post(notification: .layoutChanged, argument: nil)
//        }
//        return view
//    }
//    
//    func updateUIView(_ uiView: UIView, context: Context) {
//        let label = isLocked ? "\(name)، مغلق، اضغط للشراء" : "\(name)، محطة متاحة"
//        uiView.accessibilityLabel = label
//        UIAccessibility.post(notification: .layoutChanged, argument: nil)
//    }
//}
//
//struct PaymentSheetView: View {
//    let category: CategoriesView.PaidCategory
//    let onPurchase: () -> Void
//    var body: some View {
//        let isArabic = getLanguagePreference() == .arabic
//        
//        VStack(spacing: 30) {
//            Capsule()
//                .frame(width: 40, height: 5)
//                .foregroundColor(.gray.opacity(0.6))
//                .padding(.top, 8)
//            
//            Text(category.displayName)
//                .font(.title2.bold())
//                .foregroundColor(Color(hex: "#80CE99"))
//                .multilineTextAlignment(.center)
//                .accessibilityAddTraits(.isHeader)
//            
//            
//            Text("$1.99")
//                .font(.title2.bold())
//                .foregroundColor(Color(hex: "#80CE99"))
//                .multilineTextAlignment(.center)
//                .accessibilityLabel(getLanguagePreference() == .arabic ? "السعر دولار واحد وتسعة وتسعين سنتًا" : "Price one dollar and ninety-nine cents")
//            
//            Text(isArabic ? "افتح حقائق وخيارات ونتائج جديدة." : "Enjoy new facts, choices, and consequences.")
//                .font(.system(size: 14, weight: .light))
//                .foregroundColor(.white)
//                .multilineTextAlignment(.center)
//                .accessibilityLabel(isArabic ? "افتح حقائق وخيارات ونتائج جديدة." : "Enjoy new facts, choices, and consequences.")
//            
//            Text(isArabic ? "الأنماط: \(category.modes)" : "Modes: \(category.modes)")
//                .font(.system(size: 12, weight: .light))
//                .foregroundColor(.gray)
//                .multilineTextAlignment(.center)
//                .accessibilityLabel(isArabic ? "الأنماط: \(category.modes)" : "Modes: \(category.modes)")
//            
//            Button(isArabic ? "فتح" : "Unlock", action: onPurchase)
//                .accessibilityLabel(isArabic ? "افتح" : "Unlock")
//                .font(.system(size: 18)).bold()
//                .frame(maxWidth: .infinity)
//                .padding()
//                .background(Color.btn)
//                .foregroundColor(.black)
//                .cornerRadius(10)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(Color.black, lineWidth: 0.5)
//                )
//            
//            Spacer(minLength: 0)
//        }
//        .padding(.horizontal, 20)
//        .padding(.top, 30)
//        .frame(width: 300)
//        .background(
//            LinearGradient(colors: [Color(hex: "#2F4A71"), Color(hex: "#040F17")],
//                           startPoint: .top, endPoint: .bottom)
//        )
//        .cornerRadius(30)
//        .environment(\.layoutDirection, isArabic ? .rightToLeft : .leftToRight)
//    }
//    
//}
//extension Color {
//    init(hex: String) {
//        let scanner = Scanner(string: hex)
//        _ = scanner.scanString("#")
//        
//        var rgb: UInt64 = 0
//        scanner.scanHexInt64(&rgb)
//        
//        let r = Double((rgb >> 16) & 0xFF) / 255.0
//        let g = Double((rgb >> 8) & 0xFF) / 255.0
//        let b = Double(rgb & 0xFF) / 255.0
//        
//        self.init(red: r, green: g, blue: b)
//    }
//}
//struct Station {
//    let id: String
//    let nameEn: String
//    let nameAr: String
//    var isPaid: Bool
//}
//
//#Preview {
//    CategoriesView()
//}
//
import SwiftUI

struct CategoriesView: View {
    var localizedNames: [String] {
        getLanguagePreference() == .arabic ? namesAr : namesEn
    }
    
    let namesEn = ["Art in History", "Legends and Myths", "Medicine and Mind", "Human Rights"]
    let namesAr = ["الفن في التاريخ", "الأساطير والخرافات", "الدواء والعقل", "حقوق الإنسان"]
    
    // MARK: - Accessibility Functions
    func getStationAccessibilityLabel(index: Int, isLocked: Bool) -> String {
        let name = getLanguagePreference() == .arabic ? namesAr[index] : namesEn[index]
        return getLanguagePreference() == .arabic ?
            "\(name)، \(isLocked ? "محطة مقفلة" : "محطة متاحة")" :
            "\(name), \(isLocked ? "Locked station" : "Available station")"
    }
    
    func getStationAccessibilityHint(index: Int, isLocked: Bool) -> String {
        return getLanguagePreference() == .arabic ?
            (isLocked ? "اضغط مرتين لفتح نافذة الشراء" : "اضغط مرتين لتحديد هذه المحطة") :
            (isLocked ? "Double tap to open purchase window" : "Double tap to select this station")
    }
    
    // MARK: - Paid Category Enum
    enum PaidCategory: String, Identifiable {
        case medicineAndMind = "Medicine_and_Mind"
        case humanRights = "Human_Rights"
        
        var id: String { self.rawValue }
        
        var displayName: String {
            switch getLanguagePreference() {
            case .arabic:
                return self == .medicineAndMind ? "الدواء والعقل" : "حقوق الإنسان"
            case .english:
                return self == .medicineAndMind ? "Medicine & Mind" : "Human Rights"
            }
        }
        
        var modes: String {
            switch getLanguagePreference() {
            case .arabic:
                return self == .medicineAndMind ? "مثالي / سوداوي، قصص مصورة" : "مثالي / سوداوي، رعب"
            case .english:
                return self == .medicineAndMind ? "Utopian / Dystopian, Comics" : "Utopian / Dystopian, Horror"
            }
        }
        
        var accessibilityDescription: String {
            switch getLanguagePreference() {
            case .arabic:
                return self == .medicineAndMind ?
                    "الدواء والعقل، أنماط: مثالي / سوداوي، قصص مصورة" :
                    "حقوق الإنسان، أنماط: مثالي / سوداوي، رعب"
            case .english:
                return self == .medicineAndMind ?
                    "Medicine and Mind, Modes: Utopian, Dystopian, Comics" :
                    "Human Rights, Modes: Utopian, Dystopian, Horror"
            }
        }
    }
    
    // MARK: - State Properties
    @State private var paymentSheetID = UUID()
    @State private var selectedPaidCategory: PaidCategory? = nil
    @State private var selectedStationIndex: Int? = nil
    
    @AppStorage("isMedicineAndMindPaid") private var isMedicineAndMindPaid = false
    @AppStorage("isHumanRightsPaid") private var isHumanRightsPaid = false
    
    let stations = ["Art_in_History", "Legends_and_Myths", "Medicine_and_Mind", "Human_Rights"]
    
    // MARK: - Main View
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack(alignment: .bottomTrailing) {
                    // Background image (hidden from VoiceOver)
                    Image(getLanguagePreference() == .arabic ? "categoriesBG_ar" : "categoriesBG_en")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .accessibilityHidden(true)
                    
                    VStack {
                        // Header buttons
                        HStack {
                            NavigationLink(destination: ProfileView()) {
                                Image("profileIcon")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .accessibilityLabel(getLanguagePreference() == .arabic ? "الملف الشخصي" : "Profile")
                                    .accessibilityHint(getLanguagePreference() == .arabic ? "اضغط مرتين لفتح الملف الشخصي" : "Double tap to open profile")
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: SettingsView()) {
                                Image("settingIcon")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .accessibilityLabel(getLanguagePreference() == .arabic ? "الإعدادات" : "Settings")
                                    .accessibilityHint(getLanguagePreference() == .arabic ? "اضغط مرتين لفتح الإعدادات" : "Double tap to open settings")
                            }
                        }
                        .padding(.trailing, 45)
                        .padding(.top, geometry.safeAreaInsets.top + 40)
                        
                        Spacer()
                        
                        // Stations grid with accessibility
                        GeometryReader { geo in
                            let positions: [(CGFloat, CGFloat)] = [
                                (0.24, 0.52), (0.34, 0.52),
                                (0.437, 0.52), (0.536, 0.52)
                            ]
                            
                            ForEach(Array(stations.enumerated()), id: \.offset) { index, category in
                                let isPaid = isCategoryPaid(category)
                                let isPaidCategory = isPaidCategory(category)
                                let isSelected = selectedStationIndex == index
                                
                                // Station button with full accessibility support
                                Button(action: {
                                    handleStationTap(index: index, category: category, isPaid: isPaid, isPaidCategory: isPaidCategory)
                                }) {
                                    StationDotView(
                                        isSelected: isSelected,
                                        isLocked: !isPaid && isPaidCategory
                                    )
                                    .accessibilityHidden(true)
                                }
                                .accessibilityElement(children: .combine)
                                .accessibilityLabel(getStationAccessibilityLabel(index: index, isLocked: !isPaid && isPaidCategory))
                                .accessibilityHint(getStationAccessibilityHint(index: index, isLocked: !isPaid && isPaidCategory))
                                .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : .isButton)
                                .position(CGPoint(
                                    x: geo.size.width * positions[index].0,
                                    y: geo.size.height * positions[index].1 - 18.5
                                ))
                                .background(
                                    Text(getLanguagePreference() == .arabic ? namesAr[index] : namesEn[index])
                                        .font(.system(size: 1))
                                        .foregroundColor(.clear)
                                        .accessibilityHidden(false)
                                )
                            }
                        }
                        .ignoresSafeArea()
                        .accessibilityElement(children: .contain)
                        .accessibilityLabel(getLanguagePreference() == .arabic ? "محطات اللعبة" : "Game stations")
                    }
                    
                    // Next button (conditional with accessibility)
                    if let selectedIndex = selectedStationIndex {
                        NavigationLink(destination: TrainDoorView(selectedCategory: stations[selectedIndex])) {
                            Image("nextIcon")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding(.trailing, 40)
                                .padding(.bottom, 30)
                                .accessibilityLabel(getLanguagePreference() == .arabic ? "التالي" : "Next")
                                .accessibilityHint(getLanguagePreference() == .arabic ?
                                    "اضغط مرتين للانتقال إلى محطة \(namesAr[selectedIndex])" :
                                    "Double tap to proceed to \(namesEn[selectedIndex]) station")
                        }
                    }
                }
                .accessibilityElement(children: .contain)
                .accessibilityLabel(getLanguagePreference() == .arabic ? "شاشة اختيار المحطة" : "Station selection screen")
            }
            .sheet(item: $selectedPaidCategory) { paidCategory in
                PaymentSheetView(category: paidCategory) {
                    markCategoryAsPaid(paidCategory.rawValue)
                    if let index = stations.firstIndex(of: paidCategory.rawValue) {
                        selectedStationIndex = index
                        announceSelection(index)
                    }
                    selectedPaidCategory = nil
                }
                .accessibilityElement(children: .contain)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - Helper Methods
    private func isPaidCategory(_ category: String) -> Bool {
        return category == "Medicine_and_Mind" || category == "Human_Rights"
    }
    
    private func isCategoryPaid(_ category: String) -> Bool {
        switch category {
        case "Medicine_and_Mind": return isMedicineAndMindPaid
        case "Human_Rights": return isHumanRightsPaid
        default: return true
        }
    }
    
    private func markCategoryAsPaid(_ category: String) {
        switch category {
        case "Medicine_and_Mind": isMedicineAndMindPaid = true
        case "Human_Rights": isHumanRightsPaid = true
        default: break
        }
    }
    
    private func handleStationTap(index: Int, category: String, isPaid: Bool, isPaidCategory: Bool) {
        if isPaidCategory && !isPaid {
            paymentSheetID = UUID()
            selectedPaidCategory = PaidCategory(rawValue: category)
            UIAccessibility.post(notification: .screenChanged, argument: nil)
        } else {
            selectedStationIndex = index
            announceSelection(index)
        }
    }
    
    private func announceSelection(_ index: Int) {
        let message = getLanguagePreference() == .arabic ?
        "تم اختيار محطة \(namesAr[index])" : "Selected station \(namesEn[index])"
        UIAccessibility.post(notification: .announcement, argument: message)
    }
}

// MARK: - Station Dot View
struct StationDotView: View {
    let isSelected: Bool
    let isLocked: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .fill(isSelected ? Color.green : Color.black)
                .frame(width: 25, height: 25)
            
            if isLocked {
                Image(systemName: "lock.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 12, weight: .bold))
            }
        }
        .accessibilityHidden(true)
    }
}

// MARK: - Payment Sheet View
struct PaymentSheetView: View {
    let category: CategoriesView.PaidCategory
    let onPurchase: () -> Void
    
    var body: some View {
        let isArabic = getLanguagePreference() == .arabic
        
        VStack(spacing: 30) {
            // Drag handle
            Capsule()
                .frame(width: 40, height: 5)
                .foregroundColor(.gray.opacity(0.6))
                .padding(.top, 8)
                .accessibilityHidden(true)
            
            // Category title
            Text(category.displayName)
                .font(.title2.bold())
                .foregroundColor(Color(hex: "#80CE99"))
                .multilineTextAlignment(.center)
                .accessibilityAddTraits(.isHeader)
                .accessibilityLabel(category.displayName)
            
            // Price
            Text("$1.99")
                .font(.title2.bold())
                .foregroundColor(Color(hex: "#80CE99"))
                .multilineTextAlignment(.center)
                .accessibilityLabel(isArabic ? "السعر: دولار واحد و99 سنت" : "Price: 1 dollar and 99 cents")
            
            // Description
            Text(isArabic ? "افتح حقائق وخيارات ونتائج جديدة." : "Enjoy new facts, choices, and consequences.")
                .font(.system(size: 14, weight: .light))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .accessibilityLabel(isArabic ? "افتح حقائق وخيارات ونتائج جديدة." : "Enjoy new facts, choices, and consequences.")
            
            // Modes
            Text(isArabic ? "الأنماط: \(category.modes)" : "Modes: \(category.modes)")
                .font(.system(size: 12, weight: .light))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .accessibilityLabel(isArabic ? "الأنماط: \(category.modes)" : "Modes: \(category.modes)")
            
            // Purchase button
            Button(isArabic ? "فتح" : "Unlock", action: onPurchase)
                .font(.system(size: 18)).bold()
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.btn)
                .foregroundColor(.black)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 0.5)
                )
                .accessibilityLabel(isArabic ? "فتح المحطة" : "Unlock station")
                .accessibilityHint(isArabic ? "اضغط مرتين لإتمام عملية الشراء" : "Double tap to complete purchase")
            
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 20)
        .padding(.top, 30)
        .frame(width: 300)
        .background(
            LinearGradient(colors: [Color(hex: "#2F4A71"), Color(hex: "#040F17")],
                           startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(30)
        .environment(\.layoutDirection, isArabic ? .rightToLeft : .leftToRight)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(category.accessibilityDescription)
    }
}

// MARK: - Color Extension
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}

// MARK: - Preview
#Preview {
    CategoriesView()
}
