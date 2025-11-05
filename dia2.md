
# Linux

No es un SO, sino un kernel de SO.
Habitualmente cuando decimos Linux en nuestro entorno nos referimos a un SO: GNU/Linux.

Sus inicios se basaron en las especificaciones de UNIX (POSIX, SUS), pero luego evoluciona independientemente.

# Sistema de archivos

A diferencia de Windows, donde cada volumen lógico) tiene su propia entrada independiente (C:, D:, etc), en Linux todo el sistema de archivos es un único árbol invertido, con la raíz en /.

    Hay carpetas definidas en posix:
    /bin: programas ejecutables esenciales
    /boot: archivos de arranque
    /dev: archivos de dispositivos
    /etc: archivos de configuración
    /home: directorios personales de los usuarios
    /lib: bibliotecas compartidas esenciales
    /media: puntos de montaje para medios extraíbles
    /mnt: punto de montaje temporal
    /opt: software adicional
    /proc: sistema de archivos virtual con información del sistema
    /root: directorio personal del superusuario
    /sbin: programas ejecutables del sistema
    /tmp: archivos temporales
    /usr: programas y datos de usuario
    /var: archivos variables como logs

# Permisos

Tanto carpetas como archivos tienen permisos de lectura, escritura y ejecución para tres tipos de usuarios: propietario, grupo y otros.

    [ ] [ ] [ ]
     1.  1.  1
    r (read): permiso de lectura            4
    w (write): permiso de escritura         2
    x (execute): permiso de ejecución       1

    5 = 4 + 1 = lectura y ejecución
    7 = 4 + 2 + 1 = lectura, escritura y ejecución

Además de archivos y carpetas, en Linux usamos mucho los enlaces simbólicos (es algo parecido a los accesos directos de Windows).
Por ejemplo:

    Instalo un programa en /opt/programa-v1.4.3
    Creo un enlace simbólico /usr/bin/programa que apunta a /opt/programa-v1.4.3/programa
    Si el día de mañana actualizo a la versión 1.5.0, solo tengo que cambiar el enlace simbólico para que apunte a /opt/programa-v1.5.0/programa

> .profile    -rw-r--r--

     -        Indica que es un archivo regular
     rw-      Permisos del propietario: lectura y escritura
     r--      Permisos del grupo: solo lectura
     r--      Permisos de otros: solo lectura


# Comandos habituales para trabajar con el filesystem:

- pwd: muestra el directorio actual
- ls: lista el contenido de un directorio
- cd: cambia de directorio
- mkdir: crea un nuevo directorio
- rmdir: elimina un directorio vacío
- rm: elimina archivos o directorios
- cp: copia archivos o directorios
- mv: mueve o renombra archivos o directorios
- chmod: cambia los permisos de archivos o directorios
- chown: cambia el propietario de archivos o directorios

# Servicios y más

Antiguamente los servicios, tareas programadas, etc, se gestionaban con scripts en /etc/init.d y /etc/rc*.. Esto se heredaba de Unix System V.

Hoy en día, en linux tenemos el demonio de sistema systemd, que gestiona el arranque del sistema, los servicios... y más cosas.

- Para configurarlo usamos ficheros: Unit files. Por ejemplo, para configurar servicios tenemos los service files. Tienen extensión .service y se encuentran en /etc/systemd/system/ o /lib/systemd/system/

    ```bash
    [Unit]
    Description=Mi servicio
    After=network.target

    [Service]
    ExecStart=/usr/bin/mi_programa
    Restart=always
    # más cosas

    [Install]
    WantedBy=multi-user.target
    ```

- Comandos habituales para trabajar con systemd:
    - systemctl daemon-reload                                   # recarga la configuración de systemd
    - systemctl start nombre_servicio.service                   # inicia un servicio
    - systemctl stop nombre_servicio.service                    # detiene un servicio
    - systemctl restart nombre_servicio.service                 # reinicia un servicio
    - systemctl disable nombre_servicio.service                 # deshabilita un servicio para que no se inicie al arrancar el sistema
    - systemctl enable nombre_servicio.service                  # habilita un servicio para que se inicie al arrancar el sistema

---

# Durante la instalación:

## SSH??

Protocolo de acceso remoto seguro. (Secure Shell).
En general, ya dijimos que estas máquinas las operamos desde una terminal. Hay entornos gráficos que pueden tener cierta utilidad, lo que más usamos es la terminal. Si lo único que necesito es una terminal, lo que me interesa es desde mi pc cliente, poder abrir una terminal contra mi servidor remoto.
Eso es lo que nos ofrece ssh.

