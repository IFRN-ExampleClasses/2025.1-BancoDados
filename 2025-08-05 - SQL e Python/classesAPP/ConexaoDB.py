import psycopg2
from psycopg2 import OperationalError
from contextlib import contextmanager
from ExcecoesAPP import ErroConexao

class ConexaoBD:
    def __init__(self, host='localhost', database='barzinho', user='seu_usuario', password='sua_senha', port=5432):
        self.host = host
        self.database = database
        self.user = user
        self.password = password
        self.port = port

    @contextmanager
    def conectar(self):
        conn = None
        try:
            conn = psycopg2.connect(
                host=self.host,
                database=self.database,
                user=self.user,
                password=self.password,
                port=self.port
            )
            yield conn
        except OperationalError as e:
            raise ErroConexao(f'Erro ao conectar ao banco de dados: {e}')
        finally:
            if conn is not None:
                conn.close()
