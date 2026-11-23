import 'package:flutter/material.dart';

const Color backgroundColor = Color(0xFF101522);
const Color cardColor = Color(0xFF252D40);
const Color accentColor = Color(0xFF9878FF);
const Color lightPurple = Color(0xFFC6B5FF);
const Color textColor = Color(0xFFF4F3FA);
const Color secondaryText = Color(0xFF9BA5B8);

void main() {
  runApp(const ClipCraftAuthApp());
}

class ClipCraftAuthApp extends StatelessWidget {
  const ClipCraftAuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ClipCraft Studio',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: const ColorScheme.dark(
          primary: accentColor,
          secondary: lightPurple,
          surface: cardColor,
        ),
      ),
      home: const AuthScreen(),
    );
  }
}

// ---------------------------------------------------------------------------
// AUTHENTICATION SCREEN (Sign In & Sign Up)
// ---------------------------------------------------------------------------
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isSignIn = true;
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  static const String _adminEmail = 'admin@example.com';
  static const String _adminPassword = 'admin123';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const VideoGeneratorScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              accentColor.withOpacity(0.25),
              backgroundColor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Card(
                color: cardColor,
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                  side: BorderSide(color: Colors.white.withOpacity(0.08)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: accentColor.withOpacity(0.18),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.movie_filter_outlined,
                              size: 42,
                              color: lightPurple,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'ClipCraft AI',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _isSignIn
                              ? 'Sign in to your AI Video Studio'
                              : 'Create your account to get started',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13,
                            color: secondaryText,
                          ),
                        ),
                        const SizedBox(height: 24),

                        if (_isSignIn) ...[
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: accentColor.withOpacity(0.3),
                              ),
                            ),
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      size: 16,
                                      color: lightPurple,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Demo Admin Credentials',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: lightPurple,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'Email: admin@example.com\nPassword: admin123',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],

                        if (!_isSignIn) ...[
                          TextFormField(
                            controller: _nameController,
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(color: textColor),
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              labelStyle: const TextStyle(color: secondaryText),
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: lightPurple,
                              ),
                              filled: true,
                              fillColor: backgroundColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator:
                                (value) =>
                            value == null || value.trim().isEmpty
                                ? 'Please enter your name'
                                : null,
                          ),
                          const SizedBox(height: 16),
                        ],

                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(color: textColor),
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            labelStyle: const TextStyle(color: secondaryText),
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: lightPurple,
                            ),
                            filled: true,
                            fillColor: backgroundColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          textInputAction:
                          _isSignIn
                              ? TextInputAction.done
                              : TextInputAction.next,
                          onFieldSubmitted: (_) {
                            if (_isSignIn) _submitForm();
                          },
                          style: const TextStyle(color: textColor),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: secondaryText),
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: lightPurple,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: secondaryText,
                              ),
                              onPressed:
                                  () => setState(
                                    () =>
                                _obscurePassword = !_obscurePassword,
                              ),
                            ),
                            filled: true,
                            fillColor: backgroundColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            if (_isSignIn &&
                                _emailController.text.trim() == _adminEmail &&
                                value != _adminPassword) {
                              return 'Incorrect admin password (use admin123)';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        if (!_isSignIn) ...[
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: _obscureConfirmPassword,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _submitForm(),
                            style: const TextStyle(color: textColor),
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              labelStyle: const TextStyle(color: secondaryText),
                              prefixIcon: const Icon(
                                Icons.lock_reset,
                                color: lightPurple,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirmPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: secondaryText,
                                ),
                                onPressed:
                                    () => setState(
                                      () =>
                                  _obscureConfirmPassword =
                                  !_obscureConfirmPassword,
                                ),
                              ),
                              filled: true,
                              fillColor: backgroundColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                        ],

                        const SizedBox(height: 16),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              _isSignIn ? 'Sign In' : 'Create Account',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              _isSignIn
                                  ? "Don't have an account?"
                                  : "Already have an account?",
                              style: const TextStyle(
                                color: secondaryText,
                                fontSize: 13,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isSignIn = !_isSignIn;
                                  _formKey.currentState?.reset();
                                  _emailController.clear();
                                  _passwordController.clear();
                                  _confirmPasswordController.clear();
                                  _nameController.clear();
                                });
                              },
                              child: Text(
                                _isSignIn ? 'Sign Up' : 'Sign In',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: lightPurple,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// CLIPCRAFT VIDEO GENERATOR SCREEN
// ---------------------------------------------------------------------------
class VideoGeneratorScreen extends StatefulWidget {
  const VideoGeneratorScreen({super.key});

  @override
  State<VideoGeneratorScreen> createState() => _VideoGeneratorScreenState();
}

class _VideoGeneratorScreenState extends State<VideoGeneratorScreen> {
  final TextEditingController promptController = TextEditingController();

  String selectedStyle = 'Cinematic';
  String aspectRatio = '16:9';
  String quality = 'Full HD';
  double duration = 10;

  bool isGenerating = false;
  bool isPlaying = false;
  bool hasGenerated = false;

  final List<Map<String, dynamic>> creations = [];

  final List<Map<String, dynamic>> styles = [
    {'name': 'Cinematic', 'icon': Icons.movie_creation_outlined},
    {'name': 'Realistic', 'icon': Icons.camera_alt_outlined},
    {'name': 'Anime', 'icon': Icons.animation_outlined},
    {'name': '3D Animation', 'icon': Icons.view_in_ar_outlined},
  ];

  @override
  void dispose() {
    promptController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: cardColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> generateVideo() async {
    if (promptController.text.trim().isEmpty) {
      showMessage('Please enter a video description first');
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      isGenerating = true;
      hasGenerated = false;
      isPlaying = false;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      isGenerating = false;
      hasGenerated = true;

      creations.insert(0, {
        'prompt': promptController.text.trim(),
        'style': selectedStyle,
        'duration': duration.toInt(),
        'quality': quality,
        'ratio': aspectRatio,
        'favorite': false,
      });
    });

    showMessage('Demo video generated successfully!');
  }

  void openHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreationsScreen(creations: creations),
      ),
    ).then((_) {
      if (mounted) setState(() {});
    });
  }

  Widget sectionTitle(String title, {String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: textColor,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(color: secondaryText, fontSize: 12),
          ),
        ],
      ],
    );
  }

  Widget buildStyleCard(Map<String, dynamic> style) {
    bool selected = selectedStyle == style['name'];

    return GestureDetector(
      onTap: () => setState(() => selectedStyle = style['name']),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 105,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        decoration: BoxDecoration(
          color: selected ? accentColor.withOpacity(0.17) : cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? accentColor : Colors.white.withOpacity(0.05),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              style['icon'],
              color: selected ? lightPurple : secondaryText,
              size: 25,
            ),
            const SizedBox(height: 9),
            Text(
              style['name'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: selected ? textColor : secondaryText,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (selected) ...[
              const SizedBox(height: 7),
              const Icon(Icons.check_circle, color: accentColor, size: 15),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: cardColor,
          style: const TextStyle(color: textColor, fontSize: 13),
          items:
          items
              .map(
                (item) => DropdownMenuItem(value: item, child: Text(item)),
          )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        titleSpacing: 20,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.18),
                borderRadius: BorderRadius.circular(11),
              ),
              child: const Icon(
                Icons.movie_filter_outlined,
                color: lightPurple,
                size: 22,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'ClipCraft',
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'My Creations',
            onPressed: openHistory,
            icon: const Icon(Icons.video_library_outlined, color: lightPurple),
          ),
          IconButton(
            tooltip: 'Sign Out',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AuthScreen()),
              );
            },
            icon: const Icon(Icons.logout, color: lightPurple),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create something amazing.',
                style: TextStyle(
                  color: textColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Turn your imagination into video.',
                style: TextStyle(color: secondaryText, fontSize: 13),
              ),
              const SizedBox(height: 25),
              sectionTitle(
                'Your creative prompt',
                subtitle: 'Describe your idea in a few sentences.',
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white10),
                ),
                child: TextField(
                  controller: promptController,
                  maxLines: 4,
                  maxLength: 500,
                  onChanged: (_) => setState(() {}),
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 14,
                    height: 1.5,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Describe the video you want to create...',
                    hintStyle: const TextStyle(
                      color: secondaryText,
                      fontSize: 13,
                    ),
                    filled: true,
                    fillColor: backgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              sectionTitle(
                'Choose a visual style',
                subtitle: 'Select the look of your video.',
              ),
              const SizedBox(height: 13),
              SizedBox(
                height: 115,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: styles.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder:
                      (context, index) => buildStyleCard(styles[index]),
                ),
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sectionTitle('Video settings'),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          color: lightPurple,
                          size: 19,
                        ),
                        const SizedBox(width: 9),
                        const Text(
                          'Duration',
                          style: TextStyle(color: textColor),
                        ),
                        const Spacer(),
                        Text(
                          '${duration.toInt()} seconds',
                          style: const TextStyle(
                            color: lightPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: duration,
                      min: 5,
                      max: 30,
                      divisions: 5,
                      activeColor: accentColor,
                      inactiveColor: Colors.white12,
                      onChanged: (value) => setState(() => duration = value),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Aspect ratio',
                      style: TextStyle(color: secondaryText, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    buildDropdown(
                      value: aspectRatio,
                      items: ['16:9', '9:16', '1:1'],
                      onChanged: (v) => setState(() => aspectRatio = v!),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Video quality',
                      style: TextStyle(color: secondaryText, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    buildDropdown(
                      value: quality,
                      items: ['HD', 'Full HD', '4K'],
                      onChanged: (v) => setState(() => quality = v!),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: isGenerating ? null : generateVideo,
                  icon:
                  isGenerating
                      ? const SizedBox(
                    height: 19,
                    width: 19,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : const Icon(Icons.auto_awesome),
                  label: Text(
                    isGenerating ? 'Generating...' : 'Generate Video',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              if (hasGenerated) ...[
                const SizedBox(height: 25),
                sectionTitle('Your video preview'),
                const SizedBox(height: 13),
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF30234F), Color(0xFF1B2943)],
                    ),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause_circle : Icons.play_circle,
                        size: 64,
                        color: lightPurple,
                      ),
                      onPressed: () => setState(() => isPlaying = !isPlaying),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// CREATIONS SCREEN (History)
// ---------------------------------------------------------------------------
class CreationsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> creations;

  const CreationsScreen({super.key, required this.creations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Creations',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: backgroundColor,
      ),
      body:
      creations.isEmpty
          ? const Center(
        child: Text(
          'No creations yet',
          style: TextStyle(color: secondaryText, fontSize: 16),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(18),
        itemCount: creations.length,
        itemBuilder: (context, index) {
          final item = creations[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(17),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['prompt'],
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${item['style']} • ${item['duration']}s • ${item['quality']} • ${item['ratio']}',
                  style: const TextStyle(
                    color: secondaryText,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
