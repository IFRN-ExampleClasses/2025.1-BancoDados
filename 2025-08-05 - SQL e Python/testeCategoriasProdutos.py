from classesAPP.ConexaoDB import ConexaoBD
from classesAPP.ExcecoesAPP import *
from classesMODEL import CategoriaProduto
from classesDAO import CategoriaProdutoDAO

def main():
    conexao = ConexaoBD(user='seu_usuario', password='sua_senha')
    dao = CategoriaProdutoDAO(conexao)

    try:
        # Inserir
        cat = CategoriaProduto(descricao='Bebidas')
        id_novo = dao.inserir(cat)
        print(f'Inserido categoria id: {id_novo}')

        # Listar
        lista = dao.listar()
        for c in lista:
            print(f'{c.get_id_categoria()} - {c.get_descricao()}')

        # Alterar
        cat.set_descricao('Bebidas Alteradas')
        dao.alterar(cat)
        print('Categoria alterada.')

        # Excluir
        dao.excluir(cat.get_id_categoria())
        print('Categoria excluída.')

    except (ErroInsercao, ErroAlteracao, ErroExclusao, ErroListagem, ErroConexao) as e:
        print(f'Erro: {e}')

if __name__ == '__main__':
    main()
