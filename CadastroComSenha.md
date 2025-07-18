Objetivo do Exercício:

    Permitir que o usuário se registre com nome, idade e senha, e que apenas ele possa editar/excluir seus próprios dados. O admin continua podendo visualizar todos os dados.

    ✅ Lógica:

    registrar: nome, idade, senha (armazenada com hash)

    editar: apenas se o msg.sender for o dono e a senha estiver correta

    excluir: idem

    Admin pode listar usuários, mas não editar

    Observações:

    A senha é armazenada como hash com keccak256, igual o Remix mostra nos logs.

    O contrato não tem recuperação de senha (isso exigiria um sistema off-chain).

    Segurança básica para um sistema local ou didático. Não é recomendável para produção real ainda.

    
