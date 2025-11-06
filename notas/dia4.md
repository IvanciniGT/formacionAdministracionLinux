
# Administración de sistemas

Hoy en día un administrador de sistemas no administra sistemas. Eso era antiguamente.
Hoy en día, un administrador de sistemas crea programas que administran sistemas.

Estamos en el mundo de la automatización.

La BASH usa un paradigma de programación que llamamos imperativo.

## Paradigma de programación

Ese es solo un nombre hortera que los desarrolladores de software usan para referirse a una forma de usar un lenguaje.
Pero en realidad no es algo exclusivo de los lenguajes de programación.
En los lenguajes naturales también nos podemos encontrar diferentes paradigmas.

> Felipe, Si (IF) hay algo que no sea una silla debajo de la ventana > CONDICIONAL
    >  quítalo. > IMPERATIVO
> Felipe, Si (IF) NOT SILLA deebajo de la ventana > CONDICIONAL
    >  Felipe, IF silla == FALSE then goto ikea!
> Felipe, pon una silla debajo de la ventana. > IMPERATIVO

Usar lenguaje imperativo es un engorro! Cada día nos gusta menos.
Los lenguajes imperativos me hacen centrarme no en mi objetivo, sino en cómo conseguirlo.

Mi objetivo es que debajo de la ventana haya una silla.

> Felipe, debajo de la ventana tiene que haber una silla. Es tu responsabilidad.  > LENGUAJE DECLARATIVO
 Lo único que hago es exponer cómo son las cosas. 

Ese lenguaje declarativo lo aplicamos cada día más también en el mundo de la programación.
Y en concreto, en la administración de sistemas, hay herramientas expertas en hablar este tipo de lenguajes: Ansible, Terraform.

# Automatización 

Es ya lo que estamos haciendo nosotros al crear un script en BASH.
Hacer un programa que haga lo que antes hacía un humano.

En nuestra industria, Automatizar = PROGRAMAR = Crear programas!
Esos programas los puedo hacer con lenguajes diferentes o herramientas diferentes, usando unos paradigmas u otros.

BASH se usa mucho... y se seguirá usando mucho...
Pero para muchas tareas hoy en día preferimos usar herramientas como Ansible, Terraform, Puppet, Chef...

El lenguaje declarativo tiene una ventaja gigante sobre el lenguaje imperativo: IDEMPOTENCIA

# Idempotencia

Básicamente es que no importa el estado inicial de un sistema,una operación es idempotente si el resultado final es siempre el mismo, con independencia del estado inicial.

> Felipe, pon una silla debajo de la ventana. > NO ES IDEMPOTENTE

> Felipe, debajo de la ventana tiene que haber una silla. Es tu responsabilidad. > IDEMPOTENTE

  Desde mi punto de vista, la responsabilidad de conseguir el estado final que me interesa (que haya una silla debajo de la ventana) es del agente que tiene que hacer el trabajo (Felipe)...  y él tendrá que buscarse la vida para conseguir dejar el sistema en el estado que yo le he pedido.
    Si no hay silla, que la compre.
    Si ya hay silla debajo de la ventana, no hace falta que haga nada.
    Si no hay ventana, que coja un mazo y abra un agujero en la pared y ponga la silla debajo del agujero.
    Me da igual! Es problema de Felipe!

  No importa cuantas veces ejecute yo una tarea, el resultado final será siempre el mismo: Habrá una silla debajo de la ventana.

---

Instalar un Tomcat: Servidor de apps JAVA

Script BASH

UserFriendly: Aporte información al usuario.
Y que esté más o menos parametrizado.

1. JAVA? Lo estará no? Quién sabe... habrá que comprobarlo. Si está y si está la versión que nos interesa
   La versión de Java que queremos tener instalada la tendremos parametrizada en un fichero independiente de configuración.
2. Tomcat? Lo estará no? Quién sabe... habrá que comprobarlo. Si está y si está la versión que nos interesa
   Habrá que descargarlo (ZIP), descomprimirlo, colocarlo en el sitio adecuado
3. Crear un servicio para que arranque el Tomcat [Unit Files de systemd]
   Lo arrancaremos o no!
   Lo dejaremos activado para que arranque al inicio o no! 

---

Segundo script que vamos a montar... el tomcat en un contenedor de docker!