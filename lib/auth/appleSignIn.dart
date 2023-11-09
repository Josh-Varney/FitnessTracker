import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignInHandler {
  Future<void> handleSignIn(BuildContext context) async {
    try {
      final result = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final AuthCredential credential = OAuthProvider('apple.com').credential(
        accessToken: result.authorizationCode,
        idToken: result.identityToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // You can now use FirebaseAuth.instance.currentUser to get the current user
    } catch (error) {
      // Handle errors
      print('Error during Apple Sign In: $error');
    }
  }
}
