enum Role { none, keer, biker }

extension RoleExtension on Role {
  /// Convert [role] to enum
  ///
  /// Author: TamNTT
  Role getRoleEnum(String role) {
    switch (role) {
      case 'Role.keer':
        return Role.keer;
      case 'Role.biker':
        return Role.biker;
      default:
        return Role.none;
    }
  }
}
