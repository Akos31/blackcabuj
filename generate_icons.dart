// import 'dart:io';
// import 'package:image/image.dart';

// void main() async {
//   print('Loading favicon.png...');
//   final bytes = await File('web/favicon.png').readAsBytes();
//   final image = decodeImage(bytes);
//   if (image == null) {
//     print('Failed to decode image');
//     return;
//   }

//   print('Generating Icon-192.png...');
//   final icon192 = copyResize(image, width: 192, height: 192);
//   await File('web/icons/Icon-192.png').writeAsBytes(encodePng(icon192));
//   await File('web/icons/Icon-maskable-192.png').writeAsBytes(encodePng(icon192));

//   print('Generating Icon-512.png...');
//   final icon512 = copyResize(image, width: 512, height: 512);
//   await File('web/icons/Icon-512.png').writeAsBytes(encodePng(icon512));
//   await File('web/icons/Icon-maskable-512.png').writeAsBytes(encodePng(icon512));

//   print('Icons generated successfully.');
// }
