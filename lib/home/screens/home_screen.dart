import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_feed/common/utils/bottom_sheet_utils.dart';
import 'package:video_feed/components/utils/fileshare_utils.dart';
import 'package:video_feed/features/comment/bloc/cubit/comments_cubit.dart';
import 'package:video_feed/styles/app_colors.dart';
import 'package:video_feed/home/screens/profile_screen.dart';
import 'package:video_feed/common/constants/string_constants.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  VideoPlayerController? _currentController;
  int _currentIndex = 0;

  // List of video URLs
  final List<String> videoUrls = VideoUrls.urls;

  final List<Widget> _screens = [
    const Center(
        child: Text("Home", style: TextStyle(color: AppColors.background))),
    const Center(
        child: Text("Friends", style: TextStyle(color: AppColors.background))),
    const Center(
        child: Text("Add", style: TextStyle(color: AppColors.background))),
    const Center(
        child: Text("Chat", style: TextStyle(color: AppColors.background))),
    const Center(child: ProfileScreen()),
  ];

  @override
  void initState() {
    super.initState();
    _initializeAndPlay(0);
  }

  @override
  void dispose() {
    _currentController?.dispose();
    super.dispose();
  }

  void _initializeAndPlay(int index) {
    _currentController?.dispose();
    _currentController = VideoPlayerController.asset(videoUrls[index])
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
        }
        _currentController?.play();
        _currentController?.setLooping(true);
      }).catchError((error) {
        debugPrint('Error initializing video: $error');
      });
  }

  void _pauseCurrentVideo() {
    if (_currentController?.value.isPlaying ?? false) {
      _currentController?.pause();
    }
  }

  void _togglePlayPause() {
    if (_currentController != null) {
      setState(() {
        if (_currentController!.value.isPlaying) {
          _currentController?.pause();
        } else {
          _currentController?.play();
        }
      });
    }
  }

  void _onTap(int index) {
    if (_currentIndex != index) {
      _pauseCurrentVideo();
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CommentsCubit(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _currentIndex == 0
            ? PageView.builder(
                controller: _pageController,
                itemCount: videoUrls.length,
                scrollDirection: Axis.vertical,
                onPageChanged: (index) {
                  _pauseCurrentVideo();
                  _initializeAndPlay(index);
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: _togglePlayPause,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        _currentController != null &&
                                _currentController!.value.isInitialized
                            ? FittedBox(
                                fit: BoxFit.cover,
                                child: SizedBox(
                                  width: _currentController!.value.size.width,
                                  height: _currentController!.value.size.height,
                                  child: VideoPlayer(_currentController!),
                                ),
                              )
                            : const Center(child: CircularProgressIndicator()),
                        if (_currentController != null &&
                            !_currentController!.value.isPlaying)
                          const Center(
                            child: Icon(
                              Icons.play_arrow,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.comment,
                                    color: Colors.white, size: 30),
                                onPressed: () {
                                  BottomSheetUtils.showCommentsSheet(
                                    context: context,
                                    videoId: videoUrls[index],
                                  );
                                },
                              ),
                              const SizedBox(height: 10),
                              IconButton(
                                icon: const Icon(Icons.share,
                                    color: Colors.white, size: 30),
                                onPressed: () async {
                                  try {
                                    await FileSharingUtil.shareLocalFile(
                                        videoUrls[index]);
                                  } catch (e) {
                                    debugPrint('Sharing failed: $e');
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.shadow,
          currentIndex: _currentIndex,
          onTap: _onTap,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: "Friends",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: "Add",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: "Chat",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
