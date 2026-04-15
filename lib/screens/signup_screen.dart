import 'package:flutter/material.dart';
import 'package:real_sun_sd_closet_app/screens/login_screen.dart';
import 'package:real_sun_sd_closet_app/screens/productlist_screen.dart';
import 'package:real_sun_sd_closet_app/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignupScreen> {

  TextEditingController _email=TextEditingController();
  TextEditingController _password=TextEditingController();
  TextEditingController _username=TextEditingController();
  TextEditingController _cpassword=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /// Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('image/register2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// Text Content
          const Positioned(
            left: 50,
            top:50,
            child: Text.rich(
              TextSpan(
               children: [
                TextSpan(
                text: 'Hi\n',
                style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
                 
            ),
          ),
                TextSpan(
                 text: 'Sign UP!',
                 style: TextStyle(
                 color: Colors.white,
                 fontSize: 33,
                 fontWeight: FontWeight.normal, // Different weight
           // Change this to your second font
        ),
      ),
    ],
  ),
),
          ),
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height*0.35,right: 35,left: 35),
            child: Column(
              children: [
                TextFormField(
                  controller: _username,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    hintText: 'User Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
                const SizedBox(height: 13,),
                TextFormField(
                  controller: _email,
                  
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    hintText: 'Email',
                    
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
                const SizedBox(height: 13,),
                TextFormField(
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    hintText: 'Password',
                    
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
                const SizedBox(height: 13,),
                TextFormField(
                  controller: _cpassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    hintText: 'Confirm Password',
                    
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
                const SizedBox(height: 30,),
                Row(
                  children: [
                    Text('Sign Up',style: TextStyle(
                      fontSize:27,
                      fontWeight: FontWeight.w700 
                      ),
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xff4c505c),
                      child: IconButton(
                        onPressed: () async {
  try {
    // 1. Local Validation
    final email = _email.text.trim();
    final password = _password.text.trim();
    final username = _username.text.trim();

    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    if (password != _cpassword.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    final authService = AuthService();

    // 2. Auth Signup
    final response = await authService.signUp(email, password, username);
    final user = response.user;

    if (user == null) throw Exception("Signup failed: User is null");

    // 3. Database Entry (Profiles Table)
    // We do this immediately. Since Email Confirmation is OFF, 
    // the user is already authenticated here.
    /*await Supabase.instance.client.from('profiles').insert({
      'id': user.id,
      'username': username,
    });*/

    // 4. Navigation
    // Since Email Confirmation is OFF, response.session will NOT be null.
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProductlistScreen()),
      );
    }

  } catch (e) {
    print("DEBUG ERROR: $e");
    String errorMessage = "An error occurred";
    
    if (e is AuthException) {
      errorMessage = e.message;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  }
},
                        icon:Icon(Icons.arrow_forward_ios)),
                    )

                  ],

                ),
                const SizedBox(height: 30,),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => const LoginScreen()),
                       );
                      }, 
                      child: Text('Log In Instead',style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                        color: Color(0xff4c505b)

                      ),
                    ) 
                  ),
                  
                    
                  ],
                )
              ],
            ),

          ),

        ],
      ),
    );
  }
}