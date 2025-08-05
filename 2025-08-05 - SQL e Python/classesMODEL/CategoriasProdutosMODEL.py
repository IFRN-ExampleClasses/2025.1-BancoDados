class CategoriaProduto:
    def __init__(self, id_categoria=None, descricao=None):
        self.__id_categoria = id_categoria
        self.__descricao = descricao

    def get_id_categoria(self):
        return self.__id_categoria

    def set_id_categoria(self, idc):
        self.__id_categoria = idc

    def get_descricao(self):
        return self.__descricao

    def set_descricao(self, desc):
        if desc is not None and len(desc) <= 40:
            self.__descricao = desc
        else:
            raise ValueError('Descrição deve ter até 40 caracteres.')
