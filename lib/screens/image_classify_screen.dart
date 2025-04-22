import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:wtfridge/widgets/constants.dart';
import 'dart:convert';

class ImageClassifyScreen extends StatefulWidget {
  const ImageClassifyScreen({super.key});

  @override
  State<ImageClassifyScreen> createState() => _ImageClassifyScreenState();
}

class _ImageClassifyScreenState extends State<ImageClassifyScreen> {
  String? result;
  final ImagePicker _imagePicker = ImagePicker();
  final String apiKey = Constants().apiKey;
  bool _isLoading = false;
  XFile? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    try {
      // Request appropriate permission
      final permission = source == ImageSource.camera
          ? Permission.camera
          : Permission.photos;

      final status = await permission.request();
      
      if (status.isGranted) {
        final pickedFile = await _imagePicker.pickImage(
          source: source,
          imageQuality: 85,
        );
        
        if (pickedFile != null) {
          setState(() {
            _selectedImage = pickedFile;
            result = null;
          });
          await _analyzeImage(pickedFile);
        }
      } else if (status.isPermanentlyDenied) {
        _showPermissionDeniedDialog(permission);
      }
    } catch (e) {
      setState(() {
        result = 'Failed to pick image: $e';
      });
      debugPrint('Image picker error: $e');
    }
  }


  void _showPermissionDeniedDialog(Permission permission) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission Required'),
        content: Text(
          'Please enable ${permission == Permission.camera ? 'camera' : 'photos'} '
          'access in your device settings to use this feature.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }


  Future<void> _analyzeImage(XFile imageFile) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final bytes = await imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      final response = await http.post(
        Uri.parse(
          'https://vision.googleapis.com/v1/images:annotate?key=$apiKey',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'requests': [
            {
              'image': {'content': base64Image},
              'features': [
                {'type': 'LABEL_DETECTION', 'maxResults': 10},
              ],
            },
          ],
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final labels = responseData['responses'][0]['labelAnnotations'];

        // Filter for food-related labels (you might need to adjust this)
        final foodLabels =
            labels
                .where(
                  (label) =>
                      label['description'].toLowerCase().contains('food') ||
                      label['description'].toLowerCase().contains('fruit') ||
                      label['description'].toLowerCase().contains(
                        'vegetable',
                      ) ||
                      label['description'].toLowerCase().contains('dish') ||
                      label['description'].toLowerCase().contains('meal'),
                )
                .toList();

        if (foodLabels.isNotEmpty) {
          setState(() {
            result = foodLabels
                .map<String>(
                  (label) =>
                      '${label['description']} (${(label['score'] * 100).toStringAsFixed(1)}%)',
                )
                .join('\n');
          });
        } else {
          setState(() {
            result = 'No food items detected. Try another image.';
          });
        }
      } else {
        setState(() {
          result = 'API Error: ${response.statusCode} - ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        result = 'Error analyzing image: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Food Detection'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_selectedImage != null)
              Container(
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: FutureBuilder<File?>(
                  future: File(_selectedImage!.path).exists().then(
                    (exists) => exists ? File(_selectedImage!.path) : null,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(snapshot.data!, fit: BoxFit.cover),
                      );
                    } else {
                      return const Center(child: Text('Image not available'));
                    }
                  },
                ),
              )
            else
              Container(
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.image, size: 100, color: Colors.grey),
                ),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Camera'),
                  onPressed: () => _pickImage(ImageSource.camera),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Gallery'),
                  onPressed: () => _pickImage(ImageSource.gallery),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (result != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Detection Results:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(result!),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
