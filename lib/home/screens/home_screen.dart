import 'package:flutter/material.dart';
import 'package:video_feed/common/utils/bottom_sheet_utils.dart';
import 'package:video_feed/components/utils/fileshare_utils.dart';
import 'package:video_feed/styles/app_colors.dart';
import 'package:video_feed/home/screens/profile_screen.dart';
import 'package:video_feed/common/constants/string_constants.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final PageController _pageController = PageController();
  VideoPlayerController? _currentController;
  int _currentIndex = 0;

  List<String> videoUrls = VideoUrls.urls;

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
    WidgetsBinding.instance.addObserver(this);
    _initializeAndPlay(0);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _currentController?.dispose();
    super.dispose();
  }

  /// Initialize and play the video at the given index
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

  /// Pause the current video
  void _pauseCurrentVideo() {
    if (_currentController != null && _currentController!.value.isPlaying) {
      _currentController?.pause();
    }
  }

  /// Toggle play/pause on video tap
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

  /// Handle bottom navigation item tap
  void _onTap(int index) {
    if (_currentIndex != index) {
      _pauseCurrentVideo(); // Pause the video when switching tabs
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Reinitialize the video player when the app is resumed
      _initializeAndPlay(_currentIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onTap: _togglePlayPause, // Toggle play/pause on tap
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Display the video
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

                      // Show play icon when video is paused
                      if (_currentController != null &&
                          !_currentController!.value.isPlaying)
                        const Center(
                          child: Icon(
                            Icons.play_arrow,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),

                      // Overlay UI for actions
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
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
