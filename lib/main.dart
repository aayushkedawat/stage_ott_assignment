import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stage_ott_assignment/core/util/connectivity_check.dart';
import 'package:stage_ott_assignment/features/movie/presentation/screens/fav_screen/favorite_screen.dart';
import 'package:stage_ott_assignment/features/movie/presentation/screens/home/movie_screen.dart';
import 'package:stage_ott_assignment/injection_container.dart';

import 'features/movie/presentation/blocs/movie_bloc.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await initialiseDependencies();
      runApp(MyApp());
    },
    (error, stack) {},
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final Connectivity connectivity = Connectivity();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MovieBloc>(
            create: (context) => sl(),
          ),
        ],
        child: MaterialApp(
            title: 'Stage OTT Assignment',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            // home: MovieListScreen(),
            home: FutureBuilder<bool>(
              future: ConnectivityCheck.isConnected(),
              builder: (context, snapshot) {
                // If the future is still loading, show a loading indicator
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                // Handle errors in fetching data
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  );
                }

                // Handle if no data is available or the data is false (no connection)
                if (!snapshot.hasData || !(snapshot.data ?? false)) {
                  return const FavoriteScreen();
                }

                // If connected, return the FavoriteScreen
                return const MovieListScreen();
              },
            )));
  }
}
