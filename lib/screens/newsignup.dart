import 'package:flutter/material.dart';
import '../functions/signupform.dart';
import '../widget/Textfield.dart';

class NewSignUp extends StatefulWidget {
  const NewSignUp({Key? key}) : super(key: key);

  @override
  State<NewSignUp> createState() => _NewSignUpState();
}

class _NewSignUpState extends State<NewSignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _companyController = TextEditingController();

  final _accountType = ['Admin', 'User'];
  String _selectedValue = 'Admin';

  Future<bool> signUpForm() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;
      final mobileNumber = _mobileNumberController.text;
      final name = _nameController.text;
      final accounttype = _selectedValue;
      final organization = _companyController.text;

      // final accounType=_

      signUpFormToServer(
              email, password, mobileNumber, name, organization, accounttype)
          .then((value) {
        print(value);
        print(' ${value['status']}this is value status');
        if (value['status']) {
          _emailController.clear();
          _mobileNumberController.clear();
          _passwordController.clear();
          _nameController.clear();
          _confirmPasswordController.clear();
          _companyController.clear();
        }
        return value['status'];
      });
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    if (w <= 600) {
      w = 2.5 * w;
    }
    return Scaffold(
      body: Center(
        child: Container(
          // color: Colors.grey[300],
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 0.18 * h,
                      width: 0.4 * w,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Welcome',
                        style: TextStyle(
                            fontSize: w * 0.03, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SignInFields(
                      controller: _companyController,
                      hintText: 'Name',
                      iconData: Icons.abc,
                      isPassword: false,
                      type: 'text',
                      labelText: 'Company',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SignInFields(
                      controller: _nameController,
                      hintText: 'Name',
                      iconData: Icons.account_box_outlined,
                      isPassword: false,
                      type: 'text',
                      labelText: 'Name',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SignInFields(
                      controller: _mobileNumberController,
                      hintText: 'Mobile Number',
                      iconData: Icons.phone,
                      isPassword: false,
                      type: 'number',
                      labelText: 'Mobile Number',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SignInFields(
                      controller: _emailController,
                      hintText: 'Email',
                      iconData: Icons.email,
                      isPassword: false,
                      type: 'email',
                      labelText: 'Email',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SignInFields(
                      controller: _passwordController,
                      hintText: 'Password',
                      iconData: Icons.password,
                      isPassword: true,
                      type: 'password',
                      labelText: 'Password',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SignInFields(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      iconData: Icons.password,
                      isPassword: true,
                      type: 'password',
                      labelText: 'Confirm Password',
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 0.3 * w),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            labelText: 'Account Type',
                            hintText: 'Account Type',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        value: _selectedValue,
                        items: _accountType
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value as String;
                          });
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.purple[300],
                                borderRadius: BorderRadius.circular(15)),
                            child: ElevatedButton(
                              onPressed: () async {
                                var value = await signUpForm();
                                print(value);
                                if (value) {
                                  print('poppping');
                                  Navigator.pop(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(0.15 * w, 0.067 * h),
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent),
                              child: Text("Create",
                                  style: TextStyle(
                                      fontSize: w * 0.02,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.purple[300],
                                borderRadius: BorderRadius.circular(15)),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  fixedSize: Size(0.15 * w, 0.067 * h),
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent),
                              child: Text("Cancel",
                                  style: TextStyle(
                                      fontSize: w * 0.02,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //  LoginButton(
                    //   data: 'Login', formKey: _formKey,
                    // ),
                    // LoginButton(data: 'Create', formKey: _formKey),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
