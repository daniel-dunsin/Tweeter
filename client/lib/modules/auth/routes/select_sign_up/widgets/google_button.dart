import 'package:client/modules/auth/bloc/auth_bloc.dart';
import 'package:client/modules/auth/bloc/auth_event.dart';
import 'package:client/modules/auth/bloc/auth_state.dart';
import 'package:client/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleButton extends StatefulWidget {
  const GoogleButton({super.key});

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  void onButtonClicked() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? credentials = await googleSignInAccount?.authentication;

    if (credentials?.accessToken != null) {
      context.read<AuthBloc>().add(AuthWithGoogleRequested(accessToken: credentials?.accessToken as String));
    }

    await _googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return ContainedButton(
        fullWidth: true,
        icon: Image.asset(
          "assets/images/icons/google.png",
          width: 20,
          height: 20,
        ),
        child: Text(
          "Continue with google",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        onPressed: onButtonClicked,
        loading: state is AuthWithGoogleLoading,
        disabled: state is AuthWithGoogleLoading,
      );
    });
  }
}
