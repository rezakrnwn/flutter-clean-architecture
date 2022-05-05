import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/common/constants/color_constant.dart';
import 'package:flutter_clean_architecture/common/constants/route_name_constant.dart';
import 'package:flutter_clean_architecture/common/utils/input_text_validator.dart';
import 'package:flutter_clean_architecture/common/utils/snackbar_utils.dart';
import 'package:flutter_clean_architecture/common/widgets/button/rounded_button.dart';
import 'package:flutter_clean_architecture/feature/auth/presentation/login/bloc/login_bloc.dart';
import 'package:flutter_clean_architecture/feature/auth/presentation/login/login_locator_scope.dart';
import 'package:flutter_clean_architecture/locator/core_locator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final LoginBloc loginBloc;

  @override
  void initState() {
    initLoginLocatorScope();
    loginBloc = sLoc<LoginBloc>();
    super.initState();
  }

  @override
  void dispose() {
    sLoc.popScopesTill(RouteNameConstant.login);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginBloc,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            showMovieListPage();
          } else if (state is LoginFailedState) {
            SnackBarUtils.show(context, state.message ?? "error");
          }
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Login"),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration:
                            InputDecoration(hintText: "Input your username"),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: usernameTextController,
                        validator: (value) =>
                            InputTextValidator.onValidateEmptyText(
                          value: value,
                          errorText: "username can't be empty",
                        ),
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration:
                            InputDecoration(hintText: "Input your password"),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: passwordTextController,
                        validator: (value) =>
                            InputTextValidator.onValidateEmptyText(
                          value: value,
                          errorText: "password can't be empty",
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                RoundedButton(
                  title: 'Login',
                  height: 50.0,
                  backgroundColor: ColorConstant.lightPrimary,
                  borderRadius: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  onPressed: () => onPressedLogin(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showMovieListPage() => Navigator.pushNamedAndRemoveUntil(
        context,
        RouteNameConstant.movieList,
        ModalRoute.withName(RouteNameConstant.login),
      );

  void onPressedLogin() {
    if (formKey.currentState!.validate()) {
      loginBloc.add(DoLoginEvent(
        username: usernameTextController.text,
        password: passwordTextController.text,
      ));
    }
  }
}
