temperatura = float(input("Digite a temperatura da máquina: ")) 
 
if temperatura > 79: 
    print(" Alerta! Máquina superaquecendo. Desligar imediatamente.") 
elif temperatura >= 60: 
    print(" Atenção! Máquina em alta temperatura, monitorar.") 
else: 
    print(" Temperatura dentro do limite seguro.")
