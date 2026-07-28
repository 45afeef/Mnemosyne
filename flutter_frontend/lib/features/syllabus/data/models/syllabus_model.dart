import '../../domain/entities/syllabus.dart';
import '../../domain/entities/subject.dart';
import '../../domain/entities/module.dart';
import '../../domain/entities/learning_item.dart';

class SyllabusModel extends Syllabus {
  const SyllabusModel({
    required super.id,
    required super.title,
    required super.description,
    required super.subjects,
  });

  factory SyllabusModel.dummy(String id) {
    return SyllabusModel(
      id: id,
      title: "Flutter Developer Roadmap",
      description: "Generated learning path",
      subjects: [
        Subject(
          id: "subject_1",
          name: "Dart Programming",
          order: 1,
          modules: [
            Module(
              id: "module_1",
              name: "Dart Basics",
              order: 1,
              learningItems: [
                LearningItem(
                  id: "item_1",
                  title: "Variables",
                  description: "Learn Dart variables and types",
                  order: 1,
                ),
                LearningItem(
                  id: "item_2",
                  title: "Functions",
                  description: "Learn functions",
                  order: 2,
                ),
              ],
            ),
          ],
        ),
        Subject(
          id: "subject_2",
          name: "Flutter Framework",
          order: 2,
          modules: [
            Module(
              id: "module_2",
              name: "Widgets",
              order: 1,
              learningItems: [
                LearningItem(
                  id: "item_3",
                  title: "StatelessWidget",
                  description: "Understand immutable widgets",
                  order: 1,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
