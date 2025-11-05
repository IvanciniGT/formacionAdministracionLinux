#!/bin/bash
# Hay veces que quiero que se ejecute una linea de código o no... y eso lo hacíamos con los condicionales (if/else).
# Pero en otras ocasiones puede ser que necesite que una linea de código (o un bloque) se ejecute no una sola vez, 
# sino mientras se cumpla una condición.

# Para eso usamos un bucle de tipo 'while' (mientras).

# while CONDICION; do
#     BLOQUE DE CÓDIGO QUE SE EJECUTARÁ MIENTRAS SE CUMPLA LA CONDICIÓN
# done

# Todo ese bloque se repetirá mientras la condición sea verdadera.

NUMERO=10
while (( $NUMERO > 0 )); do
    echo "El valor de NUMERO es: $NUMERO"
    let NUMERO=NUMERO-1   # Decrementamos el valor de NUMERO en 1
done

echo "¡Bucle terminado!"