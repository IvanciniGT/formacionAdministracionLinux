#!/bin/bash

# Las terminales nos permiten sacar textos con colores para mejorar la legibilidad.
# No es cómodo hacerlo, pero es posible.
# Básicamente hay secuencias de caracteres que las terminales identifican y usan para representar colores.
# Cuando quiero que deje de escribir en color, uso la secuencia de reset.

# COLORES
VERDE='\033[0;32m'
ROJO='\033[0;31m'
AZUL='\033[0;34m'
AMARILLO='\033[0;33m'
RESET='\033[0m'


# Esta función recibirá un argumento con el mensaje a mostrar
function mostrar_mensaje_error() { 
    echo -e "${ROJO}$1${RESET}" 1>&2 # El mensaje que salga por la salida de error (el canal 2)
} # El -e del echo le indica que el texto lleva secuencias de escape (como las de color)

function mostrar_mensaje_exito() {
    echo -e "${VERDE}$1${RESET}"
}

function mostrar_mensaje_informativo() {
    echo -e "${AZUL}$1${RESET}"
}

function mostrar_mensaje_advertencia() {
    echo -e "${AMARILLO}$1${RESET}"
}

# Ejemplo de uso:
#mostrar_mensaje_error "Este es un mensaje de error"
#mostrar_mensaje_exito "Este es un mensaje de éxito"
#mostrar_mensaje_informativo "Este es un mensaje informativo"
#mostrar_mensaje_advertencia "Este es un mensaje de advertencia"

# Esta función va a recibir varios argumentos
# El primero es el mensaje a mostrar para la petición (PROMPT)
# El segundo es un patrón de validación (expresión regular)
# Mensaje de en caso de que el patrón no se cumpla
# Número de intentos permitidos
# Ayuda sobre el dato a introducir
# Valor por defecto en caso de no introducir nada
function pedir_dato() {
    prompt=$1
    nombre_variable=$2
    patron=$3
    mensaje_error=$4
    intentos=$5
    ayuda=$6
    valor_defecto=$7
    while (( $intentos > 0 )); do
        echo -ne "${AZUL}${prompt} (" # El -n hace que el comando echo no añada un salto de línea al final
        echo -ne "${RESET}${ayuda}${AZUL}) " # El -e hace que el comando echo interprete las secuencias de escape
        echo -ne "[${VERDE}${valor_defecto}${AZUL}]: ${RESET}"
        read dato_usuario
        # Revisar el dato del usuario.
        # Si la variable valor_defecto no está vacía y el dato del usuario está vacío, usamos el valor por defecto
        if [[ -n "${valor_defecto}" && -z "${dato_usuario}" ]]; then
            #echo $valor_defecto
            # Guardar el valor por defecto en la variable cuyo nombre se pasa como argumento
            eval "${nombre_variable}='${valor_defecto}'"
            #eval: ejecuta un texto como si fuera un comando
            return 0
        elif [[ "${dato_usuario}" =~ ${patron} ]]; then
            #echo $dato_usuario
            eval "${nombre_variable}='${dato_usuario}'"
            return 0
        else
            mostrar_mensaje_advertencia "${mensaje_error}"
            let intentos=$intentos-1
        fi
    done
    return 1
    # La función solo devuelve un valor (0 o 1) dependiendo de si se ha conseguido o no un dato válido
    # Pero lo que mas me interesa es el dato en sí, ese dato lo querremos en una variable
    # Vamos a definir un parametro adicional para guardar el dato en una variable cuyo nombre se pasa como argumento
}

# Ejemplo de uso:
pedir_dato "Introduce un número" \
            numero_introducido
           '^[1-9]$|^10$' \
           "Número no valido: El número debe estar entre 1 y 10" \
           3 \
           "1-10" \
           5

echo El usuario ha introducido el número: $numero_introducido


# Cuando esto se ejecute:
# Introduce un número (1-10) [5]:
# ^^^ Distintos colores
# Si falla, se lo sacamos en amarillo: Warning: Número no valido: El número debe estar entre 1 y 10
# Introduce un número (1-10) [5]:

# Quieres instalar el java? (s/n) [s]: