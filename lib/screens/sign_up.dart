import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/auth_services.dart';
import '../utils/appValidator.dart';
import 'login.dart';

class SignUpView extends StatefulWidget {
  SignUpView({super.key});

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  var authServices = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  var isLoader = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });

      var data = {
        "username": _userNameController.text,
        "email": _emailController.text,
        "phoneNumber": _phoneNumberController.text,
        "password": _passwordController.text,
        'remainingAmount':0,
        'totalCredit':0,
        'totalDebit':0,
      };
      await authServices.createUser(data, context);
      setState(() {
        isLoader = false;
      });
    }
  }

  var appValidator = AppValidator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF252634),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              SizedBox(
                width: 250,
                child: Text(
                  "Create A New Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _userNameController,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: _buildInputDecoration("Username", Icons.person),
                validator: appValidator.validateUserName,
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _emailController,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: _buildInputDecoration("Email", Icons.email),
                validator: appValidator.validateEmail,
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _phoneNumberController,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.phone,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration:
                _buildInputDecoration("Phone Number", Icons.phone),
                validator: appValidator.validatePhoneNumber,
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _passwordController,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.text,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: _buildInputDecoration("Password", Icons.lock),
                validator: appValidator.validatePassword,
              ),
              SizedBox(
                height: 40.0,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){isLoader ? print("loading"): _submitForm();},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: isLoader ? Center(child: CircularProgressIndicator()) :
                  Text(
                    "Create",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginView(),
                    ),
                  );
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.amber, fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String textlabel, IconData suffixIcon) {
    return InputDecoration(
      fillColor: Color(0xAA494A59),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0x35949494)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      labelStyle: TextStyle(color: Colors.white),
      labelText: textlabel,
      filled: true,
      suffixIcon: Icon(
        suffixIcon,
        color: Color(0xff949494),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
