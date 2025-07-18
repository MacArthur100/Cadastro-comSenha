//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CadastroComSenha {
    struct Pessoa {
        string nome;
        uint256 idade;
        bytes32 senhaHash;
    }

    mapping(address => Pessoa) public pessoas;
    mapping(address => bool) public registrado;

    address public admin;

    event UsuarioRegistrado(address usuario, string nome, uint256 idade);
    event UsuarioEditado(address usuario, string novoNome, uint256 novaIdade);
    event UsuarioExcluido(address usuario);

    modifier apenasAdmin() {
        require(msg.sender == admin, "Apenas admin pode executar");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    //Registro com senha
    function registrar(string memory _nome, uint256 _idade, string memory _senha) public {
        require(!registrado[msg.sender], "Usuario ja registrado");
        require(_idade > 0, "Idade Invalida");
        require(bytes(_senha).length >= 4, "Senha muito curta");

        pessoas[msg.sender] = Pessoa(_nome, _idade, keccak256(abi.encodePacked(_senha)));
        registrado[msg.sender] = true;

        emit UsuarioRegistrado(msg.sender, _nome, _idade);

    }

    //Edição com autenticação de senha
    function editar(string memory _novoNome, uint256 _novaIdade, string memory _senha) public {
        require(registrado[msg.sender], "Usuario nao registrado");
        require(_novaIdade > 0, "Idade invalida");
        require(pessoas[msg.sender].senhaHash == keccak256(abi.encodePacked(_senha)), "Senha incorreta");

        pessoas[msg.sender].nome = _novoNome;
        pessoas[msg.sender].idade = _novaIdade;

        emit UsuarioExcluido(msg.sender);
    }

    //Visualização de qualquer cadastro
    function verCadastro(address _usuario) public view apenasAdmin returns (string memory nome, uint256 idade) {
       require(registrado [_usuario], "Usuario nao registrado");

       Pessoa memory p = pessoas[_usuario];
       return (p.nome, p.idade); //não retorna senha

    }
}