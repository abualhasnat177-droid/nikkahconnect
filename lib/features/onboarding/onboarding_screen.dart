import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentStep = 0;
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentStep < 12) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/home');
    }
  }

  void _skip() {
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Step ${_currentStep + 1} of 13'),
        actions: [
          TextButton(
            onPressed: _skip,
            child: const Text('Skip', style: TextStyle(color: Colors.white70)),
          ),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (_currentStep + 1) / 13,
            backgroundColor: AppColors.primaryLight,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (i) => setState(() => _currentStep = i),
              children: const [
                _StepPhone(),
                _StepName(),
                _StepGender(),
                _StepDob(),
                _StepLocation(),
                _StepSect(),
                _StepCaste(),
                _StepEducation(),
                _StepOccupation(),
                _StepAbout(),
                _StepPhoto(),
                _StepPreview(),
                _StepComplete(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _next,
                child: Text(_currentStep == 12 ? 'Start Using Nikah Connect' : 'Continue'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepPhone extends StatelessWidget {
  const _StepPhone();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          const Icon(Icons.phone_android, size: 48, color: AppColors.primary),
          const SizedBox(height: 16),
          const Text('Verify Your Phone', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const Text('We will send a verification code to confirm your number.', style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 24),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              prefixText: '+92 ',
              hintText: '300 1234567',
            ),
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }
}

class _StepName extends StatelessWidget {
  const _StepName();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          const Icon(Icons.person, size: 48, color: AppColors.primary),
          const SizedBox(height: 16),
          const Text('What is Your Name?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const Text('This will be your display name on your profile.', style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 24),
          TextField(
            decoration: const InputDecoration(labelText: 'Full Name', hintText: 'Enter your full name'),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(labelText: 'Email', hintText: 'your@email.com'),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(labelText: 'Password', hintText: 'At least 8 characters'),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}

class _StepGender extends StatelessWidget {
  const _StepGender();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          const Icon(Icons.wc, size: 48, color: AppColors.primary),
          const SizedBox(height: 16),
          const Text('Select Your Gender', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.male, size: 32),
              label: const Text('Male', style: TextStyle(fontSize: 18)),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.female, size: 32),
              label: const Text('Female', style: TextStyle(fontSize: 18)),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepDob extends StatelessWidget {
  const _StepDob();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          const Icon(Icons.cake, size: 48, color: AppColors.primary),
          const SizedBox(height: 16),
          const Text('Date of Birth', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const Text('You must be at least 18 years old to use Nikah Connect.', style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 24),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Date of Birth',
              prefixIcon: Icon(Icons.calendar_today),
              hintText: 'DD/MM/YYYY',
            ),
            readOnly: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _StepLocation extends StatelessWidget {
  const _StepLocation();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          const Icon(Icons.location_on, size: 48, color: AppColors.primary),
          const SizedBox(height: 16),
          const Text('Where Are You Located?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          const SizedBox(height: 24),
          DropdownButtonFormField(
            decoration: const InputDecoration(labelText: 'Country'),
            items: ['Pakistan', 'India', 'UK', 'USA', 'UAE', 'Canada', 'Saudi Arabia', 'Other']
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            onChanged: (_) {},
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField(
            decoration: const InputDecoration(labelText: 'Province / State'),
            items: ['Punjab', 'Sindh', 'KPK', 'Balochistan', 'AJK', 'Other']
                .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                .toList(),
            onChanged: (_) {},
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField(
            decoration: const InputDecoration(labelText: 'City'),
            items: ['Lahore', 'Karachi', 'Islamabad', 'Rawalpindi', 'Faisalabad', 'Multan', 'Other']
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            onChanged: (_) {},
          ),
        ],
      ),
    );
  }
}

class _StepSect extends StatelessWidget {
  const _StepSect();
  @override
  Widget build(BuildContext context) {
    final sects = [
      'Sunni', 'Hanafi', 'Shafi\'i', 'Maliki', 'Hanbali',
      'Deobandi', 'Barelvi', 'Ahle Hadees', 'Salafi', 'Wahabi',
      'Shia', 'Ithna Ashari', 'Ismaili', 'Just Muslim', 'Other',
    ];
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          const Icon(Icons.mosque, size: 48, color: AppColors.primary),
          const SizedBox(height: 16),
          const Text('Islamic Sect', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const Text('Select your Islamic sect or school of thought.', style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: sects.length,
              itemBuilder: (context, i) => FilterChip(
                label: Text(sects[i], style: const TextStyle(fontSize: 12)),
                selected: false,
                onSelected: (_) {},
              ),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField(
            decoration: const InputDecoration(labelText: 'Prayer Frequency'),
            items: ['5 times daily', 'Regularly', 'Occasionally', 'Trying to improve']
                .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                .toList(),
            onChanged: (_) {},
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField(
            decoration: const InputDecoration(labelText: 'Religiosity Level'),
            items: ['Very religious', 'Practicing', 'Moderate', 'Cultural Muslim']
                .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                .toList(),
            onChanged: (_) {},
          ),
        ],
      ),
    );
  }
}

class _StepCaste extends StatelessWidget {
  const _StepCaste();
  @override
  Widget build(BuildContext context) {
    final castes = [
      'Jutt', 'Arain', 'Rao', 'Rana', 'Syed', 'Sheikh', 'Mughal',
      'Rajput', 'Pathan', 'Gujjar', 'Ansari', 'Memon', 'Baloch',
      'Kashmiri', 'Chaudhry', 'Malik', 'Qureshi', 'Other',
    ];
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          const Icon(Icons.people, size: 48, color: AppColors.primary),
          const SizedBox(height: 16),
          const Text('Caste / Biradari', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const Text('Select your caste or biradari (optional but recommended for matching).', style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: castes.length,
              itemBuilder: (context, i) => FilterChip(
                label: Text(castes[i], style: const TextStyle(fontSize: 12)),
                selected: false,
                onSelected: (_) {},
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              child: const Text('Prefer Not to Say'),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepEducation extends StatelessWidget {
  const _StepEducation();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          const Icon(Icons.school, size: 48, color: AppColors.primary),
          const SizedBox(height: 16),
          const Text('Education', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          const SizedBox(height: 24),
          DropdownButtonFormField(
            decoration: const InputDecoration(labelText: 'Highest Education Level'),
            items: ['High School', 'Intermediate', 'Bachelors', 'Masters', 'PhD', 'Other']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (_) {},
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(labelText: 'Field of Study', hintText: 'e.g. Computer Science'),
          ),
        ],
      ),
    );
  }
}

class _StepOccupation extends StatelessWidget {
  const _StepOccupation();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          const Icon(Icons.work, size: 48, color: AppColors.primary),
          const SizedBox(height: 16),
          const Text('Occupation', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          const SizedBox(height: 24),
          DropdownButtonFormField(
            decoration: const InputDecoration(labelText: 'Occupation'),
            items: ['Software Engineer', 'Doctor', 'Teacher', 'Business Owner', 'Lawyer',
                    'Engineer', 'Banker', 'Civil Servant', 'Student', 'Homemaker', 'Other']
                .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                .toList(),
            onChanged: (_) {},
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField(
            decoration: const InputDecoration(labelText: 'Industry'),
            items: ['Technology', 'Healthcare', 'Education', 'Finance', 'Government', 'Business', 'Other']
                .map((i) => DropdownMenuItem(value: i, child: Text(i)))
                .toList(),
            onChanged: (_) {},
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField(
            decoration: const InputDecoration(labelText: 'Marital Status'),
            items: ['Never Married', 'Divorced', 'Widowed']
                .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                .toList(),
            onChanged: (_) {},
          ),
        ],
      ),
    );
  }
}

class _StepAbout extends StatelessWidget {
  const _StepAbout();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          const Icon(Icons.edit_note, size: 48, color: AppColors.primary),
          const SizedBox(height: 16),
          const Text('About You', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          const SizedBox(height: 24),
          TextField(
            decoration: const InputDecoration(
              labelText: 'About Me',
              hintText: 'Tell others about yourself, your values, and what makes you unique...',
              alignLabelWithHint: true,
            ),
            maxLines: 5,
            maxLength: 500,
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Looking For',
              hintText: 'Describe your ideal partner...',
              alignLabelWithHint: true,
            ),
            maxLines: 5,
            maxLength: 500,
          ),
        ],
      ),
    );
  }
}

class _StepPhoto extends StatelessWidget {
  const _StepPhoto();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          const Icon(Icons.camera_alt, size: 48, color: AppColors.primary),
          const SizedBox(height: 16),
          const Text('Add Profile Photos', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          const Text('Upload at least 1 photo to send interest requests. Your photos are hidden until mutual acceptance.', style: TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (i) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 100,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                  ),
                  child: i == 0
                      ? const Icon(Icons.add_photo_alternate, size: 36, color: AppColors.primary)
                      : const Icon(Icons.add, size: 36, color: AppColors.textSecondary),
                ),
              ),
            )),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text('Photos are reviewed before being shown', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          ),
        ],
      ),
    );
  }
}

class _StepPreview extends StatelessWidget {
  const _StepPreview();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.visibility, size: 48, color: AppColors.primary),
          ),
          const SizedBox(height: 16),
          const Text('Profile Preview', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(radius: 28, backgroundColor: AppColors.primaryLight, child: Icon(Icons.person, color: AppColors.primary)),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your Name, 25', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                        Text('Lahore, Pakistan', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text('Your about me text will appear here...', style: TextStyle(color: AppColors.textSecondary)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Review your profile. You can edit anytime.', style: TextStyle(color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}

class _StepComplete extends StatelessWidget {
  const _StepComplete();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_circle, size: 64, color: AppColors.primary),
          ),
          const SizedBox(height: 24),
          const Text('Welcome to Nikah Connect!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          const Text(
            'Your profile has been submitted for review.\nYou can start browsing profiles right away!',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.primary, size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Your photos will appear once approved by our moderation team.',
                    style: TextStyle(fontSize: 12, color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
