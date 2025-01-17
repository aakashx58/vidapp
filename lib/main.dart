import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_feed/features/comment/model/comment_model.dart';
import 'package:video_feed/features/services/wrapper.dart';
import 'package:video_feed/features/comment/bloc/cubit/comments_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Hive
  await Hive.initFlutter();

  // Register the Hive adapter for CommentModel
  Hive.registerAdapter(CommentModelAdapter());

  // Open the Hive box for comments
  final commentsBox = await Hive.openBox<CommentModel>('comments');

  runApp(MyApp(commentsBox: commentsBox));
}

class MyApp extends StatelessWidget {
  final Box<CommentModel> commentsBox;

  const MyApp({required this.commentsBox, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CommentsCubit>(
          create: (context) => CommentsCubit(commentsBox),
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
