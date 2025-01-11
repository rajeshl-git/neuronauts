import 'dart:io';
import 'package:http/http.dart' as http;


  Future<void> sendImage(File imageFile) async {
  try {
    final uri = Uri.parse("https://your-api-endpoint.com/upload"); // Replace with your API endpoint

    // Create a multipart request
    var request = http.MultipartRequest('assets/images/child.jpg', uri);

    // Attach the image file to the request
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
      ),
    );

    // Send the request
    var response = await request.send();

    if (response.statusCode == 200) {
      print("Image uploaded successfully!");
      // Handle the response as needed
    } else {
      print("Failed to upload image. Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error uploading image: $e");
  }
}