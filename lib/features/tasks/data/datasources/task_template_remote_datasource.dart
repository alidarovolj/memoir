import 'package:dio/dio.dart';
import 'package:memoir/features/tasks/data/models/task_template_model.dart';
import 'package:memoir/features/tasks/data/models/task_model.dart';
import 'package:memoir/core/config/api_config.dart';
import 'dart:developer';

abstract class TaskTemplateRemoteDataSource {
  Future<Map<String, dynamic>> getTemplates({
    bool? isSystem,
    String? categoryId,
    String? search,
    int page = 1,
    int pageSize = 50,
  });

  Future<TaskTemplateModel> getTemplate(String templateId);
  Future<TaskTemplateModel> createTemplate(Map<String, dynamic> templateData);
  Future<TaskTemplateModel> updateTemplate(
    String templateId,
    Map<String, dynamic> updates,
  );
  Future<void> deleteTemplate(String templateId);
  Future<TaskModel> useTemplate(
    String templateId,
    UseTemplateRequest request,
  );
}

class TaskTemplateRemoteDataSourceImpl
    implements TaskTemplateRemoteDataSource {
  final Dio dio;

  TaskTemplateRemoteDataSourceImpl({required this.dio});

  @override
  Future<Map<String, dynamic>> getTemplates({
    bool? isSystem,
    String? categoryId,
    String? search,
    int page = 1,
    int pageSize = 50,
  }) async {
    try {
      log('📋 [TEMPLATES] Fetching templates (page: $page, size: $pageSize)');

      final queryParams = <String, dynamic>{
        'skip': (page - 1) * pageSize,
        'limit': pageSize,
      };

      if (isSystem != null) {
        queryParams['is_system'] = isSystem;
      }
      if (categoryId != null) {
        queryParams['category_id'] = categoryId;
      }
      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final response = await dio.get(
        '${ApiConfig.apiV1}/task-templates',
        queryParameters: queryParams,
      );

      log('✅ [TEMPLATES] Fetched ${response.data['total']} templates');
      return response.data;
    } catch (e) {
      log('❌ [TEMPLATES] Error fetching templates: $e');
      rethrow;
    }
  }

  @override
  Future<TaskTemplateModel> getTemplate(String templateId) async {
    try {
      log('📋 [TEMPLATES] Fetching template: $templateId');

      final response = await dio.get(
        '${ApiConfig.apiV1}/task-templates/$templateId',
      );

      log('✅ [TEMPLATES] Fetched template: ${response.data['name']}');
      return TaskTemplateModel.fromJson(response.data);
    } catch (e) {
      log('❌ [TEMPLATES] Error fetching template: $e');
      rethrow;
    }
  }

  @override
  Future<TaskTemplateModel> createTemplate(
    Map<String, dynamic> templateData,
  ) async {
    try {
      log('📋 [TEMPLATES] Creating template: ${templateData['name']}');

      final response = await dio.post(
        '${ApiConfig.apiV1}/task-templates',
        data: templateData,
      );

      log('✅ [TEMPLATES] Created template: ${response.data['name']}');
      return TaskTemplateModel.fromJson(response.data);
    } catch (e) {
      log('❌ [TEMPLATES] Error creating template: $e');
      rethrow;
    }
  }

  @override
  Future<TaskTemplateModel> updateTemplate(
    String templateId,
    Map<String, dynamic> updates,
  ) async {
    try {
      log('📋 [TEMPLATES] Updating template: $templateId');

      final response = await dio.put(
        '${ApiConfig.apiV1}/task-templates/$templateId',
        data: updates,
      );

      log('✅ [TEMPLATES] Updated template: ${response.data['name']}');
      return TaskTemplateModel.fromJson(response.data);
    } catch (e) {
      log('❌ [TEMPLATES] Error updating template: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteTemplate(String templateId) async {
    try {
      log('📋 [TEMPLATES] Deleting template: $templateId');

      await dio.delete(
        '${ApiConfig.apiV1}/task-templates/$templateId',
      );

      log('✅ [TEMPLATES] Deleted template');
    } catch (e) {
      log('❌ [TEMPLATES] Error deleting template: $e');
      rethrow;
    }
  }

  @override
  Future<TaskModel> useTemplate(
    String templateId,
    UseTemplateRequest request,
  ) async {
    try {
      log('📋 [TEMPLATES] Using template: $templateId');

      final response = await dio.post(
        '${ApiConfig.apiV1}/task-templates/$templateId/use',
        data: request.toJson(),
      );

      log('✅ [TEMPLATES] Created task from template: ${response.data['title']}');
      return TaskModel.fromJson(response.data);
    } catch (e) {
      log('❌ [TEMPLATES] Error using template: $e');
      rethrow;
    }
  }
}
