#!/bin/bash

# Cuando creamos un script, no nos gusta que el script tenga muchas líneas de código juntas.
# Eso dificulta la lectura y el mantenimiento del código.

# Muchas veces nos interesa escribir el programa a trozos... 
# A cada uno de esos trozos le asignamos un nombre
# y cuando queramos ejecutar ese trozo de código, simplemente llamamos a ese nombre.
# A esos trozos de código los llamamos FUNCIONES.


function saludar() {
    echo "Hola! Bienvenido al curso de bash."
}

function despedirse() {
    echo "Adiós! Gracias por participar en el curso de bash."
}


saludar
#saludar
#saludar
despedirse

# Las funciones pueden recibir argumentos
# A diferencia de otros lenguajes, en bash no definimos los argumentos al crear la función.
# Lo que trabajamos en la bash es con la posición de los argumentos.
# El primer argumento que se suministra a la función se encuentra en la variable $1
# El segundo argumento en la variable $2
# Y así sucesivamente...


function saludar_a() { # Y asumo que esta función cuando la invoquen me pasarán un nombre como argumento
    echo "Hola $1! Bienvenido al curso de bash."
}


saludar_a "Iván" "Menchu"
saludar_a "Iván Menchu"

# En muchos lenguajes de programación, las funciones pueden devolver valores.
# En la bash eso no ocurre. En la bash una función devuelve el código de salida... como si fuera un proceso:
#     0 = ÉXITO
#     distinto de 0 = ERROR
# Por defecto, si no indicamos nada, la función devolverá 0 (éxito).

saludar_a "Ana"
echo "El código de salida de la función ha sido: $?"  # El símbolo $? contiene el código de salida del último comando ejecutado
# Si queremos devolver un código de salida distinto de 0, usamos la instrucción 'return' seguida del código a devolver.

function siempre_da_error() {
    echo "Esta función siempre devuelve un error."
    return 1   # Devolvemos el código de error 1
}

siempre_da_error
echo "El código de salida de la función ha sido: $?"

# En ocasiones, si me interesa que una función nos pueda devolver un valor.
# Las funciones en la bash se tratan exactamente igual que si fueran un proceso de sistema operativo.
# Las funciones pueden escribir en su salida estándar (stdout).

function doblar_numero() {
    let resultado=$1*2
    echo $resultado   # Imprimimos el resultado en la salida estándar
}

doblar_numero 5 # Con esto, veríamos el 10 impreso en pantalla

# Podría ser que ese dato (10) no lo quiera por pantalla... 
# sino que lo voy a usar por ejemplo en un condicional... y necesito tenerlo guardado en una variable.

# La salida estándar de un comando (o función) en linux la puedo capturar y guardar en una variable usando la sintaxis:
valor_doblado=$(doblar_numero 7) # Lo que hace esto es tomar la salida estándar de la función y guardarla en la variable
if (( valor_doblado > 10 )); then
    echo "El valor doblado ($valor_doblado) es mayor que 10"
else
    echo "El valor doblado ($valor_doblado) NO es mayor que 10"
fi

ficheros=$(ls -l /etc)

echo "El listado de ficheros en /etc es:"
echo "$ficheros"


# Quiero llamar a un servicio http y guardar la respuesta en una variable
# curl es una herramienta que nos permite hacer peticiones http desde la línea de comandos
# curl = client url
texto=$(curl "https://baconipsum.com/api/?type=meat-and-filler")

# Me gustaría saber si hay burger 
if [[ "$texto" =~ burger ]]; then
    echo "El texto contiene la palabra burger"
else
    echo "El texto NO contiene la palabra burger."
fi