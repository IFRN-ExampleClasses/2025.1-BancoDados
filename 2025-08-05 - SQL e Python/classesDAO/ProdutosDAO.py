from classesAPP.ConexaoDB import ConexaoBD
from classesAPP.ExcecoesAPP import ErroInsercao, ErroAlteracao, ErroExclusao, ErroListagem
from classesMODEL.ProdutosMODEL import Produto

class ProdutoDAO:
    def __init__(self, conexao: ConexaoBD):
        self.conexao = conexao

    def inserir(self, produto: Produto):
        query = '''
            INSERT INTO barzinho.produtos (nome_produto, preco_unitario, id_categoria)
            VALUES (%s, %s, %s) RETURNING id_produto;
        '''
        with self.conexao.conectar() as conn:
            try:
                with conn.cursor() as cur:
                    cur.execute(query, (
                        produto.get_nome_produto(),
                        produto.get_preco_unitario(),
                        produto.get_id_categoria()
                    ))
                    id_gerado = cur.fetchone()[0]
                    produto.set_id_produto(id_gerado)
                    conn.commit()
                return id_gerado
            except Exception as e:
                conn.rollback()
                raise ErroInsercao(e)

    def alterar(self, produto: Produto):
        if produto.get_id_produto() is None:
            raise ValueError('É necessário fornecer o id_produto para alterar.')
        query = '''
            UPDATE barzinho.produtos
            SET nome_produto = %s, preco_unitario = %s, id_categoria = %s
            WHERE id_produto = %s;
        '''
        with self.conexao.conectar() as conn:
            try:
                with conn.cursor() as cur:
                    cur.execute(query, (
                        produto.get_nome_produto(),
                        produto.get_preco_unitario(),
                        produto.get_id_categoria(),
                        produto.get_id_produto()
                    ))
                    conn.commit()
            except Exception as e:
                conn.rollback()
                raise ErroAlteracao(e)

    def excluir(self, id_produto: int):
        query = 'DELETE FROM barzinho.produtos WHERE id_produto = %s;'
        with self.conexao.conectar() as conn:
            try:
                with conn.cursor() as cur:
                    cur.execute(query, (id_produto,))
                    conn.commit()
            except Exception as e:
                conn.rollback()
                raise ErroExclusao(e)

    def listar(self):
        query = 'SELECT id_produto, nome_produto, preco_unitario, id_categoria FROM barzinho.produtos ORDER BY nome_produto;'
        produtos = []
        with self.conexao.conectar() as conn:
            try:
                with conn.cursor() as cur:
                    cur.execute(query)
                    for row in cur.fetchall():
                        produto = Produto()
                        produto.set_id_produto(row[0])
                        produto.set_nome_produto(row[1])
                        produto.set_preco_unitario(row[2])
                        produto.set_id_categoria(row[3])
                        produtos.append(produto)
                return produtos
            except Exception as e:
                raise ErroListagem(e)
