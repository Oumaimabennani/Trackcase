import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trackcase/widgets/custom_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/colis.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter your email to reset password',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              const EmailFormField(),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: () async {
                  final email = EmailFormField.emailController.text;
                  if (email.isNotEmpty) {
                    try {
                      print('Attempting to send reset email to $email');
                      await FirebaseAuth.instance.setLanguageCode("fr");
                      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                      print('Password reset email sent successfully');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Password reset email sent!')),
                      );
                    } catch (e) {
                      print('Failed to send reset email: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to send reset email: $e')),
                      );
                    }
                  } else {
                    print('No email entered');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter your email')),
                    );
                  }
                },
                text: 'Reset Password',
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmailFormField extends StatefulWidget {
  const EmailFormField({Key? key}) : super(key: key);

  static TextEditingController emailController = TextEditingController();

  @override
  _EmailFormFieldState createState() => _EmailFormFieldState();
}

class _EmailFormFieldState extends State<EmailFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: EmailFormField.emailController,
      decoration: const InputDecoration(
        labelText: 'Email',
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  @override
  void dispose() {
    EmailFormField.emailController.dispose();
    super.dispose();
  }
}
