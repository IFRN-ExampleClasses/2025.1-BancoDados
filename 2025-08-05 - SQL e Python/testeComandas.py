from datetime import date
from classesAPP.ConexaoDB import ConexaoBD
from classesAPP.ExcecoesAPP import *
from classesMODEL import Comanda
from classesDAO import ComandaDAO

def main():
    conexao = ConexaoBD(user='seu_usuario', password='sua_senha')
    dao = ComandaDAO(conexao)

    try:
        comanda = Comanda(
            data_abertura=date.today(),
            data_fechamento=None,
            preco_unitario=100.0,
            numero_mesa=5,
            cpf_garcom='12345678901'
        )
        id_novo = dao.inserir(comanda)
        print(f'Comanda inserida com id: {id_novo}')

        lista = dao.listar()
        for c in lista:
            print(f'ID: {c.get_id_comanda()}, Mesa: {c.get_numero_mesa()}, Garçom: {c.get_cpf_garcom()}')

        comanda.set_numero_mesa(10)
        dao.alterar(comanda)
        print('Comanda alterada.')

        dao.excluir(comanda.get_id_comanda())
        print('Comanda excluída.')

    except (ErroInsercao, ErroAlteracao, ErroExclusao, ErroListagem, ErroConexao) as e:
        print(f'Erro: {e}')

if __name__ == '__main__':
    main()
