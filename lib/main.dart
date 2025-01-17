import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_feed/features/services/wrapper.dart';
import 'package:get/get.dart';
import 'package:video_feed/features/comment/bloc/cubit/comments_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CommentsCubit>(
          create: (context) => CommentsCubit(),
        ),
        // Add other BlocProviders here if needed
      ],
      child: GetMaterialApp(
        title: 'Vidapp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const Wrapper(),
      ),
    );
  }
}
