import 'package:injectable/injectable.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';

/// Remote data source for user account and agent-client MuleSoft APIs.
@lazySingleton
class UserAccountRemoteDataSource {
  final ApiClient _client;

  UserAccountRemoteDataSource(this._client);

  // -- IWO Users Account API --

  /// Fetch a user account by email, userName, or id.
  /// Maps to: GET /account/user
  Future<Map<String, dynamic>> fetchUserAccount({
    String? userName,
    String? email,
    String? id,
  }) async {
    final params = <String, String>{};
    if (userName != null && userName.isNotEmpty) params['user_name'] = userName;
    if (email != null && email.isNotEmpty) params['email'] = email;
    if (id != null && id.isNotEmpty) params['user_id'] = id;

    final uri = Uri.parse('${ApiEndpoints.usersAccountBase}/account/user')
        .replace(queryParameters: params);

    final response = await _client.get(uri.toString());
    return response as Map<String, dynamic>;
  }

  /// Create a new user account.
  /// Maps to: POST /account/user
  Future<Map<String, dynamic>> createUserAccount({
    required Map<String, dynamic> userData,
  }) async {
    final response = await _client.post(
      '${ApiEndpoints.usersAccountBase}/account/user',
      body: userData,
    );
    return response as Map<String, dynamic>;
  }

  /// Update an existing user account.
  /// Maps to: PATCH /account/user
  Future<Map<String, dynamic>> updateUserAccount({
    required Map<String, dynamic> userData,
  }) async {
    final response = await _client.patch(
      '${ApiEndpoints.usersAccountBase}/account/user',
      body: userData,
    );
    return response as Map<String, dynamic>;
  }

  /// Deactivate a user account.
  /// Maps to: DELETE /account/user?user_id={userId}
  Future<void> deactivateUserAccount({required String userId}) async {
    await _client.delete(
      '${ApiEndpoints.usersAccountBase}/account/user?user_id=$userId',
    );
  }

  // -- IWO Agent-Client API --

  static const String _agentClientBase =
      'https://dev-pp-agent-client.us-w2.cloudhub.io/api/v1';

  /// Create / register agent record.
  Future<Map<String, dynamic>> createAgent({
    required String requesterId,
    required Map<String, dynamic> agentData,
  }) async {
    final response = await _client.post(
      '$_agentClientBase/agents',
      headers: {'requester-id': requesterId},
      body: agentData,
    );
    return response as Map<String, dynamic>;
  }

  /// Get agent profile.
  Future<Map<String, dynamic>> getAgent({
    required String agentId,
    required String requesterId,
  }) async {
    final response = await _client.get(
      '$_agentClientBase/agents/$agentId',
      headers: {'requester-id': requesterId},
    );
    return response as Map<String, dynamic>;
  }

  /// Get all clients for an agent.
  Future<List<Map<String, dynamic>>> getAgentClients({
    required String agentId,
    required String requesterId,
  }) async {
    final response = await _client.get(
      '$_agentClientBase/agents/$agentId/clients',
      headers: {'requester-id': requesterId},
    );
    final List<dynamic> data =
        response is List ? response : (response['clients'] ?? []);
    return data.cast<Map<String, dynamic>>();
  }

  /// Get activity feed for agent's clients.
  Future<List<Map<String, dynamic>>> getClientActivities({
    required String agentId,
    required String requesterId,
  }) async {
    final response = await _client.get(
      '$_agentClientBase/agents/$agentId/activities',
      headers: {'requester-id': requesterId},
    );
    final List<dynamic> data =
        response is List ? response : (response['activities'] ?? []);
    return data.cast<Map<String, dynamic>>();
  }
}