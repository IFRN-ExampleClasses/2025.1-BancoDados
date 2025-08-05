class Comanda:
    def __init__(self, id_comanda=None, data_abertura=None, data_fechamento=None, preco_unitario=None, numero_mesa=None, cpf_garcom=None):
        self.__id_comanda = id_comanda
        self.__data_abertura = data_abertura
        self.__data_fechamento = data_fechamento
        self.__preco_unitario = preco_unitario
        self.__numero_mesa = numero_mesa
        self.__cpf_garcom = cpf_garcom

    def get_id_comanda(self):
        return self.__id_comanda

    def set_id_comanda(self, idc):
        self.__id_comanda = idc

    def get_data_abertura(self):
        return self.__data_abertura

    def set_data_abertura(self, data):
        self.__data_abertura = data

    def get_data_fechamento(self):
        return self.__data_fechamento

    def set_data_fechamento(self, data):
        self.__data_fechamento = data

    def get_preco_unitario(self):
        return self.__preco_unitario

    def set_preco_unitario(self, preco):
        self.__preco_unitario = preco

    def get_numero_mesa(self):
        return self.__numero_mesa

    def set_numero_mesa(self, numero):
        self.__numero_mesa = numero

    def get_cpf_garcom(self):
        return self.__cpf_garcom

    def set_cpf_garcom(self, cpf):
        self.__cpf_garcom = cpf
