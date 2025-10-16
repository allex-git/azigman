import random

def randomNumber():
    randomNumber = random.randint(1,100)
    #print(randomNumber)
    attempt = 0
    print("\nHomework 10\n")
    while attempt <= 5:   
        try:
            userNumber = int(input("\nВгадай число від 1 до 100. Ваше число: "))
            if 1<= userNumber <= 100:
                if userNumber == randomNumber:
                    print("\nВітаємо! Ви вгадали число\n")
                    return
                elif userNumber < randomNumber:
                    print("\nЗанадто низько")
                else:
                    print("\nЗанадто високо") 
            else:
                print("\nТреба вказати число від 1 до 100")
        
        except ValueError:
            print("\nВведіть число!")

        attempt += 1

    print("\nВибачте, у вас закінчилися спроби\n")
    print("Вибачте, у вас закінчилися спроби. Правильнее число", randomNumber, "\n")

randomNumber()