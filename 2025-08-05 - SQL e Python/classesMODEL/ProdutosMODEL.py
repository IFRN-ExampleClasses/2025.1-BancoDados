class Produto:
    def __init__(self, id_produto=None, nome_produto=None, preco_unitario=None, id_categoria=None):
        self.__id_produto = id_produto
        self.__nome_produto = nome_produto
        self.__preco_unitario = preco_unitario
        self.__id_categoria = id_categoria

    def get_id_produto(self):
        return self.__id_produto

    def set_id_produto(self, idp):
        self.__id_produto = idp

    def get_nome_produto(self):
        return self.__nome_produto

    def set_nome_produto(self, nome):
        if nome is not None and len(nome) <= 80:
            self.__nome_produto = nome
        else:
            raise ValueError('Nome do produto deve ter até 80 caracteres.')

    def get_preco_unitario(self):
        return self.__preco_unitario

    def set_preco_unitario(self, preco):
        if preco is None or preco >= 0:
            self.__preco_unitario = preco
        else:
            raise ValueError('Preço unitário deve ser maior ou igual a zero.')

    def get_id_categoria(self):
        return self.__id_categoria

    def set_id_categoria(self, idc):
        self.__id_categoria = idc
