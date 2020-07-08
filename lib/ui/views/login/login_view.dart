import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:log_location/ui/views/login/login_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _LoginForm(),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () async => await model.signIn(),
                        child: model.isBusy
                            ? SizedBox(
                                height: 24.0,
                                width: 24.0,
                                child: CircularProgressIndicator(),
                              )
                            : Text('LOGIN'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoginForm extends HookViewModelWidget<LoginViewModel> {
  _LoginForm({Key key}) : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(BuildContext context, LoginViewModel model) {
    var email = useTextEditingController();
    var password = useTextEditingController();
    return Column(
      children: <Widget>[
        TextField(
          controller: email,
          keyboardType: TextInputType.emailAddress,
          onChanged: model.updateEmail,
        ),
        TextField(
          controller: password,
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          onChanged: model.updatePassword,
        ),
      ],
    );
  }
}
