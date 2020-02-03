import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zing_wait_table/src/blocs/login_bloc.dart';
import 'package:zing_wait_table/src/models/login_state.dart';
import 'package:zing_wait_table/src/ui/login_widget.dart';

class InitScreen extends StatefulWidget {
  @override
  InitScreenState createState() {
    return InitScreenState();
  }
}

class InitScreenState extends State<InitScreen> {
  LoginBloc bloc;

  @override
  void initState() {
    super.initState();
    this.bloc = LoginBloc();
  }

  @override
  void dispose() {
    super.dispose();
    this.bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LoginState>(
        stream: bloc.subject,
        initialData: LoginInitial(),
        builder: (BuildContext context, AsyncSnapshot<LoginState> snapshot) {
          final state = snapshot.data;

          return Scaffold(
            body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _buildChild(state),
            ),
          );
      },
    );
  }

  Widget _buildChild(LoginState state) {
    if (state is LoginInitial) {
      return LoginWidget();
    }

//    else if (state is SearchEmpty) {
//      return EmptyWidget();
//    } else if (state is SearchLoading) {
//      return LoadingWidget();
//    } else if (state is SearchError) {
//      return SearchErrorWidget();
//    } else if (state is SearchPopulated) {
//      return SearchResultWidget(items: state.result.items);
//    }

    throw Exception('${state.runtimeType} is not supported');
  }
}