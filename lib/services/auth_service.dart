import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  // Change return type to Future<AuthResponse> so we can get the user ID
  Future<AuthResponse> signUp(String email, String password, String username) async {
    return await supabase.auth.signUp(
      email: email,
      password: password,
      data: {'username': username}, 
    );
  }

  Future<AuthResponse> signIn(String email, String password) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  User? get currentUser => supabase.auth.currentUser;
}