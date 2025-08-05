class ErroConexao(Exception):
    """Exceção para erros de conexão com o banco de dados."""
    pass

class ErroInsercao(Exception):
    """Exceção para erros durante operações de inserção."""
    pass

class ErroAlteracao(Exception):
    """Exceção para erros durante operações de alteração."""
    pass

class ErroExclusao(Exception):
    """Exceção para erros durante operações de exclusão."""
    pass

class ErroListagem(Exception):
    """Exceção para erros durante operações de listagem/consulta."""
    pass
