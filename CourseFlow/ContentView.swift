import SwiftUI

struct ContentView: View {
    @State private var courses: [Course] = []
    @State private var assignments: [Assignment] = []
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            CoursesView(courses: $courses)
                .tabItem {
                    Label("Courses", systemImage: "book")
                }

            AssignmentsView(courses: $courses, assignments: $assignments)
                .tabItem {
                    Label("Assignments", systemImage: "checklist")
                }

            StudyPlanView()
                .tabItem {
                    Label("Plan", systemImage: "calendar")
                }
        }
    }
}

#Preview {
    ContentView()
}
