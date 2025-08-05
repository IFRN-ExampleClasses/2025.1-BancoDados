from classesAPP.ConexaoDB import ConexaoBD
from classesAPP.ExcecoesAPP import ErroInsercao, ErroAlteracao, ErroExclusao, ErroListagem
from classesMODEL.GarconsMODEL import Garcom


class GarcomDAO:
    def __init__(self, conexao: ConexaoBD):
        self.conexao = conexao

    def inserir(self, garcom: Garcom):
        query = 'INSERT INTO barzinho.garcons (cpf_garcom, nome_garcom) VALUES (%s, %s);'
        with self.conexao.conectar() as conn:
            try:
                with conn.cursor() as cur:
                    cur.execute(query, (garcom.get_cpf_garcom(), garcom.get_nome_garcom()))
                    conn.commit()
            except Exception as e:
                conn.rollback()
                raise ErroInsercao(e)

    def alterar(self, garcom: Garcom):
        if garcom.get_cpf_garcom() is None:
            raise ValueError('É necessário fornecer o cpf_garcom para alterar.')
        query = 'UPDATE barzinho.garcons SET nome_garcom = %s WHERE cpf_garcom = %s;'
        with self.conexao.conectar() as conn:
            try:
                with conn.cursor() as cur:
                    cur.execute(query, (garcom.get_nome_garcom(), garcom.get_cpf_garcom()))
                    conn.commit()
            except Exception as e:
                conn.rollback()
                raise ErroAlteracao(e)

    def excluir(self, cpf_garcom: str):
        query = 'DELETE FROM barzinho.garcons WHERE cpf_garcom = %s;'
        with self.conexao.conectar() as conn:
            try:
                with conn.cursor() as cur:
                    cur.execute(query, (cpf_garcom,))
                    conn.commit()
            except Exception as e:
                conn.rollback()
                raise ErroExclusao(e)

    def listar(self):
        query = 'SELECT cpf_garcom, nome_garcom FROM barzinho.garcons ORDER BY nome_garcom;'
        garcons = []
        with self.conexao.conectar() as conn:
            try:
                with conn.cursor() as cur:
                    cur.execute(query)
                    for row in conn.fetchall():
                        garcom = Garcom()
                        garcom.set_cpf_garcom(row[0])
                        garcom.set_nome_garcom(row[1])
                        garcons.append(garcom)
                return garcons
            except Exception as e:
                raise ErroListagem(e)
