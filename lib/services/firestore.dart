import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:quizappbackup/services/auth.dart';
import 'package:quizappbackup/services/models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Reads all documents from the topics collection
  Future<List<Topic>> getTopics() async {
    var ref = _db.collection(
        'topics'); // Reference to the 'topics' collection in Firestore
    var snapshot =
        await ref.get(); // Retrieve all documents from the collection
    var data = snapshot.docs
        .map((s) => s.data()); // Extract the data from each document
    var topics = data
        .map((d) => Topic.fromJson(d))
        .toList(); // Convert the data into Topic objects
    return topics; // Return the list of Topic objects
  }

  /// Retrieves a single quiz document
  Future<Quiz> getQuiz(String quizId) async {
    var ref = _db
        .collection('quizzes')
        .doc(quizId); // Reference to the quiz document with the provided quizId
    var snapshot = await ref.get(); // Retrieve the quiz document
    return Quiz.fromJson(snapshot.data() ??
        {}); // Convert the data into a Quiz object and return it
  }

  /// Listens to current user's report document in Firestore
  Stream<Report> streamReport() {
    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = _db.collection('reports').doc(
            user.uid); // Reference to the report document for the current user
        return ref.snapshots().map((doc) => Report.fromJson(doc
            .data()!)); // Listen to changes in the document and convert the data into a Report object
      } else {
        return Stream.fromIterable([
          Report()
        ]); // If the user is null, return a stream with an empty Report object
      }
    });
  }

  Future<void> updateUserReport(Quiz quiz) {
    var user = AuthService().user!;
    var ref = _db.collection('reports').doc(user.uid);

    var data = {
      'total': FieldValue.increment(1),
      'topics': {
        quiz.topic: FieldValue.arrayUnion([quiz.id])
      }
    };

    return ref.set(data, SetOptions(merge: true));
  }
}
