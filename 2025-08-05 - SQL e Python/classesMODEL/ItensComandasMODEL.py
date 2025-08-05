class ItemComanda:
    def __init__(self, id_item_comanda=None, id_comanda=None, id_produto=None, quantidade=None, preco_unitario=None):
        self.__id_item_comanda = id_item_comanda
        self.__id_comanda = id_comanda
        self.__id_produto = id_produto
        self.__quantidade = quantidade
        self.__preco_unitario = preco_unitario

    def get_id_item_comanda(self):
        return self.__id_item_comanda

    def set_id_item_comanda(self, idi):
        self.__id_item_comanda = idi

    def get_id_comanda(self):
        return self.__id_comanda

    def set_id_comanda(self, idc):
        self.__id_comanda = idc

    def get_id_produto(self):
        return self.__id_produto

    def set_id_produto(self, idp):
        self.__id_produto = idp

    def get_quantidade(self):
        return self.__quantidade

    def set_quantidade(self, qtd):
        if qtd is None or (isinstance(qtd, int) and qtd > 0):
            self.__quantidade = qtd
        else:
            raise ValueError('Quantidade deve ser um inteiro positivo.')

    def get_preco_unitario(self):
        return self.__preco_unitario

    def set_preco_unitario(self, preco):
        if preco is None or preco >= 0:
            self.__preco_unitario = preco
        else:
            raise ValueError('Preço unitário deve ser maior ou igual a zero.')
