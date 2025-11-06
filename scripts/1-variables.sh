#!/bin/bash

# Eso que hemos puesto es lo que se llama "shebang" y le dice al sistema
# que use el intérprete de bash para ejecutar este script.
# ... otros ejemplos: #!/usr/bin/python3   #!/usr/bin/perl

# Si no ponemos eso, el sistema usará el intérprete por defecto,
# que suele ser /bin/sh, que es más limitado que bash.

# Como veis puedo poner comentarios, con el símbolo #
# Esos comentarios son ignorados por el intérprete.

# VARIABLES
# Una variable es un espacio en memoria donde podemos guardar un dato
# En la bash, todos los datos son cadenas de texto (strings)
# La bash no tiene otros tipos de datos. Solo guarda texto en memoria.
# Aunque veremos que en ocasiones podemos decirle que interprete ese texto como un número.

mi_variable="Ivan"
mi_variable_2=57     # Ojo, lo que estamos guardando es el texto "57", no un número
# Las comillas no son obligatorias, pero es buena práctica usarlas siempre.

# Otra forma que tenemos de definir variables es usando la palabra clave 'declare'
declare otra_variable="Hola a todos" # Lo usamos menos.. no es obligatorio

# Una vez que tenemos una variable, podemos usarla en nuestro script.
# Para usar el valor de una variable, tenemos que poner el símbolo $ delante del nombre.
echo "El valor de mi_variable es: $mi_variable" # Esto imprimirá: El valor de mi_variable es: Ivan
echo 'El valor de mi_variable es: $mi_variable' # Esto imprimirá: El valor de mi_variable es: $mi_variable

# Realmente esa sintaxis es una abreviación de la sintaxis ${mi_variable}
echo "El valor de mi_variable es: ${mi_variable}" # Esto imprimirá: El valor de mi_variable es: Ivan
# En muchos casos podemos obviar las llaves {}
# No siempre:
echo "El valor de mi_variable_2 es: __$mi_variable_2__" # En este caso se despista el intérprete
# Busca una variable llamada mi_variable_2__ (con dos guiones bajos al final)
# Que no existe, así que imprimirá: El valor de mi_variable_2 es:__
# Para evitar eso, usamos las llaves {}
echo "El valor de mi_variable_2 es: __${mi_variable_2}__" # Esto imprimirá: El valor de mi_variable_2 es: __57__

# Hay variables que puedo definir cuyo valor se calcule como el resultado de una operación matemática.
let suma=5+3 # Se admite + - * / % (suma, resta, multiplicación, división, módulo = resto de la división entera)
echo "El valor de suma es: $suma" # Imprimirá: El valor de suma es: 8. 
# Cuidado... para la bash, suma lo que contiene es el texto "8", no el número 8... solo que ha sido calculado.

# Leer datos por consola
# El comando echo imprime texto en pantalla.
# El comando read lee datos desde la consola y los guarda en una variable.
echo "Por favor, introduce tu nombre:"
read nombre_usuario
echo "Hola, $nombre_usuario! Bienvenido al curso de bash."

# Podríamos incluso pasar al comando read el mensaje a mostrar:
read -p "Por favor, introduce tu edad: " edad_usuario     # -p = Te voy a pasar un prompt (mensaje)

# El comando read, por defecto capturará todo lo que el usuario escriba hasta que pulse Enter.

# En ocasiones es mucho más cómoda indicarle a read que solo debe leer una determinada cantidad de caracteres.

# Por ejemplo:
read -p "Quieres continuar? (s/n): " -n 1 respuesta_usuario   # -n 1 = solo lee 1 carácter.. sin necesidad de pulsar Enter
echo
echo "Has decidido $respuesta_usuario"