enum Role { none, keer, biker }

extension RoleExtension on Role {
  /// Convert [role] to integer
  ///
  /// Author: TamNTT
  int getRoleNum(Role role) {
    switch (role) {
      case Role.keer:
        return 1;
      case Role.biker:
        return 2;
      default:
        return -1;
    }
  }
}
