import SwiftUI

struct CoursesView: View {
    @State private var courses: [Course] = []
    @State private var showingAddCourse = false
    
    var body: some View {
        NavigationStack {
            Group {
                if courses.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "book.closed")
                            .font(.system(size: 40))
                            .foregroundStyle(.secondary)
                        
                        Text("No courses added yet.")
                            .foregroundStyle(.secondary)
                        
                        Button("Add Your First Course") {
                            showingAddCourse = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    List(courses) { course in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(course.name)
                                .font(.headline)
                            
                            if !course.instructor.isEmpty {
                                Text(course.instructor)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Text(course.colorName)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Courses")
            .toolbar {
                Button {
                    showingAddCourse = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddCourse) {
                AddCourseView(courses: $courses)
            }
        }
    }
}

#Preview {
    CoursesView()
}
