import 'package:quizappbackup/about/about.dart';
import 'package:quizappbackup/profile/profile.dart';
import 'package:quizappbackup/login/login.dart';
import 'package:quizappbackup/topics/topics.dart';
import 'package:quizappbackup/home/home.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/topics': (context) => const TopicsScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/about': (context) => const AboutScreen(),
};
