import 'package:flutter/material.dart';
import 'package:real_sun_sd_closet_app/screens/adminpanel_screen.dart';
import 'package:real_sun_sd_closet_app/screens/productlist_screen.dart';
import 'package:real_sun_sd_closet_app/screens/signup_screen.dart';
import 'package:real_sun_sd_closet_app/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _email=TextEditingController();
  TextEditingController _password=TextEditingController();
  
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
                image: AssetImage('image/register.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// Text Content
          const Positioned(
            left: 55,
            top:70,
            child: Text(
              'Welcome\nBack',
              style: TextStyle(
                color: Colors.white,
                fontSize: 33,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height*0.5,right: 35,left: 35),
            child: Column(
              children: [
                TextFormField(
                  controller: _email,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    hintText: 'E-Mail',
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
                const SizedBox(height: 30,),
                Row(
                  children: [
                    Text('Sign In',style: TextStyle(
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
                       final authService = AuthService();

                      await authService.signIn(_email.text.trim(), _password.text.trim());
                      if (_email.text.trim() == "realsunsdcloset@gmail.com") {
                      Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => AdminPanelScreen()),
                         );
                      }
                      else{

                     Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => ProductlistScreen()),
                     );
                      }

                 } catch (e) {
                  ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Login failed")));
                   print("ERROR: $e");
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
                         MaterialPageRoute(builder: (context) => const SignupScreen()),
                       );
                      }, 
                      child: Text('Sign Up',style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                        color: Color(0xff4c505b)

                      ),
                    ) 
                  ),
                  const Spacer(),
                    TextButton(
                      onPressed: () {}, 
                      child: Text('Forgot Password',style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                        color: Color(0xff4c505b)

                       ),
                      )
                    )
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