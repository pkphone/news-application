import 'package:equatable/equatable.dart';

abstract class Source extends Equatable {
  const Source({
    this.title,
    this.url,
  });

  final String? title;
  final String? url;
}
