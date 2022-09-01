String? emailValidator(email) {
    if (email == null || email.isEmpty) {
      return 'Digite seu E-mail!';
    }

    // if (!email.isEmail) {
    //   return 'Digite um E-mail válido!';
    // }
 
    return null;
}

String? passwordValidator(password) { 
    if (password == null || password.isEmpty) {
      return 'Digite sua senha!';
    }

    if (password.length < 7) {
      return 'Digite uma senha com mais de 7 caracteres!';
    }

    return null;                  
}

String? nameValidator(name) { 
    if (name == null || name.isEmpty) {
      return 'Digite seu nome!';
    }

    final names = name.split(' ');

    if (names.length == 1) {
      return 'Digite seu nome completo!';
    }

    return null;                  
}

String? phoneValidator(phone) { 
    if (phone == null || phone.isEmpty) {
      return 'Digite o número do celular!';
    }

    // if(!phone.isPhoneNumber || phone.length < 14) {
    //   return 'Digite um número válido';  
    // }

    return null;                  
}

String? cpfValidator(cpf) { 
    if (cpf == null || cpf.isEmpty) {
      return 'Digite o CPF!';
    }

    // if(!cpf.isCpf) {
    //   return 'Digite um CPF válido';  
    // }

    return null;                  
}