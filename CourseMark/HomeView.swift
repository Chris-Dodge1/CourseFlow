import SwiftUI

struct HomeView: View {
    let studyTasks: [StudyTask]
    let toggleStudyTaskCompletion: (String) -> Void

    var upcomingTasks: [StudyTask] {
        Array(studyTasks.prefix(3))
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text("CourseMark")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Your study planner")
                        .font(.headline)
                        .foregroundStyle(.secondary)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Upcoming Tasks")
                            .font(.title2)
                            .fontWeight(.semibold)

                        if upcomingTasks.isEmpty {
                            Text("No tasks yet.")
                                .foregroundStyle(.secondary)
                        } else {
                            ForEach(upcomingTasks) { task in
                                HStack(alignment: .top, spacing: 12) {
                                    Button {
                                        toggleStudyTaskCompletion(task.id)
                                    } label: {
                                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                            .font(.title3)
                                    }
                                    .buttonStyle(.plain)

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(task.title)
                                            .font(.headline)
                                            .strikethrough(task.isCompleted)
                                            .foregroundStyle(task.isCompleted ? .secondary : .primary)

                                        Text(task.courseName)
                                            .font(.subheadline)
                                            .foregroundStyle(.secondary)

                                        Text(task.date.formatted(date: .abbreviated, time: .omitted))
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .padding()
                                .background(.thinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView(studyTasks: [], toggleStudyTaskCompletion: { _ in })
}