Hay muchos programas en Windows que me facilitan abrir una terminal ssh contra un servidor remoto (putty, mobaxterm, etc). En Linux y MacOS ya lo tenemos integrado en la terminal.

Qué hace falta?
- Usuario   (Identificarnos)
- Para autenticarnos:
  - Contraseña                      (Se considera inseguro)
  - Clave pública/privada           (Se considera seguro) Se usa para encriptación

Entonces:
- En una máquina (desde la que me quiero conectar) genero un par de claves (pública y privada)
- Después copio la clave pública a la máquina remota (servidor). Eso realmente no es que copie un archivo.
  Lo que hacemos es añadir esa clave pública (son dos lineas de texto) al archivo ~/.ssh/authorized_keys del usuario con el que me quiero conectar.
- Me puedo conectar... usando mi clave privada.

Hay otra cosa. SSH, igual que Https intenta ayudarnos a evitar un segundo tipo de ataque: Suplantación de identidad

La primera vez que me conecto a un servidor, Se genera una huella digital (fingerprint) del servidor. Esa huella incluye datos como su IP, MAC, nombre, clave pública, etc. Y se registra en un fichero en mi máquina cliente (~/.ssh/known_hosts).
La próxima vez que me conecte, se compara la huella digital nueva que se calcula del servidor con la que tengo registrada. Si coinciden, todo bien. Si no coinciden, puede ser que el servidor me le hayan pegado el cambiazo ... Simplemente se me avisa y me pregunta si quiero continuar o no.

Si estamos en una máquina linux, podemos generar una clave pública/privada con el comando:

    ssh-keygen -t rsa -b 4096 -C "<tu_email@example.com>"

Si estoy en una máquina Windows, puedo usar puttygen para generar el par de claves.

Puedo usar github para alojar mi clave pública y así usarla en cualquier servidor que soporte autenticación por clave pública.

#### [ ] OpenSSH

Es una implementación libre del protocolo SSH. Viene instalado por defecto en la mayoría de distribuciones Linux y en MacOS. En Windows 10 y versiones posteriores, también está disponible como una característica opcional que se puede instalar.

Es la que me permite que otros se conecten a mi máquina (servidor ssh). Es necesario tener habilitado el servicio sshd (el demonio de ssh) para que se pueden conectar con una máquina.


#### Arroba

En inglés la pronunciamos 'at' (en español 'en'... de ubicación)

usuario@servidor... El usuario que está 'en' el servidor

Es lo mismo para los emails:
menchu@talempresa.com
No cualquier menchu.. La menchu que está en talempresa.com

## Red : Bond

Cuando configuramos la red, hay 2 conceptos independientes:
- NIC (Network Interface Card): Tarjeta de red física
- Interfaz de red:              Es la representación lógica de una red en el sistema operativo.

Los programas se comunican a través de una interfaz de red.
Las interfaces del red son las que tienen asignada una IP, una máscara de red, una puerta de enlace, etc.

Cuántas NIC tiene nuestra máquina? 1 (Una tarjeta de red virtual que nos ha montado virtualBox... podemos montar más... y lo haremos)
    lspci | grep -i net

Cuántas interfaces de red tiene nuestra máquina?  Ahora mismo tendremos 2
    - Una asociada a la tarjeta de red virtual (eth0 o enp0s3 o similar)
    - Una asociada a una red virtual, llamada red de loopback (127.0.0.1/8) (localhost: 127.0.0.1)

    Cuando necesitamos que programas de nuestra computadora se comuniquen por red con programas de la misma computadora, usamos la red de loopback.

Por qué esa distinción entre tarjeta de red física e interfaz de red?

- El hecho es que podemos tener una tarjeta de red alimentando una interfaz de red..
- Pero también puedo tener 2 tarjetas de red físicas alimentando una misma interfaz de red (bonding -> más ancho de banda, tolerancia a fallos, etc)
- También podría tener lo contrario: Una tarjeta de red física alimentando varias interfaces de red (VLANs, redes virtuales, etc)

Si lo que tengo es una máquina para trabajar yo... lo normal es que tengo una sola tarjeta de red física x interfaz de red.

En un servidor, donde necesitemos alta disponibilidad, tolerancia a fallos, escalabilidad, etc, puede tener sentido hacer bonding.

Un servidor gordo es fácil que tenga 10-20 tarjetas de red físicas. Puedo agruparlas en bonds de 2, 4, 8, etc tarjetas de red físicas.

Las interfaces son a las que se asignan las direcciones IP.
Los programas, cuando abren un puerto lo hacen sobre una dirección IP concreta (interfaz de red concreta).
En ocasiones me interesa que un programa abra su puerto en todas las interfaces de red (0.0.0.0).

