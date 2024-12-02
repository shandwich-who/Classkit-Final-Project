String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email cannot be empty';
  }
  value = value.trim();
  if (value.length > 254) {
    return 'Email is too long (maximum 254 characters)';
  }
  final RegExp emailRegExp =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  if (!emailRegExp.hasMatch(value)) {
    return 'Please enter a valid email address (e.g., example@domain.com)';
  }
  if (value.contains(' ')) {
    return 'Email cannot contain spaces';
  }
  if (value.contains('..') || value.contains('@@')) {
    return 'Email cannot contain consecutive special characters';
  }
  if (value.startsWith(RegExp(r'[^a-zA-Z0-9]'))) {
    return 'Email cannot start with a special character';
  }
  if (!value.contains('.') || value.split('.').last.isEmpty) {
    return 'Email domain must include a dot (e.g., .com, .org)';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password cannot be empty';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  final RegExp upperCaseRegExp = RegExp(r'(?=.*[A-Z])');
  final RegExp lowerCaseRegExp = RegExp(r'(?=.*[a-z])');
  final RegExp digitRegExp = RegExp(r'(?=.*\d)');
  final RegExp specialCharRegExp = RegExp(r'(?=.*[@#$%^&+=])');
  if (!upperCaseRegExp.hasMatch(value)) {
    return 'Password must contain at least one uppercase letter';
  }
  if (!lowerCaseRegExp.hasMatch(value)) {
    return 'Password must contain at least one lowercase letter';
  }
  if (!digitRegExp.hasMatch(value)) {
    return 'Password must contain at least one number';
  }
  if (!specialCharRegExp.hasMatch(value)) {
    return 'Password must contain at least one special character (e.g., @, #, \$, %, etc.)';
  }
  return null;
}

String? validateId(String? value) {
  if (value == null || value.isEmpty) {
    return "ID is required";
  }
  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
    return "ID must be numeric";
  }
  return null;
}

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return "Name is required";
  }
  if (value.length < 3) {
    return "Name must be at least 3 characters long";
  }
  return null;
}

String? validatePrice(String? value) {
  if (value == null || value.isEmpty) {
    return "Price is required";
  }
  if (double.tryParse(value) == null) {
    return "Enter a valid price";
  }
  if (double.parse(value) <= 0) {
    return "Price must be greater than 0";
  }
  return null;
}

String? validateQuantity(String? value) {
  if (value == null || value.isEmpty) {
    return "Quantity is required";
  }
  if (int.tryParse(value) == null) {
    return "Enter a valid quantity";
  }
  if (int.parse(value) <= 0) {
    return "Quantity must be greater than 0";
  }
  return null;
}
