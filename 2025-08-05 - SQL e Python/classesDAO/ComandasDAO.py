from classesAPP.ConexaoDB import ConexaoBD
from classesAPP.ExcecoesAPP import ErroInsercao, ErroAlteracao, ErroExclusao, ErroListagem
from classesMODEL.ComandasMODEL import Comanda

class ComandaDAO:
    def __init__(self, conexao: ConexaoBD):
        self.conexao = conexao

    def inserir(self, comanda: Comanda):
        query = '''
            INSERT INTO barzinho.comandas (data_abertura, data_fechamento, preco_unitario, numero_mesa, cpf_garcom)
            VALUES (%s, %s, %s, %s, %s) RETURNING id_comanda;
        '''
        with self.conexao.conectar() as conn:
            try:
                with conn.cursor() as cur:
                    cur.execute(query, (
                        comanda.get_data_abertura(),
                        comanda.get_data_fechamento(),
                        comanda.get_preco_unitario(),
                        comanda.get_numero_mesa(),
                        comanda.get_cpf_garcom()
                    ))
                    id_gerado = cur.fetchone()[0]
                    comanda.set_id_comanda(id_gerado)
                    conn.commit()
                return id_gerado
            except Exception as e:
                conn.rollback()
                raise ErroInsercao(e)

    def alterar(self, comanda: Comanda):
        if comanda.get_id_comanda() is None:
            raise ValueError('É necessário fornecer o id_comanda para alterar.')
        query = '''
            UPDATE barzinho.comandas
            SET data_abertura = %s, data_fechamento = %s, preco_unitario = %s, numero_mesa = %s, cpf_garcom = %s
            WHERE id_comanda = %s;
        '''
        with self.conexao.conectar() as conn:
            try:
                with conn.cursor() as cur:
                    cur.execute(query, (
                        comanda.get_data_abertura(),
                        comanda.get_data_fechamento(),
                        comanda.get_preco_unitario(),
                        comanda.get_numero_mesa(),
                        comanda.get_cpf_garcom(),
                        comanda.get_id_comanda()
                    ))
                    conn.commit()
            except Exception as e:
                conn.rollback()
                raise ErroAlteracao(e)

    def excluir(self, id_comanda: int):
        query = 'DELETE FROM barzinho.comandas WHERE id_comanda = %s;'
        with self.conexao.conectar() as conn:
            try:
                with conn.cursor() as cur:
                    cur.execute(query, (id_comanda,))
                    conn.commit()
            except Exception as e:
                conn.rollback()
                raise ErroExclusao(e)

    def listar(self):
        query = '''
            SELECT id_comanda, data_abertura, data_fechamento, preco_unitario, numero_mesa, cpf_garcom
            FROM barzinho.comandas ORDER BY id_comanda;
        '''
        comandas = []
        with self.conexao.conectar() as conn:
            try:
                with conn.cursor() as cur:
                    cur.execute(query)
                    for row in cur.fetchall():
                        comanda = Comanda()
                        comanda.set_id_comanda(row[0])
                        comanda.set_data_abertura(row[1])
                        comanda.set_data_fechamento(row[2])
                        comanda.set_preco_unitario(row[3])
                        comanda.set_numero_mesa(row[4])
                        comanda.set_cpf_garcom(row[5])
                        comandas.append(comanda)
                return comandas
            except Exception as e:
                raise ErroListagem(e)
