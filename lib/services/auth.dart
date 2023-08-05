import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert'; // Importing dart:convert library to convert the data into a specific format.
import 'dart:math'; // Importing dart:math library to generate random numbers.
import 'package:crypto/crypto.dart'; // Importing crypto library for hashing functions.
import 'package:sign_in_with_apple/sign_in_with_apple.dart'; // Importing sign_in_with_apple library for Apple Sign In.

class AuthService {
  final userStream = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;
  Future<void> anonLogin() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException {
      // handle error
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> googleLogin() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(authCredential);
    } on FirebaseAuthException catch (e) {
      // handle error
    }
  }

  // Function to generate a cryptographically secure random nonce.
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._'; // Characters that can be included in the nonce.
    final random =
        Random.secure(); // Creating a secure, random number generator.
    return List.generate(
            length,
            (_) => charset[random.nextInt(charset
                .length)]) // Generating a list of random characters from the charset.
        .join(); // Joining the list of characters into a single string.
  }

  // Function to compute the SHA-256 hash of a string.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input); // Encoding the input string as UTF-8.
    final digest = sha256
        .convert(bytes); // Computing the SHA-256 hash of the encoded string.
    return digest.toString(); // Returning the hash as a string.
  }

  // Function to sign in with Apple.
  Future<UserCredential> signInWithApple() async {
    // Generating a random nonce.
    final rawNonce = generateNonce();
    // Computing the SHA-256 hash of the nonce.
    final nonce = sha256ofString(rawNonce);

    // Requesting an Apple ID credential. The nonce is included in the request.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Creating an OAuth credential from the Apple ID credential. The raw nonce is included in the credential.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Signing in the user with Firebase. If the nonce in the OAuth credential does not match the nonce in the Apple ID credential, the sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }
}
