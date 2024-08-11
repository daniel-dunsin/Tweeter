import 'package:client/config/routes.dart';
import 'package:client/modules/auth/bloc/auth_bloc.dart';
import 'package:client/modules/auth/bloc/auth_event.dart';
import 'package:client/modules/auth/bloc/auth_state.dart';
import 'package:client/modules/auth/models/sign_up_model.dart';
import 'package:client/shared/widgets/app_cover.dart';
import 'package:client/shared/widgets/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:client/shared/utils/validators.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:client/shared/widgets/date_selector.dart';
import 'package:client/shared/widgets/text_fields.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  DateTime? dateOfBirth;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      setState(() {});
    });
    emailController.addListener(() {
      setState(() {});
    });
    userNameController.addListener(() {
      setState(() {});
    });
    passwordController.addListener(() {
      setState(() {});
    });
  }

  void handleSubmit() async {
    context.read<AuthBloc>().add(
          AuthSignUp(
            SignUpModel(
              email: emailController.text,
              password: passwordController.text,
              name: nameController.text,
              userName: userNameController.text,
              dateOfBirth: dateOfBirth!,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSignUpSuccess) {
          Navigator.of(context).pushNamed(AuthRoutes.verifyEmail, arguments: {
            "email": emailController.text,
          });
        }
      },
      builder: (context, state) {
        return AppCover(
          appBar: customAppBar,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Create your account",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 30),
                UnderlinedTextField(
                  labelText: "Name",
                  fullWidth: true,
                  onChangeValue: (value) {},
                  validator: requiredFieldValidator,
                  controller: nameController,
                ),
                UnderlinedTextField(
                  labelText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  fullWidth: true,
                  validator: emailFieldValidator,
                  controller: emailController,
                ),
                UnderlinedTextField(
                  labelText: "Username",
                  fullWidth: true,
                  validator: requiredFieldValidator,
                  controller: userNameController,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return DateSelector(
                          date: dateOfBirth,
                          onChangeDate: (date) {
                            setState(() {
                              dateOfBirth = date;
                            });
                          },
                        );
                      },
                    );
                  },
                  child: UnderlinedTextField(
                    labelText: dateOfBirth != null ? "${dateOfBirth?.day}/${(dateOfBirth?.month as int) + 1}/${dateOfBirth?.year}" : "Date Of Birth",
                    enabled: false,
                    fullWidth: true,
                    validator: (value) {
                      if (dateOfBirth == null) {
                        return "This field is required";
                      }
                      return null;
                    },
                  ),
                ),
                UnderlinedPasswordTextField(
                  labelText: "Password",
                  controller: passwordController,
                  fullWidth: true,
                  validator: passwordFieldValidator,
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ContainedButton(
                    disabled: nameController.text.isEmpty || emailController.text.isEmpty || userNameController.text.isEmpty || passwordController.text.isEmpty || dateOfBirth == null,
                    child: Text("Next"),
                    loading: state is AuthSignUpLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        handleSubmit();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