Un programa que abra su puerto en la ip (máscara de red) 0.0.0.0/0 está diciendo que quiere escuchar en todas las interfaces de red disponibles en la máquina.

Hay 2 versiones de IPv4 e IPv6.
La más habitual es IPv4: 192.168.x.x, 10.x.x.x, 172.16.x.x - 172.31.x.x (redes privadas)
Pero IPv6 la gracia es que admite muchísimas más direcciones IP (128 bits en lugar de 32 bits).

Si vemos por ahí que un programa abre su puerto en ::/0, está diciendo que quiere escuchar en todas las interfaces de red disponibles en la máquina, tanto IPv4 como IPv6.



## Mirror / Proxy

## Planificación Disco

## Paquetería adicional


---

# Conceptos de seguridad básicos:

Identificación: Decir quién soy
Autenticación:  Comprobar que eres quién dices ser
Autorización:   Sabiendo que eres quién dices ser, qué puedes hacer

## Encriptación:

- Algoritmos de clave publica/privada:  Asimétricos
- Algoritmos de clave única:            Simétricos

## HTTPS?

Tanto en SSH, como en HTTPS, se usa para el grueso de la comunicación, algoritmos simétricos (más rápidos). Pero lo que se hace es generar una clave simétrica única para esa sesión, y esa clave se transmite usando algoritmos asimétricos (más lentos, pero seguros).

La autenticación en ssh se hace mediante un reto que manda el servidor, que el cliente debe encriptar con su clave privada. El servidor puede desencriptarlo con la clave pública del cliente. Si es correcto significa que el cliente es poseedor de la clave privada asociada a esa clave pública, y por ende es quién dice ser.

Y luego se usa esa clave también para encriptar la clave simétrica que se usará para la sesión. <- Se busca con esto frustrar un ataque de tipo man-in-the-middle.

### Suplantación de identidad: Phishing

Es un ataque en el cual un servidor se hace pasar por otro... para engañar al usuario y que éste le mande información sensible (usuario, contraseña, datos bancarios, etc). que pueda utilizar con fines maliciosos.
En el caso de HTTPS, el servidor debe presentar un certificado. En él, vienen sus datos identificativos, y la firma de una autoridad certificadora (CA). Esa firma, si el cliente confía en quien la emite (CA), da garantías de que el servidor es quién dice ser.


---

# PROMPT

 usuario@curso-ubuntu:~$

Ese prompt es personalizable, la información que quiero que aparezca... y muchas veces me interesa personalizarlo.
Por ejemplo, si trabajo en una carpeta donde tengo un repositorio de git, me puede interesar que me muestre en el prompt la rama en la que estoy trabajando.


---

# Instalar software en máquinas GNU/Linux:

- Hacernos con el paquete (archivo .deb, .rpm, .dpk, etc)
- Usar un gestor de paquetes. Es el equivalente a la Tienda(Store) de Windows
   - debian: Aptitude (apt / apt-get) Ubuntu, que es un derivado de debian, también usa apt
   - redhat: YUM, DNF       Fedora, CentOS, RHEL
   - suse: Zypper
   - arch: Pacman
- Usar un contenedor (Docker, Podman, etc)


En casi todos los gestores de paquetes necesitamos configurar repositorios (repos) desde los que descargar los paquetes.
Todos suelen venir con unos repositorios por defecto, pero podemos añadir otros repositorios (incluso privados) si queremos instalar software que no está en los repositorios oficiales.

## Impersonarnos como usuario root

En linux, el usuario root es el superusuario. Tiene permisos para hacer cualquier cosa en el sistema.

Para hacer tareas administrativas, necesitamos permisos de root.
Podemos usar el comando su (substitute user) para cambiarnos al usuario root:

    su -

La otra usar sudo (super user do) para ejecutar un comando con permisos de root:

    sudo comando

Eso si... para poder hacer uso de sudo, nuestro usuario debe estar en el archivo /etc/sudoers o en un grupo que tenga permisos para usar sudo (normalmente el grupo sudo o wheel, dependiendo de la distribución).



---


1. Montar openssh-server 
   Esto nos permite acceder por ssh a la máquina desde fuera. 

En nuestro caso, Virtualbox es quien nos provee una tarjeta de red Virtual.
Esa tarjeta podemos indicarle a VirtualBox donde debe enchufarla.
Por defecto había puesto NAT. Eso significa que la máquina virtual puede salir a internet, a traves de la red del host, pero no puede recibir conexiones entrantes desde fuera (desde mi pc host).

