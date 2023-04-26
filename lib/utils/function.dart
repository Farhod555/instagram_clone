import 'package:flutter_share/flutter_share.dart';

Future<void> share() async {
  await FlutterShare.share(title: 'Instagram_clone');
}