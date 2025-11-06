#!/bin/bash
# Una variable especial que podemos usar en bash es la variable $RANDOM.
# Cada vez que usamos esa variable, la bash nos devuelve un número aleatorio entre 0 y 32767.

# Vamos a hacer que la computadora piense un número del 0 al 20
# Lo que podemos hacer con un poco de ingenio es dividir el número que nos devuelva $RANDOM entre 21


#    21007 | 21
#          +-------
#        7   100
#        ^^
#        RESTO DE LA DIVISION ENTERA... entre qué valores está al dividir entre 21? 0-20

let numero_imaginado_por_el_computador=$RANDOM%21

echo "¡He pensado un número entre 0 y 20! A ver si eres capaz de adivinarlo."
oportunidades=3

while (( oportunidades > 0 )); do
    read -p "Introduce tu apuesta: " intento_usuario

    if (( intento_usuario == numero_imaginado_por_el_computador )); then
        echo "¡Enhorabuena! ¡Has adivinado el número!"
        exit 0   # Salimos del script con código de éxito
    else
        let oportunidades=oportunidades-1

        # Necesitamos calcular a cúanto ha quedado del número objetivo con su intento. 
        # Si dijo el 7 y es el 5 -> se pasó 2 = 7-5
        # Si dijo el 3 y es el 5 -> se quedó corto -2 = 3-5
        # Nos da igual si quedó por encima o por debajo.
        # Solo queremos saber si quedó cerca o lejos... cómo de cerca o de lejos quedó.
        let diferencia=$intento_usuario-$numero_imaginado_por_el_computador
        abs_diferencia=${diferencia#-}  # Esto eliminará el signo
        if (( abs_diferencia == 1 )); then
            echo "¡Casi lo tienes! Muy caliente."
        elif (( abs_diferencia == 2 )); then
            echo "Aiiii! Caliente"
        elif (( abs_diferencia <= 4 )); then
            echo "Templado, templado!."
        elif (( abs_diferencia <= 6 )); then
            echo "Ufff! Frio!."
        else
            echo "Nada.. tas helao!"
        fi
        echo "Te quedan $oportunidades oportunidades."
    fi
done

echo "Lo siento, no has adivinado el número. El número era: $numero_imaginado_por_el_computador"

# Propuesta: Convertir este juego en el juego FRIO CALIENTE!
# Si el número del usuarios dista más de 5 unidades del número pensado, el computador le dice "MUY FRIO"
# Si el número del usuarios dista entre 3 o 4 unidades del número pensado, el computador le dice "FRIO"
# Si el número del usuarios dista entre 2 unidades del número pensado, el computador le dice "TEMPLADO"
# Si el número del usuarios dista 1 unidad del número pensado, el computador le dice "CALIENTE"

# Para hacer esto... es posible que necesiteis calcular el valor absoluto de un número
# En la bash la forma más fácil de hacerlo es con una sintaxis que mañana os explico:
#numero=-100
#abs_numero=${numero#-}  # Esto eliminará el signo - si existe... y me quedará el valor absoluto

#echo "El valor absoluto de $numero es $abs_numero"