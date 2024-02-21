import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sikad_app/src/bloc/logout/logout_bloc.dart';
import 'package:sikad_app/src/data/datasources/auth_local_datasource.dart';
import 'package:sikad_app/src/pages/auth/auth_page.dart';

class ProfileTest extends StatefulWidget {
  final String roles;
  const ProfileTest({
    super.key,
    required this.roles,
  });

  @override
  State<ProfileTest> createState() => _ProfileTestState();
}

class _ProfileTestState extends State<ProfileTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('data'),
          Align(
            alignment: Alignment.bottomCenter,
            child: BlocProvider(
              create: (context) => LogoutBloc(),
              child: BlocConsumer<LogoutBloc, LogoutState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    loaded: () {
                      AuthLocalDatasource().removeAuthData();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const AuthPage();
                          },
                        ),
                      );
                    },
                    error: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Logout Gagal'),
                        ),
                      );
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return MaterialButton(
                        onPressed: () {
                          context.read<LogoutBloc>().add(LogoutEvent.logout());
                        },
                        child: Text('Log Out'),
                      );
                    },
                    loaded: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
