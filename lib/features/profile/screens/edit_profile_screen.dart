import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  final _nameController = TextEditingController(text: 'Zara Ahmed');
  final _aboutController = TextEditingController(text: 'Practicing Muslimah looking for a righteous spouse.');
  final _lookingController = TextEditingController(text: 'A practicing Muslim man with good character.');

  String _selectedGender = 'female';
  String _selectedSect = 'Sunni';
  String _selectedCaste = 'Jutt';
  String _selectedMaritalStatus = 'never_married';
  String _selectedPrayer = 'five_times';
  String _selectedReligiosity = 'practicing';
  String _selectedEducation = 'Bachelors';
  String _selectedOccupation = 'Software Engineer';
  String _selectedCity = 'Lahore';

  @override
  void dispose() {
    _nameController.dispose();
    _aboutController.dispose();
    _lookingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < 3) {
              setState(() => _currentStep++);
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() => _currentStep--);
            }
          },
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: Text(_currentStep == 3 ? 'Save Profile' : 'Continue'),
                  ),
                  if (_currentStep > 0) ...[
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: details.onStepCancel,
                      child: const Text('Back'),
                    ),
                  ],
                ],
              ),
            );
          },
          steps: [
            Step(
              title: const Text('Basic Info'),
              isActive: _currentStep >= 0,
              content: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Display Name'),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField(
                    value: _selectedGender,
                    decoration: const InputDecoration(labelText: 'Gender'),
                    items: ['male', 'female'].map((g) => DropdownMenuItem(value: g, child: Text(g.capitalize()))).toList(),
                    onChanged: (v) => setState(() => _selectedGender = v!),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Date of Birth', prefixIcon: Icon(Icons.calendar_today)),
                    readOnly: true,
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField(
                    value: _selectedMaritalStatus,
                    decoration: const InputDecoration(labelText: 'Marital Status'),
                    items: ['never_married', 'divorced', 'widowed'].map((s) => DropdownMenuItem(
                      value: s,
                      child: Text(s.replaceAll('_', ' ').capitalize()),
                    )).toList(),
                    onChanged: (v) => setState(() => _selectedMaritalStatus = v!),
                  ),
                ],
              ),
            ),
            Step(
              title: const Text('Religion & Culture'),
              isActive: _currentStep >= 1,
              content: Column(
                children: [
                  DropdownButtonFormField(
                    value: _selectedSect,
                    decoration: const InputDecoration(labelText: 'Islamic Sect'),
                    items: ['Sunni', 'Hanafi', 'Shia', 'Deobandi', 'Barelvi', 'Ahle Hadees'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                    onChanged: (v) => setState(() => _selectedSect = v!),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField(
                    value: _selectedCaste,
                    decoration: const InputDecoration(labelText: 'Caste / Biradari'),
                    items: ['Jutt', 'Arain', 'Syed', 'Sheikh', 'Pathan', 'Mughal', 'Rajput'].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (v) => setState(() => _selectedCaste = v!),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField(
                    value: _selectedPrayer,
                    decoration: const InputDecoration(labelText: 'Prayer Frequency'),
                    items: ['five_times', 'regularly', 'occasionally', 'improving'].map((p) => DropdownMenuItem(value: p, child: Text(p.replaceAll('_', ' ').capitalize()))).toList(),
                    onChanged: (v) => setState(() => _selectedPrayer = v!),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField(
                    value: _selectedReligiosity,
                    decoration: const InputDecoration(labelText: 'Religiosity'),
                    items: ['very_religious', 'practicing', 'moderate', 'cultural'].map((r) => DropdownMenuItem(value: r, child: Text(r.replaceAll('_', ' ').capitalize()))).toList(),
                    onChanged: (v) => setState(() => _selectedReligiosity = v!),
                  ),
                ],
              ),
            ),
            Step(
              title: const Text('Education & Career'),
              isActive: _currentStep >= 2,
              content: Column(
                children: [
                  DropdownButtonFormField(
                    value: _selectedEducation,
                    decoration: const InputDecoration(labelText: 'Education Level'),
                    items: ['High School', 'Bachelors', 'Masters', 'PhD'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                    onChanged: (v) => setState(() => _selectedEducation = v!),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField(
                    value: _selectedOccupation,
                    decoration: const InputDecoration(labelText: 'Occupation'),
                    items: ['Software Engineer', 'Doctor', 'Teacher', 'Business', 'Lawyer', 'Other'].map((o) => DropdownMenuItem(value: o, child: Text(o))).toList(),
                    onChanged: (v) => setState(() => _selectedOccupation = v!),
                  ),
                ],
              ),
            ),
            Step(
              title: const Text('About & Photos'),
              isActive: _currentStep >= 3,
              content: Column(
                children: [
                  TextFormField(
                    controller: _aboutController,
                    decoration: const InputDecoration(labelText: 'About Me', hintText: 'Tell others about yourself...'),
                    maxLines: 4,
                    maxLength: 500,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _lookingController,
                    decoration: const InputDecoration(labelText: 'Looking For', hintText: 'Describe your ideal partner...'),
                    maxLines: 4,
                    maxLength: 500,
                  ),
                  const SizedBox(height: 16),
                  const Text('Profile Photos', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildPhotoUpload(),
                      const SizedBox(width: 12),
                      _buildPhotoUpload(),
                      const SizedBox(width: 12),
                      _buildPhotoUpload(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoUpload() {
    return Container(
      width: 100,
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: const Center(
        child: Icon(Icons.add_photo_alternate_outlined, size: 32, color: AppColors.primary),
      ),
    );
  }
}

extension _StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
