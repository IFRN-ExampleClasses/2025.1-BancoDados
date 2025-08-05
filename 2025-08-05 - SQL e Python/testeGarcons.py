from classesAPP.ConexaoDB import ConexaoBD
from classesAPP.ExcecoesAPP import *
from classesMODEL import Garcom
from classesDAO import GarcomDAO

def main():
    conexao = ConexaoBD(user='seu_usuario', password='sua_senha')
    dao = GarcomDAO(conexao)

    try:
        garcom = Garcom(cpf_garcom='12345678901', nome_garcom='João Silva')
        dao.inserir(garcom)
        print('Garçom inserido.')

        lista = dao.listar()
        for g in lista:
            print(f'{g.get_cpf_garcom()} - {g.get_nome_garcom()}')

        garcom.set_nome_garcom('João Silva Alterado')
        dao.alterar(garcom)
        print('Garçom alterado.')

        dao.excluir(garcom.get_cpf_garcom())
        print('Garçom excluído.')

    except (ErroInsercao, ErroAlteracao, ErroExclusao, ErroListagem, ErroConexao) as e:
        print(f'Erro: {e}')

if __name__ == '__main__':
    main()
