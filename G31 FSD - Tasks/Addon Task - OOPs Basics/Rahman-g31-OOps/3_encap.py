
#  ENCAPSULATION = is the OOP principle of bundling data #                  (variables) and methods (functions) together #                  inside a class and restricting direct access #                  to some of the object's data.

#  and why is it important?

#  Encapsulation is the process of combining data and methods # #  into a single class while hiding the internal data from #  # #  direct access and allowing controlled access through methods.



class BankAccount:
    def __init__(self, balance):
        self.__balance = balance   

    def deposit(self, amount):
        self.__balance += amount

    def get_balance(self):
        return self.__balance


account = BankAccount(1000)

account.deposit(500)

print(account.get_balance())  # 1500
