import 'dart:core';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

enum Platform { win, posix }

final _r1 = RegExp(r'"');
final _r2 = RegExp(r'%');
final _r3 = RegExp(r"\\");
final _r4 = RegExp(r"[\r\n]+");
final _r5 = RegExp(r"[^\x20-\x7E]|'");
final _r7 = RegExp(r"'");
final _r8 = RegExp(r"\n");
final _r9 = RegExp(r"\r");
final _r10 = RegExp(r"[[{}\]]");
const _urlencoded = "application/x-www-form-urlencoded";

class CURLGenerator {
  static String escapeStringWindows(String str) =>
      "\"${str.replaceAll(_r1, "\"\"").replaceAll(_r2, "\"%\"").replaceAll(_r3, "\\\\").replaceAllMapped(_r4, (match) => "\"^${match.group(0)}\"")}\"";

  static String escapeStringPosix(String str) {
    if (_r5.hasMatch(str)) {
      // Use ANSI-C quoting syntax.
      return "\$'${str.replaceAll(_r3, "\\\\").replaceAll(_r7, "\\'").replaceAll(_r8, "\\n").replaceAll(_r9, "\\r").replaceAllMapped(_r5, (Match match) {
        String x = match.group(0) ?? "";
        assert(x.length == 1);
        final code = x.codeUnitAt(0);
        if (code < 256) {
          // Add leading zero when needed to not care about the next character.
          return code < 16
              ? "\\x0${code.toRadixString(16)}"
              : "\\x${code.toRadixString(16)}";
        }
        final c = code.toRadixString(16);
        return "\\u${("0000$c").substring(c.length, c.length + 4)}";
      })}'";
    } else {
      // Use single quote syntax.
      return "'$str'";
    }
  }

  static String toCurl(RequestOptions req,
      {Platform platform = Platform.posix}) {
    var command = ["curl"];
    var ignoredHeaders = ["host", "method", "path", "scheme", "version"];
    final escapeString =
        platform == Platform.win ? escapeStringWindows : escapeStringPosix;
    var requestMethod = "GET";
    var data = <String>[];
    final requestHeaders = req.headers;
    String param = "";

    var paramKeys = req.queryParameters.keys.toList();
    for (var i = 0; i <= paramKeys.length - 1; i++) {
      if (i == 0) param += "?";
      if (i != paramKeys.length - 1) param += "&";
    }
    final requestBody = req.data;
    final contentType = requestHeaders["content-type"];

    command.add(escapeString("${req.baseUrl}${req.path}$param")
        .replaceAllMapped(_r10, (match) => "\\${match.group(0)}"));

    if (contentType != null && contentType.indexOf(_urlencoded) == 0) {
      ignoredHeaders.add("content-length");
      requestMethod = "POST";
      data.add("--data");
      data.add(escapeString(req.data.keys
          .map((key) =>
              "${Uri.encodeComponent(key)}=${Uri.encodeComponent(req.data[key])}")
          .join("&")));
    } else if (requestBody != null && requestBody.isNotEmpty) {
      ignoredHeaders.add("content-length");
      requestMethod = "POST";
      data.add("--data-binary");
      data.add(escapeString(requestBody));
    }

    if (req.method != requestMethod) {
      command
        ..add("-X")
        ..add(req.method);
    }
    Map<String, String>.fromIterable(
        requestHeaders.keys.where((k) => !ignoredHeaders.contains(k)),
        value: (k) => requestHeaders[k]).forEach((k, v) {
      command
        ..add("-H")
        ..add(escapeString("$k: $v"));
    });
    return (command
          ..addAll(data)
          ..add("--compressed")
          ..add("--insecure"))
        .join(" ");
  }

  static String getCURLFromRequest(RequestOptions request) {
    // final baseRequest = await request.toBaseRequest();
    final method = request.method;
    final url = request.uri.toString();
    final headers = request.headers;
    var curl = '';
    curl += 'curl';
    curl += ' -v';
    curl += ' -X $method';
    headers.forEach((k, v) {
      curl += ' -H \'$k: $v\'';
    });
    // this is fairly naive, but it should cover most cases
    // ignore: unnecessary_type_check
    if (request is RequestOptions) {
      final body = request.data;
      try {
        if (body != null && body.isNotEmpty) {
          curl += ' -d \'$body\'';
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    curl += ' $url';
    return curl;
  }
}
