import 'package:flutter/material.dart';
import 'package:zing_wait_table/src/blocs/login_bloc.dart';
import 'package:zing_wait_table/src/models/login_state.dart';
import 'package:provider/provider.dart';

//class LoginWidget extends StatefulWidget {
//  @override
//  LoginWidgetState createState() {
//    return LoginWidgetState();
//  }
//}

class LoginWidget extends StatelessWidget {
  LoginBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = new LoginBloc();

    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          emailField(bloc),
          passwordField(bloc),
          submitButton(bloc)
        ],
      ),
    );
  }

  Widget emailField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.id,
      builder: (context, snapshot) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'You email address',
            labelText: 'Email Address',
            errorText: snapshot.error,
          ),
          onChanged: (String value) {
            bloc.changeId(value);
          },
        );
      },
    );
  }

  Widget passwordField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
            labelText: 'Password',
            errorText: snapshot.error,
          ),
          onChanged: (String value) {
            bloc.changePassword(value);
          },
        );
      },
    );
  }

  Widget submitButton(LoginBloc bloc) {
    return StreamBuilder<bool>(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text('Submit'),
          color: Colors.blue,
          onPressed: snapshot.hasData ? bloc.submit : null,
        );
      },
    );
  }
}