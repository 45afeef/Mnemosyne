import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../features/lesson_session/data/models/lession_session_model.dart';
import 'app_api.dart';

class RemoteRestAppApi implements AppApi {
  RemoteRestAppApi({required this.baseUrl});

  final Uri baseUrl;

  final HttpClient _httpClient = HttpClient();

  @override
  Future<LessonSessionModel> generateLessonSession({
    required Map<String, dynamic> payload,
  }) async {
    final response = await _post('/learning/generateLessonSession', payload);

    return LessonSessionModel.fromJson(response);
  }

  @override
  Future<TechniqueContentModel> generateTechniqueItem({
    required String prompt,
  }) async {
    final response = await _post('/generateTechniqueItem', {'prompt': prompt});

    return TechniqueContentModel.fromJson(response);
  }

  @override
  Future<AssessmentContentModel> generateAssessmentItem({
    required String prompt,
  }) async {
    final response = await _post('/generateAssessmentItem', {'prompt': prompt});

    return AssessmentContentModel.fromJson(response);
  }

  @override
  Future<Map<String, dynamic>> generateSyllabusFromGoal({
    required Map<String, dynamic> goalPayload,
  }) async {
    return await _post('/learning/generateSyllabusFromGoal', goalPayload);
  }

  Future<Map<String, dynamic>> _post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final uri = baseUrl.replace(path: baseUrl.path + endpoint);
    final request = await _httpClient.postUrl(uri);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(body));

    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();

    debugPrint(responseBody);
    debugPrint('$response');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final decoded = jsonDecode(responseBody);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      throw const FormatException('Expected JSON object response');
    }

    throw HttpException(
      'HTTP ${response.statusCode}: ${response.reasonPhrase}',
      uri: uri,
    );
  }
}
