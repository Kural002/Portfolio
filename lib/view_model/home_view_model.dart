import 'package:portfolio/model/project_model.dart';

class HomeViewModel {
  List<ProjectModel> getProjects() {
    return [
      ProjectModel(
        title: 'Portfolio Website',
        description: 'Built using Flutter Web and MVVM architecture.',
        link: 'https://yourportfolio.com',
      ),
      ProjectModel(
        title: 'Expense Tracker',
        description: 'Flutter app to manage expenses with Firebase.',
        link: 'https://github.com/yourusername/expense-tracker',
      ),
      ProjectModel(
        title: 'Pokedex',
        description: 'Flutter app to manage expenses with Firebase.',
        link: 'https://github.com/yourusername/expense-tracker',
      ),
      ProjectModel(
        title: 'Weather Application',
        description: 'Flutter app to manage expenses with Firebase.',
        link: 'https://github.com/yourusername/expense-tracker',
      ),
    ];
  }

  List<String> getSkills() {
    return [
      'Flutter',
      'Firebase',
      'Dart',
      'REST API',
      'GitHub',
      'Provider'
    ];
  }
}
