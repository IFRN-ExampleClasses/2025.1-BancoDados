from classesAPP.ConexaoDB import ConexaoBD
from classesAPP.ExcecoesAPP import ErroInsercao, ErroAlteracao, ErroExclusao, ErroListagem
from classesMODEL.CategoriasProdutosMODEL import CategoriaProduto

class CategoriaProdutoDAO:
    def __init__(self, conexao: ConexaoBD):
        self.conexao = conexao

    def inserir(self, categoria: CategoriaProduto):
        query = 'INSERT INTO barzinho.categorias_produtos (descricao) VALUES (%s) RETURNING id_categoria;'
        with self.conexao.conectar() as conn:
            try:
                with conn.cursor() as cur:
                    cur.execute(query, (categoria.get_descricao(),))
                    id_gerado = cur.fetchone()[0]
                    categoria.set_id_categoria(id_gerado)
                    conn.commit()
                return id_gerado
            except Exception as e:
                conn.rollback()
                raise ErroInsercao(e)

    def alterar(self, categoria: CategoriaProduto):
        if categoria.get_id_categoria() is None:
            raise ValueError('É necessário fornecer o id_categoria para alterar.')
        query = 'UPDATE barzinho.categorias_produtos SET descricao = %s WHERE id_categoria = %s;'
        with self.conexao.conectar() as conn:
            try:
                with conn.cursor() as cur:
                    cur.execute(query, (categoria.get_descricao(), categoria.get_id_categoria()))
                    conn.commit()
            except Exception as e:
                conn.rollback()
                raise ErroAlteracao(e)

    def excluir(self, id_categoria: int):
        query = 'DELETE FROM barzinho.categorias_produtos WHERE id_categoria = %s;'
        with self.conexao.conectar() as conn:
            try:
                with conn.cursor() as cur:
                    cur.execute(query, (id_categoria,))
                    conn.commit()
            except Exception as e:
                conn.rollback()
                raise ErroExclusao(e)

    def listar(self):
        query = 'SELECT id_categoria, descricao FROM barzinho.categorias_produtos ORDER BY id_categoria;'
        categorias = []
        with self.conexao.conectar() as conn:
            try:
                with conn.cursor() as cur:
                    cur.execute(query)
                    for row in cur.fetchall():
                        cat = CategoriaProduto()
                        cat.set_id_categoria(row[0])
                        cat.set_descricao(row[1])
                        categorias.append(cat)
                return categorias
            except Exception as e:
                raise ErroListagem(e)
