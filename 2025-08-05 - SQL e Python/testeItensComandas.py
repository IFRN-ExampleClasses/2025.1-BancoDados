from classesAPP.ConexaoDB import ConexaoBD
from classesAPP.ExcecoesAPP import *
from classesMODEL import ItemComanda
from classesDAO import ItemComandaDAO

def main():
    conexao = ConexaoBD(user='seu_usuario', password='sua_senha')
    dao = ItemComandaDAO(conexao)

    try:
        item = ItemComanda(id_comanda=1, id_produto=1, quantidade=2, preco_unitario=10.0)
        id_novo = dao.inserir(item)
        print(f'Item de comanda inserido com id: {id_novo}')

        lista = dao.listar()
        for i in lista:
            print(f'ID: {i.get_id_item_comanda()}, Produto: {i.get_id_produto()}, Quantidade: {i.get_quantidade()}')

        item.set_quantidade(5)
        dao.alterar(item)
        print('Item de comanda alterado.')

        dao.excluir(item.get_id_item_comanda())
        print('Item de comanda excluído.')

    except (ErroInsercao, ErroAlteracao, ErroExclusao, ErroListagem, ErroConexao) as e:
        print(f'Erro: {e}')

if __name__ == '__main__':
    main()
