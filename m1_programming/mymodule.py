
class Calculator:
    def __init__(self):
        pass
    def sum(self,a,b):
        return a+b
    def sub(self,a,b):
        return a-b
    def mul(self,a,b):
        return a*b
    def div(self,a,b):
        if a == 0 or b == 0:
            return "나눗셈에 0을 포함시킬 수 없습니다."
        else:
            return a/b   
