import 'package:json_annotation/json_annotation.dart'; // Importing the json_annotation package for JSON serialization/deserialization
part 'models.g.dart'; // Specifying the file that contains the generated code

@JsonSerializable() // Annotation to enable JSON serialization/deserialization
class Option {
  String value; // Property to store the value of the option
  String detail; // Property to store additional details about the option
  bool correct; // Property to indicate if the option is correct or not

  Option(
      {this.value = '',
      this.detail = '',
      this.correct =
          false}); // Constructor with default values for the properties

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(
      json); // Factory method to create an Option object from JSON
  Map<String, dynamic> toJson() =>
      _$OptionToJson(this); // Method to convert an Option object to JSON
}

@JsonSerializable() // Annotation to enable JSON serialization/deserialization
class Question {
  String text; // Property to store the text of the question
  List<Option>
      options; // Property to store the list of options for the question

  Question(
      {this.options = const [],
      this.text = ''}); // Constructor with default values for the properties

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(
      json); // Factory method to create a Question object from JSON
  Map<String, dynamic> toJson() =>
      _$QuestionToJson(this); // Method to convert a Question object to JSON
}

@JsonSerializable() // Annotation to enable JSON serialization/deserialization
class Quiz {
  String id; // Property to store the ID of the quiz
  String title; // Property to store the title of the quiz
  String description; // Property to store the description of the quiz
  String video; // Property to store the video URL of the quiz
  String topic; // Property to store the topic of the quiz
  List<Question>
      questions; // Property to store the list of questions for the quiz

  Quiz({
    this.title = '',
    this.video = '',
    this.description = '',
    this.id = '',
    this.topic = '',
    this.questions = const [],
  }); // Constructor with default values for the properties

  factory Quiz.fromJson(Map<String, dynamic> json) =>
      _$QuizFromJson(json); // Factory method to create a Quiz object from JSON
  Map<String, dynamic> toJson() =>
      _$QuizToJson(this); // Method to convert a Quiz object to JSON
}

@JsonSerializable() // Annotation to enable JSON serialization/deserialization
class Topic {
  late final String id; // Property to store the ID of the topic
  final String title; // Property to store the title of the topic
  final String description; // Property to store the description of the topic
  final String img; // Property to store the image URL of the topic
  final List<Quiz>
      quizzes; // Property to store the list of quizzes for the topic

  Topic({
    this.id = '',
    this.title = '',
    this.description = '',
    this.img = 'default.png',
    this.quizzes = const [],
  }); // Constructor with default values for the properties

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(
      json); // Factory method to create a Topic object from JSON
  Map<String, dynamic> toJson() =>
      _$TopicToJson(this); // Method to convert a Topic object to JSON
}

@JsonSerializable() // Annotation to enable JSON serialization/deserialization
class Report {
  String uid; // Property to store the UID of the report
  int total; // Property to store the total value of the report
  Map topics; // Property to store the topics of the report

  Report(
      {this.uid = '',
      this.topics = const {},
      this.total = 0}); // Constructor with default values for the properties

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(
      json); // Factory method to create a Report object from JSON
  Map<String, dynamic> toJson() =>
      _$ReportToJson(this); // Method to convert a Report object to JSON
}
