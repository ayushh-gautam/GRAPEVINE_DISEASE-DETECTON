import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class GrapevinePredictor extends StatefulWidget {
  const GrapevinePredictor({super.key});

  @override
  State<GrapevinePredictor> createState() => _GrapevinePredictorState();
}

class _GrapevinePredictorState extends State<GrapevinePredictor> {
  Interpreter? _interpreter;
  File? _selectedImage;
  String _result = "No image selected";

  final List<String> _labels = [
    "Black Rot",
    "Esca (Black Measles)",
    "Healthy",
    "Leaf Blight",
  ];

  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
     
      _interpreter =
          await Interpreter.fromAsset('assets/grapevine_disease_model.tflite');
      debugPrint("Model loaded successfully!");
    } catch (e) {
      debugPrint("Failed to load model: $e");
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked == null) return;

    setState(() {
      _selectedImage = File(picked.path);
      _result = "Processing...";
    });

    await _runModel(File(picked.path));
  }

  Future<void> _runModel(File imageFile) async {
    if (_interpreter == null) return;

    // Read and decode
    final raw = await imageFile.readAsBytes();
    final decoded = img.decodeImage(raw);
    if (decoded == null) return;

    // Resize + normalize
    final resized = img.copyResize(decoded, width: 224, height: 224);
    final input = List.generate(
      1,
      (i) => List.generate(
        224,
        (y) => List.generate(224, (x) {
          final pixel = resized.getPixel(x, y);
          final r = pixel.r.toDouble() / 255.0;
          final g = pixel.g.toDouble() / 255.0;
          final b = pixel.b.toDouble() / 255.0;
          return [r, g, b];
        }),
      ),
    );

    var output = List.filled(_labels.length, 0.0).reshape([1, _labels.length]);

    // Running the inference
    _interpreter!.run(input, output);

   
    final List<double> scores = List<double>.from(output[0]);
    final maxScore = scores.reduce((a, b) => a > b ? a : b);
    final maxIndex = scores.indexOf(maxScore);

    final predictedLabel = _labels[maxIndex];
    final confidence = (maxScore * 100).toStringAsFixed(1);

    setState(() {
      _result = "$predictedLabel ($confidence%)";
    });
  }

  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🍇 Grapevine Disease Detector")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_selectedImage != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _selectedImage!,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.image, size: 100, color: Colors.grey),
                ),
              const SizedBox(height: 24),
              Text(
                _result,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.photo_library),
                label: const Text("Pick Image"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
