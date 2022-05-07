import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_template/model/use_cases/auth/auth_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../repositories/firebase_auth/firebase_auth_repository.dart';

final userDeleteProvider = Provider((ref) => UserDelete(ref.read));

class UserDelete {
  UserDelete(this._read);
  final Reader _read;

  Future<void> call(User user) async {
    /// Firestoreのサインアウト・認証情報削除前にStreamProvider経由のlistenを解除するため
    /// authStateProviderのstateを変更する cloud_firestore/permission-denied対策
    _read(authProvider.state).update((state) => AuthState.noSignIn);
    await _read(firebaseAuthRepositoryProvider).userDelete(user);
  }
}
