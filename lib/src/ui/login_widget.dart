import 'package:flutter/material.dart';
import 'package:zing_wait_table/src/blocs/login_bloc.dart';
import 'package:zing_wait_table/src/models/login_state.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  LoginBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = LoginBloc();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginBloc bloc = Provider.of(context);

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

  Widget _buildChild(SearchState state) {
    if (state is SearchNoTerm) {
      return SearchIntro();
    } else if (state is SearchEmpty) {
      return EmptyWidget();
    } else if (state is SearchLoading) {
      return LoadingWidget();
    } else if (state is SearchError) {
      return SearchErrorWidget();
    } else if (state is SearchPopulated) {
      return SearchResultWidget(items: state.result.items);
    }

    throw Exception('${state.runtimeType} is not supported');
  }
}