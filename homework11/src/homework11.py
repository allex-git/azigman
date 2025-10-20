print("\nHomework 11\n")

enLetters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

class Alphabet:
    def __init__(self, lang, letters):
        self.lang = lang
        self.letters = letters
    
    def print_alphabet(self):
        print(self.letters)
    
    def letters_num(self):          
        return len(self.letters)

class EngAlphabet(Alphabet):
    _letters_num = 26

    def __init__(self):
        stringList = "".join(enLetters)
        Alphabet.__init__(self, "En", stringList)

    def is_en_letter(self, letter):
        for i in enLetters:
            if letter.upper() == i:
                return True
        return False

    def letters_num(self):          
        return self._letters_num

    @staticmethod
    def example():
        return "This is an example of text in English."

eng = EngAlphabet()
print("Language:", eng.lang)
eng.print_alphabet()
print("Number of letters:", eng.letters_num())
print("Is <F> part of the English alphabet?", eng.is_en_letter("F"))
print("Is <Щ> part of the English alphabet?", eng.is_en_letter("Щ"))
print("Text example:", EngAlphabet.example())
