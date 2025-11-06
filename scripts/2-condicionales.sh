#!/bin/bash

# Condicionales

# En ocasiones, en los scripts que hagamos no queremos que todas las líneas se ejecuten siempre.
# En base a opciones que elija el usuario o a situaciones que vayamos detectando, querremos que se 
# ejecuten unas líneas u otras.
# Para eso usamos las estructuras condicionales: if / elif / else

#  if CONDICION1; then
#      LINEAS DE CÓDIGO que deben ejecutarse SI SE CUMPLE LA CONDICIÓN1
#  elif CONDICION2; then
#      LINEAS DE CÓDIGO que deben ejecutarse SI SE CUMPLE LA CONDICIÓN2
#  else
#      LINEAS DE CÓDIGO que deben ejecutarse SI NO SE CUMPLE NINGUNA CONDICIÓN ANTERIOR
#  fi   

# CONDICIONES
# Podemos usar operadores en las condiciones para comparar valores. SE APLICAN SOBRE TEXTOS... Es preciso escribir la condición entre [[ ]]
    #           ==     Compara 2 textos a ver si son iguales
    #           !=     Compara 2 textos a ver si son diferentes
    #           >      Compara 2 textos a ver si el primero es mayor que el segundo (orden alfabético)
    #           <      Compara 2 textos a ver si el primero es menor que el segundo
    #           >=     Compara 2 textos a ver si el primero es mayor o igual que el segundo
    #           <=     Compara 2 textos a ver si el primero es menor o igual que
    #           -z "$VARIABLE"       Comprueba si la variable está vacía (length = 0)
    #           -n "$VARIABLE"       Comprueba si la variable NO está vacía (length > 0)
    #           -v "$VARIABLE"       Comprueba si la variable está definida (tiene algún valor asignado)

# Cuando trabajamos con números, usamos otros operadores... y otra sintaxis . En este caso la condición se escribe entre (( ))
    #           ==    Compara 2 números a ver si son iguales
    #           !=    Compara 2 números a ver si son diferentes
    #           >     Compara 2 números a ver si el primero es mayor que el segundo
    #           <     Compara 2 números a ver si el primero es menor que el segundo
    #           >=    Compara 2 números a ver si el primero es mayor o igual que el segundo
    #           <=    Compara 2 números a ver si el primero es menor o igual que el segundo


numero1=10
numero2=010  # 010 es octal, equivale a 8 en decimal
numero3=5

if [[ "$numero1" == "$numero2" ]]; then
    echo "El texto de numero1 es igual al texto de numero2"
else
    echo "El texto de numero1 es diferente al texto de numero2"  # "10" != "010" como texto
fi


if (( $numero1 == $numero2 )); then
    echo "El valor de numero1 es igual al valor de numero2"
else
    echo "El valor de numero1 es diferente al valor de numero2"  # 10 != 8 (010 octal = 8 decimal)
fi

echo "A continuación vamos a formatear su disco duro."
read -p "¿Está seguro de que quiere continuar? (s/n): " -n 1 respuesta
echo

if [[ "$respuesta" == "s" || "$respuesta" == "S" ]]; then        # El       || significa "o"          && significa "y"
    echo "Formateando disco duro..."
    # Aquí irían las órdenes para formatear el disco duro
else
    echo "Operación cancelada. No se ha formateado el disco duro."
fi


# Expresiones regulares
# Me permiten verificar si un texto cumple o no con un patrón
# Lo que hacemos es establecer un patrón usando una sintaxis que se ideó en el lenguaje de programación Perl.
# En bash, para usar expresiones regulares en condicionales, usamos el operador =~
# Ejemplo:
read -p "Introduce un número de 3 dígitos: " numero_usuario
if [[ "$numero_usuario" =~ ^[0-9]{3}$ ]]; then
    echo "El número $numero_usuario es correcto."
else
    echo "El número $numero_usuario NO es correcto."
fi