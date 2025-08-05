from classesAPP.ConexaoDB import ConexaoBD
from classesAPP.ExcecoesAPP import * 
from classesMODEL import Produto
from classesDAO import ProdutoDAO

def main():
    conexao = ConexaoBD(user='seu_usuario', password='sua_senha')
    dao = ProdutoDAO(conexao)

    try:
        prod = Produto(nome_produto='Cerveja', preco_unitario=5.50, id_categoria=1)
        id_novo = dao.inserir(prod)
        print(f'Produto inserido com id: {id_novo}')

        lista = dao.listar()
        for p in lista:
            print(f'{p.get_id_produto()} - {p.get_nome_produto()} - R${p.get_preco_unitario()}')

        prod.set_nome_produto('Cerveja Gelada')
        dao.alterar(prod)
        print('Produto alterado.')

        dao.excluir(prod.get_id_produto())
        print('Produto excluído.')

    except (ErroInsercao, ErroAlteracao, ErroExclusao, ErroListagem, ErroConexao) as e:
        print(f'Erro: {e}')

if __name__ == '__main__':
    main()