Lo que hemos hecho ha sido configurarla en modo BRIGDE. Eso lo que hace es aprovecharse de la virtualización que ofrecen las propias tarjetas de red físicas. Lo que ocurre es que a nuestra red física (no a la tarjeta... a la red de la empresa... de la casa) le presentamos nuestra. tarjeta de red física como si fueran 2 tarjetas de red físicas distintas. Para una tarjeta tenemos 2 interfaces de red lógicas distintas.
Tenemos 2 IPs, una en el host y otra en la VM, las 2 de la red de la empresa. Y ahora si pueden verse las máquinas entre sí.

---

# Para que se usa la memoria RAM

Cualquier programa (el SO incluido) hace uso de la memoria RAM para:
- Cargar el propio código del programa
- Almacenar datos temporales durante la ejecución
- Cachear datos para acelerar accesos futuros (evitar acceso repetido a disco... a una BBDD...)
  El espacio que hay para cache puede liberarse tranquilamente si el sistema lo necesita para otras cosas.
  Eso solo hace que todo vaya más rápido. 


SWAP:
Se usa para ampliar la memoria RAM disponible en el sistema. La RAM Es cara... y suele estar limitada
A veces podemos usar un trozo del HDD como si fuera RAM adicional.... eso si.. la velocidad de acceso a datos en el HDD es mucho más lenta que en RAM.
Si tenemos programas que a veces no usamos mucho... podemos temporalmente descargarlos de la memoria RAM y pasarlos a SWAP.
Más adelante cuando volvamos a esos programas, tendremos que volver a cargarlos en RAM desde SWAP... con la penalización de tiempo que eso conlleva.
Eso hará que todo vaya más lento... pero a cambio evitamos que el sistema se quede sin memoria RAM y empiece a fallar.


----

# Comandos útiles:

ip a                    # muestra las interfaces de red y sus direcciones IP
free                    # muestra el uso de memoria RAM y SWAP
df -h                   # muestra el uso del espacio en disco de las particiones montadas

top                     # muestra los procesos en ejecución y su uso de recursos del sistema en tiempo real
ps                      # muestra una lista de los procesos en ejecución
 -ef                    # muestra información detallada de todos los procesos (independientemente del usuario con información extra)
 -aux                   # muestra información detallada de todos los procesos en formato de lista

# Todo proceso tiene un PID (Process IDentifier)

Y fué abierto por otro proceso (PPID: Parent Process IDentifier)
Todos salvo 1, el proceso init (o systemd en sistemas modernos) que es el primer proceso que se inicia en el arranque del sistema y tiene PID 1.
Cualquier proceso que se inicie en el sistema, será hijo directo o indirecto del proceso init/systemd.

---

Cualquier proceso en un sistema POSIX (Windows también lo hace así) tiene 3 canales de comunicación por defecto con el exterior:

 - Canal 0: stdin   (Standard Input)    Entrada estándar (por donde al proceso le pueden llegar datos de otros programas)
 - Canal 1: stdout  (Standard Output)   Salida estándar  (por donde el proceso envía datos de salida a otros programas)
 - Canal 2: stderr  (Standard Error)    Salida de errores (por donde el proceso envía mensajes de error a otros programas)

Posteriormente podemos crear más canales de comunicación (pipes, sockets, etc) si queremos que el proceso se comunique con otros programas de forma más compleja (DESARROLLO DE APLICACIONES)
  
                        +-----------------+ 
                        |     Proceso     |
       -----------------+       PID       +-----------------
       Canal 0 (stdin) >>                 >> Canal 1 (stdout)
       -----------------+                 +-----------------
                        |                 |
                        +-----+     +-----+                 
                              |  2  |
                              | VVV |
                               stderr


Esos canales sirven de comunicación entre procesos.

Nosotros estamos trabajando en una terminal (bash: Bourne Again SHell).
Eso implica que nuestra terminal, que también es un proceso, tiene abiertos esos 3 canales de comunicación.

En el caso de la terminal, el canal de entrada está vinculado al teclado.
En canal de salida y de errores están vinculados a la pantalla.

Los SO POSIX nos permiten redirigir esos canales a otros programas, archivo, sockets, etc.

$ echo "MENSAJE"

Lo que hace es REPETIR el mensaje (eco), a su salida estándar.

Cuando ejecutamos echo desde una terminal, el canal de salida estandar del proceso echo, se vincula al canal de entrada estándar de la terminal (pantalla).

echo "mensaje" Lo que hace es enviar "mensaje" a su canal de salida estándar... Si estoy ejecutando esto desde una terminal ... ese canal de salida estándar del proceso echo está vinculado al canal de entrada estándar de la terminal (pantalla)... por lo que vemos el mensaje en pantalla.

