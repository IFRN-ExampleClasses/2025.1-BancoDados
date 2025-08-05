from classesAPP.ConexaoDB import ConexaoBD
from classesAPP.ExcecoesAPP import *
from classesMODEL import Garcom
from classesDAO import GarcomDAO

# ----------------------------------------------------------------------
# Função principal
def main():
    connDB = ConexaoBD(user='seu_usuario', password='sua_senha')
    daoGarcom = GarcomDAO(connDB)

    try:
        objGacom = Garcom(cpf_garcom='12345678901', nome_garcom='João Silva')
        daoGarcom.inserir(objGacom)
        print('Garçom inserido.')

        lista = daoGarcom.listar()
        for g in lista:
            print(f'{g.get_cpf_garcom()} - {g.get_nome_garcom()}')

        objGacom.set_nome_garcom('João Silva Alterado')
        daoGarcom.alterar(objGacom)
        print('Garçom alterado.')

        daoGarcom.excluir(objGacom.get_cpf_garcom())
        print('Garçom excluído.')

    except (ErroInsercao, ErroAlteracao, ErroExclusao, ErroListagem, ErroConexao) as e:
        print(f'Erro: {e}')

if __name__ == '__main__':
    main()
