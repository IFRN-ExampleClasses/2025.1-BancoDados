class Garcom:
    def __init__(self, cpf_garcom=None, nome_garcom=None):
        self.__cpf_garcom = cpf_garcom
        self.__nome_garcom = nome_garcom

    def get_cpf_garcom(self):
        return self.__cpf_garcom

    def set_cpf_garcom(self, cpf):
        if cpf is not None and len(cpf) == 11:
            self.__cpf_garcom = cpf
        else:
            raise ValueError('CPF deve ter 11 caracteres.')

    def get_nome_garcom(self):
        return self.__nome_garcom

    def set_nome_garcom(self, nome):
        if nome is not None and len(nome) <= 50:
            self.__nome_garcom = nome
        else:
            raise ValueError('Nome do garçom deve ter até 50 caracteres.')
