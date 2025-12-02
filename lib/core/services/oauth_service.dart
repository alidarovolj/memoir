import 'dart:io';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class OAuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  // Google Sign In
  static Future<Map<String, dynamic>?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        // Пользователь отменил вход
        return null;
      }

      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;

      return {
        'provider': 'google',
        'id_token': googleAuth.idToken,
        'access_token': googleAuth.accessToken,
        'email': googleUser.email,
        'name': googleUser.displayName,
        'photo_url': googleUser.photoUrl,
      };
    } catch (e) {
      print('❌ Google Sign In Error: $e');
      rethrow;
    }
  }

  // Apple Sign In
  static Future<Map<String, dynamic>?> signInWithApple() async {
    if (!Platform.isIOS && !Platform.isMacOS) {
      throw UnsupportedError('Apple Sign In доступен только на iOS и macOS');
    }

    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      return {
        'provider': 'apple',
        'id_token': credential.identityToken,
        'authorization_code': credential.authorizationCode,
        'user_id': credential.userIdentifier,
        'email': credential.email,
        'given_name': credential.givenName,
        'family_name': credential.familyName,
      };
    } catch (e) {
      print('❌ Apple Sign In Error: $e');
      rethrow;
    }
  }

  // Проверка доступности Apple Sign In
  static Future<bool> isAppleSignInAvailable() async {
    if (!Platform.isIOS && !Platform.isMacOS) {
      return false;
    }
    
    try {
      return await SignInWithApple.isAvailable();
    } catch (e) {
      return false;
    }
  }

  // Выход из Google
  static Future<void> signOutGoogle() async {
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      print('❌ Google Sign Out Error: $e');
    }
  }
}

