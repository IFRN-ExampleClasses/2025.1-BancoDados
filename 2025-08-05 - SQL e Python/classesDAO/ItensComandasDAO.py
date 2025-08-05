from classesAPP.ConexaoDB import ConexaoBD
from classesAPP.ExcecoesAPP import ErroInsercao, ErroAlteracao, ErroExclusao, ErroListagem
from classesMODEL.ItensComandasMODEL import ItemComanda


class ItemComandaDAO:
    def __init__(self, conexao: ConexaoBD):
        self.conexao = conexao

    def inserir(self, item: ItemComanda):
        query = '''
            INSERT INTO barzinho.itens_comandas (id_comanda, id_produto, quantidade, preco_unitario)
            VALUES (%s, %s, %s, %s) RETURNING id_item_comanda;
        '''
        with self.conexao.conectar() as conn:
            try:
                with conn.cursor() as cur:
                    cur.execute(query, (
                        item.get_id_comanda(),
                        item.get_id_produto(),
                        item.get_quantidade(),
                        item.get_preco_unitario()
                    ))
                    id_gerado = cur.fetchone()[0]
                    item.set_id_item_comanda(id_gerado)
                    conn.commit()
                return id_gerado
            except Exception as e:
                conn.rollback()
                raise ErroInsercao(e)

    def alterar(self, item: ItemComanda):
        if item.get_id_item_comanda() is None:
            raise ValueError('É necessário fornecer o id_item_comanda para alterar.')
        query = '''
            UPDATE barzinho.itens_comandas
            SET id_comanda = %s, id_produto = %s, quantidade = %s, preco_unitario = %s
            WHERE id_item_comanda = %s;
        '''
        with self.conexao.conectar() as conn:
            try:
                with conn.cursor() as cur:
                    cur.execute(query, (
                        item.get_id_comanda(),
                        item.get_id_produto(),
                        item.get_quantidade(),
                        item.get_preco_unitario(),
                        item.get_id_item_comanda()
                    ))
                    conn.commit()
            except Exception as e:
                conn.rollback()
                raise ErroAlteracao(e)

    def excluir(self, id_item_comanda: int):
        query = 'DELETE FROM barzinho.itens_comandas WHERE id_item_comanda = %s;'
        with self.conexao.conectar() as conn:
            try:
                with conn.cursor() as cur:
                    cur.execute(query, (id_item_comanda,))
                    conn.commit()
            except Exception as e:
                conn.rollback()
                raise ErroExclusao(e)

    def listar(self):
        query = '''
            SELECT id_item_comanda, id_comanda, id_produto, quantidade, preco_unitario
            FROM barzinho.itens_comandas ORDER BY id_item_comanda;
        '''
        itens = []
        with self.conexao.conectar() as conn:
            try:
                with conn.cursor() as cur:
                    cur.execute(query)
                    for row in cur.fetchall():
                        item = ItemComanda()
                        item.set_id_item_comanda(row[0])
                        item.set_id_comanda(row[1])
                        item.set_id_produto(row[2])
                        item.set_quantidade(row[3])
                        item.set_preco_unitario(row[4])
                        itens.append(item)
                return itens
            except Exception as e:
                raise ErroListagem(e)
 