Pero esas cosas puedo cambiarlas.

COMANDO 1> archivo.txt      Lo que el comando mande por su canal de salida estándar, se redirige al archivo archivo.txt
                            Ese archivo se crea nuevo. Si ya existe se sobreescribe.
COMANDO  > archivo.txt      Igual que el anterior. El 1 es opcional, ya que el canal de salida estándar es el canal 1 por defecto.

COMANDO 1>> archivo.txt     Igual que el anterior, pero si el archivo ya existe, en lugar de sobreescribirlo, añade el nuevo contenido que mande el comando por su canal de salida estandar al final del archivo.txt

COMANDO 2> errores.txt      Lo que el comando mande por su canal de salida de errores, se redirige al archivo errores.txt
                            Ese archivo se crea nuevo. Si ya existe se sobreescribe.

COMANDO 2>> errores.txt     Igual que el anterior, pero si el archivo ya existe, en lugar de sobreescribirlo,
                            añade el nuevo contenido que mande el comando por su canal de salida de errores al final del archivo errores.txt

## Hay algunas sintaxis especiales aquí que nos pueden interesas:

Destino /dev/null (Cubo de la basura)
Si redirijo la salida (de estandar o error) de un comando a /dev/null, lo que estoy haciendo es tirar esa salida a la basura.

echo MENSAJE 1> /dev/null    # El mensaje se pierde. No lo veo en pantalla ni se guarda en ningún sitio.

COMANDO 1> DESTINOA 2>&1     # La salida 1 la tengo redirigida a DESTINOA
                             # La salida 2 la redirijo a donde esté yendo la salida 1 (DESTINOA)
                             # Por lo que ambas salidas van a DESTINOA
COMANDO 2> DESTINOA 1>&2     # La salida 2 la tengo redirigida a DESTINOA

echo "MENSAJE" 1>&2          # En este caso, el mensaje no lo estoy sacando por la salida estándar (pantalla), sino por la salida de errores 


## Pipes

Nos permiten redirigir la salida estándar (1) de un comando al canal de entrada estándar (0) de otro comando.


    echo "MENSAJE" | grep "ME"

    Lo que el primer comando (echo) mande (MENSAJE) por su canal de salida estándar(1), se redirige al canal de entrada estándar (0) del segundo comando (grep).

### Qué hace el comando grep?

Filtra líneas que contienen un texto específico.

$ echo "MENSAJE" | grep "ME"

"MENSAJE" por donde sale? por la salida estandar del echo... y esa salida la hemos vinculado (|) a la entrada estandar del grep.
Por lo tanto, grep RECIBE "MENSAJE" por su canal de entrada estandar (0). Y busca en ese MENSAJE si encuentra "ME".
Y efectivamente lo encuentra y nos lo resalta por pantalla


$ echo "MENSAJE" 1>&2 | grep "ME"

En este caso, el MENSAJE lo estoy mandando al canal de salida estandar del echo... pero con 1>&2 lo que hago es redireccionar esa salida estandar (1)  al canal de salida de errores (2) del echo.. que está vinculada a (por defecto a la terminal). La salida estandar del comando echo es lo que se mandaría al comando grep (|)... pero que ha salido por la salida estandar del comando echo? NADA
Por lo que a grep que le ha llegado? NADA

Y en pantalla vemos MENSAJE.. pero ese MENSAJE que vemos es lo que ha salido del echo por la salida de errores (2) ... que está vinculado por defecto a la terminal.


---

Todo proceso, cuando termina acaba con un código de salida (exit code). Esto pasa en POSIX y también en Windows:
0 - Éxito
Cualquier número que no sea 0 - Error
 Cada programa tiene sus propios códigos de error (1, 2, 3, etc) y cada uno indica un tipo de error concreto.
 Puede haber un programa que solo saque los erres 9, 17, 200
 Y otro programa 9, 10, 11

 Y lo que significa el 9 en el primer programa no tiene porque ser lo mismo que el 9 en el segundo programa.

Para saber el código de salida del último programa que se ha ejecutado usamos $?
Es una variable que contiene el código de salida del último programa ejecutado.

---

Hay otros signos que usamos bastante cuando escribimos comandos:
- &&
- ||

 COMANDO1 && COMANDO2 || COMMANDO3
 
 En este caso, el comando 1 se ejecuta siempre.
 El comando 2 se ejecuta solo si el comando 1 ha tenido éxito (código de salida 0)
 El comando 3 se ejecuta solo si el comando 1 ha fallado (código de salida distinto de 0)

