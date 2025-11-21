√ Docker compose
---
# Discos/Almacenamientos

En Linux, tenemos lo que se llama un Sistema de Archivos (File System). Ese file sistema no es como el de Windows, que tiene letras para cada disco (C:, D:, etc). En Linux, todo es un solo árbol de directorios que empieza en la raíz `/`.

Y si tengo muchos discos?
- Dentro de ee sistema de archivos, podemos "montar" otros discos o particiones como un directorio más del árbol. 

Podría tener el sistema de archivos estándar de POSIX:
/ 
    bin/
    etc/
    home/
        usuario1/
            documentos/
    tmp/
    var/
    usr/
    mnt/
        carpeta <--- Que realmente esta ruta: /mnt/carpeta apunta a otro disco o partición... o incluso a un disco en la red

# Distinguimos varios conceptos:

- DISCO: Es el dispositivo físico (HDD, SSD, USB, etc)
  Esos discos se ubican dentro del sistema de archivos en /dev/
  - Si son discos HDD, SDD: /dev/sda, /dev/sdb, etc... con letras secuenciales sd* (SATA)
  - Si son discos IDE (antiguos): /dev/hda, /dev/hdb, etc... con letras secuenciales hd*
  - Si son nuevos NVMe: /dev/nvme0n1, /dev/nvme0n2, etc...
  - Discos virtuales: /dev/vda, /dev/vdb, etc...

Cuidado.. que vea ahí un disco no significa que desde ahí pueda acceder a los contenidos. Para que pueda acceder a los contenidos de un disco, ese disco tiene que estar MONTADO en algún punto del sistema de archivos.
Esa ruta solo es una referencia al DISPOSITIVO FÍSICO.

- PARTICIÓN: Un disco físico puede estar dividido en varias particiones. Cada partición es como un disco lógico independiente.
  - Ejemplo: Un disco /dev/sda puede tener 3 particiones: /dev/sda1, /dev/sda2, /dev/sda3
  - Cada partición puede tener su propio sistema de archivos (ext4, ntfs, etc)
  - Tabla de particiones: Es la estructura que define cómo se dividen las particiones en un disco. Ejemplos: 
    - MBR (Master Boot Record) / Antiguo (limitado a 4 particiones primarias, discos de hasta 2TB)
    - GPT (GUID Partition Table) / Moderno (más de 4 particiones, discos mayores de 2TB)

- SISTEMA DE ARCHIVOS: Es la estructura lógica que organiza y almacena los datos en una partición o disco. Ejemplos comunes son ext4, ntfs, fat32, zfs...
  Un disco duro, cuando lo compro ees como un cuaderno en blanco. 
  Al asignarle un formato, dibujamos en el rayitas o cuadritos para organizar los datos. Eso es el sistema de archivos.
  - Para clases de lengua si tengo 9 años, quiero un cuaderno con doble raya.
  - Para clases de mates, quiero un cuaderno de cuadricula de 5mm.
  - Para clases de historia, con 15 años, quiero un cuaderno con una sola raya.
  - Para dibujar gráficas, quiero un papel milimetrado.
  En base a lo que quiera hacer con el disco, le asigno un sistema de archivos u otro. 
  - Windows: NTFS
  - Debian/Linux: ext4
  - Redhat/CentOS: XFS

---

En Linux habitualmente no trabajamos con los discos a pelo... De esa forma. Usamos un componente llamado LVM (Logical Volume Manager). Es una gozada.
Me permite ampliar dinámicamente el tamaño de los discos, crear snapshots, etc.

Al trabajar con LVM, tenemos varios conceptos:

    DISCO FISICO < PARTICIONES O NO

        Sobre un disco físico o una partición, creamos un PHYSICAL VOLUME (PV)
        Es un disco o una partición de un disco que he marcado para ser usado por LVM
    
        VOLUME GROUP (VG)
        Con esto trabajamos nosotros. Configuramos un ESPACIO DE ALMACENAMIENTO LÓGICO, que está formado por uno o varios PHYSICAL VOLUMES (PV). ESTO ES UN POOL DE ALMACENAMIENTO.

        Sobre ese VOLUME GROUP (VG), creamos LOGICAL VOLUMES (LV)... esto es a lo que daremos un formato de sistema de archivos y montaremos en el sistema de archivos de Linux.

---

MODELO TRADICIONAL:
- Disco Físico
    - Particiones (o no)
        - Sistema de Archivos
            - Montaje en el sistema de archivos de Linux

MODELO LVM:
- Disco Físico / Particiones (o no) <-- Physical Volume (PV)     PV1  PV2   
                                                                  v   v
                                                             Volume Group (VG)
                                                                v       v
                                                             LV1        LV2
      LV:
        - Sistema de Archivos
          - Montaje en el sistema de archivos de Linux

---

Montar un disco dentro del sistema de archivos de Linux:
- Opción tradicional:  (con independencia de que use LVM o no)
    $ mount /dev/sdb1 /mnt/carpeta
    $ mount -t nfs servidor:/ruta/en/servidor /mnt/carpeta

- Opción tradicional para discos fijos: Se configuraba en el archivo /etc/fstab
    /dev/sdb1      /mnt/carpeta    ext4    defaults    0 2
    servidor:/ruta/en/servidor   /mnt/carpeta   nfs   defaults   0 0

- Opción de hoy en día: systemd, configurando un archivo unit file, como si fuera un servicio

---

Para la gestión de discos físicos usamos un comando llamado `fdisk`
Me permite consultar las particiones de un disco, crear nuevas particiones, borrar particiones, etc.
Ese comando, lo que voy haciendo... realmente no se hace... Se anota... Y es al final, cuando lo tengo claro, cuando aplico los cambios. ME PERMITE TRABAJAR CON TRANQUILIDAD


sudo bash -c 'cat > /etc/systemd/system/mnt-fijo.mount << EOF
[Unit]
Description=Montaje de la particion 1 del disco 1

[Mount]
What=/dev/sdb1
Where=/mnt/fijo
Type=ext4

[Install]
WantedBy=multi-user.target
EOF'

Antiguamente, en lugar de un unit file, lo metíamos en el /etc/fstab:
# /dev/sdb1   /mnt/fijo   ext4   defaults   0 2

---

LVM: Logical Volume Manager

Tenemos una partición reservadida llamada /dev/sdb2.
Le hemos aplicado un tipo 8e (Linux LVM).
Nos toca comenzar:

/dev/sdb1  <- ext4 -> montaje

/dev/sdb2 -> PV -> VG -> LV <- ext4 -> montaje

# Crear el pv:
sudo pvcreate /dev/sdb2

# Crear el vg:
sudo vgcreate datos /dev/sdb2

# Crear el lv:
sudo lvcreate -l 100%FREE -n disco_flexible datos

# Formatear el lv:
sudo mkfs.ext4 /dev/datos/disco_flexible



sudo bash -c 'cat > /etc/systemd/system/mnt-flexible.mount << EOF
[Unit]
Description=Montaje dl volumen logico

[Mount]
What=/dev/datos/disco_flexible
Where=/mnt/flexible
Type=ext4

[Install]
WantedBy=multi-user.target
EOF'


# Ver los volumenes físicos que tengo en lvm:
sudo pvs

# Ver los grupos de volumenes que tengo en lvm:
sudo vgs

# Ver los volumenes lógicos que tengo en lvm:
sudo lvs

---
# Imaginemos que nos quedamos sin espacio en disco UPS!!!
1. Compro un disco y lo enchufo! Ya lo hemos hecho: /dev/sdc
2. En este caso, no le vamos a crear una partición. Vamos a usar el disco entero como PV:
   sudo pvcreate /dev/sdc

# Crear el pv:
sudo pvcreate /dev/sdc
# Lo añadimos al vg:
sudo vgextend datos /dev/sdc

# Le digo que el volumen logico que tenía, que se amplie para usar todo el espacio libre del vg:
sudo lvextend -l +100%FREE /dev/datos/disco_flexible

# Necesitos reformatear el sistema de archivos para que use el nuevo espacio:.. ampliarle el espacio
sudo resize2fs /dev/datos/disco_flexible

---
# Redes

## NICs

En Linux, las tarjetas de red se representan como interfaces de red.
Para ver las NICs e interfaces de red en el sistema, usamos comandos como:
- ip a

## Interfaces 

Las interfaces de red tienen nombres como:
- eth0, eth1, etc (nombres tradicionales para interfaces Ethernet) YA NO
- enp0s3, enp0s8, etc (nombres basados en la ubicación física de la interfaz) AHORA SI
  en -> Ethernet Network
  wl -> Wireless LAN

Por defecto, en una configuración sencilla, toda interfaz estará vinculada a una única NIC física.

Pero esto es algo que en servidores avanzados solemos cambiar.
En un portátil con Linux no.

En los servidores solemos tener configuraciones más complejas:
- Bonding HA: Agrupar varias NIC físicas en una sola interfaz lógica para redundancia, mediante balanceo de carga.
  Si una NIC falla, otra toma el relevo y sigo teniendo red.
- Bounding mejora de rendimiento: Agrupar varias NIC físicas en una sola interfaz lógica para aumentar el ancho de banda.
  Uso varias NICs a la vez como si fueran una, aumentando el rendimiento de red.
  CUIDADO!
  - 1. Esto implica cambios no solamente en el servidor, sino también en el switch al que está conectado.
       Hay que configurar el switch para que soporte LACP (Link Aggregation Control Protocol).
       Y no todo switches lo soportan (el 90% hoy en día)
  - 2. Esto hay que entender como funciona...
        Si tengo a un usuario mandando un fichero de 200 Mbs, no see usan las 2 NICs a la vez para ese usuario.
        Lo que se hace es repartir las conexiones entre las NICs.
        Si tengo 4 usuarios, cada uno puede usar una NIC diferente.
        Pero un usuario no va a usar las 2 NICs a la vez para aumentar su velocidad.
        Tengo una mejora en capacidad de carga de trabajo.. pero no tanto en rendimiento para un solo usuario.

---

No es lo mismo trabajar con máquinas ubuntu(debian) que con redhat(fedora).
El gestor de red es diferente.
En ubuntu, hoy en día, la gestión de la red la lleva systemd con systemd-networkd.
En redhat, se usa NetworkManager.

En ubuntu, hay un programa por encima de systemd-networkd que se llama netplan... super cómodo: YAML
En redhat, usamos un comando de linea de comandos llamado nmcl: Cliente de NetworkManager

---

# Ubuntu:
- ip a <- Vemos las interfaces de red (lógicas)
- resolvectl status <- Vemos el estado del resolvedor DNS
  
La configuración de red va en el /etc/netplan/*.yaml
Suele llamarse 00-installer-config.yaml, 50-cloud-init.yaml, etc

```yaml
network:
  version: 2
  ethernets:
    enp0s3:
      dhcp4: true

```
En mi caso, mediante dhcp se me asigna una IP dinámica: 192.168.1.76

---

Y yo, ni corto ni perezoso, voy a ponerle una IP fija a mi servidor ubuntu:

```yaml
sudo bash -c 'cat > /etc/netplan/50-cloud-init.yaml << EOF
network:
  version: 2
  ethernets:
    enp0s3:
      dhcp4: false # true
      addresses:
        - 192.168.1.76/24
      routes:
        - to: default
          via: 192.168.1.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
EOF'
```

Cuando cambio ese archivo, debo aplicar los cambios:
$ sudo netplan apply

PERO !!!! OJO !!!!
Normalmente antes de aplicarlo, lo pruebo... que como no funcione, me quedo sin acceso a la máquina:
$ sudo netplan try
// Lo aplica, y me da 120 segundos para confirmar que funciona. Si no confirmo, vuelve a la configuración anterior


## Puertos

Antiguamente usábamos el netstat para ver los puertos abiertos y los servicios asociados.

Hoy en día: ss (socket statistics)... Viene de serie en linux. No hay que instalar nada.

$ ss -tulpn

-t <- TCP
-u <- UDP
-l <- Listening (puertos abiertos)
-p <- Programas asociados
-n <- No resuelve nombres (más rápido)

---

# En una máquina Fedora/Redhat/CentOS
- ip a <- Vemos las interfaces de red (lógicas)
- resolvectl status <- Vemos el estado del resolvedor DNS
- ss -tulpn <- Vemos los puertos abiertos y programas asociados

Pero cambia la forma de configurar la red.
Usamos NetworkManager.
El comando es nmcli (Network Manager Command Line Interface)

Para cambiar la IP de dhcp a fija:

```bash
$ sudo nmcli con show          # Veo las conexiones de red configuradas
$ sudo nmcli con modify enp0s3 ipv4.method manual 
$ sudo nmcli con modify enp0s3 ipv4.addresses 192.168.1.76/24
$ sudo nmcli con modify enp0s3 ipv4.gateway 192.168.1.1
$ sudo nmcli con modify enp0s3 ipv4.dns "8.8.8.8 8.8.4.4"
$ sudo nmcli con up enp0s3 # Sería el equivalente al netplan apply
```

---

Me piden montar un cluster: Tomcat. 4 máquinas idénticas con Tomcat  <- Activo-Activo

Delante de eso tengo que montar un balanceador de carga (httpd, nginx, haproxy, etc).
Y este balanceador, también lo quiero que sea redundante  <- Activo-Pasivo

Cluster Tomcat (activo-activo)
    Instalo las 4 máquinas, y le pongo ip fija a cada una (dependiendo del SO: netplan o nmcli)
    Levanto los tomcat y tengo 4 ips, con el puerto 8080 abierto en cada una.
        192.168.1.101:8080
        192.168.1.102:8080
        192.168.1.103:8080
        192.168.1.104:8080

Eso si somos artesanos! Hoy en día, todo eso lo haríamos con Ansible!

A nivel del balanceado sería algo diferente! Activo x Pasivo ... y lo que trabajamos es con una VIPA (Virtual IP Address)

Monto 2 máquinas con httpd/nginx/haproxy
    - Les configuro ip fija a cada una
      192.168.201
      192.168.202
    - Configuro una segunda IP virtual (VIPA) que será la que usen los clientes para conectarse al servicio
      192.168.200 <-> Interfaz de red virtual, que opera sobre la misma tarjeta física que la ip 192.168.201
      La configuro en ambas máquinas. Pero solo en una de ellas, activo la interfaz de red virtual.

Luego lo que hacemos es configurar un DNS (opcional) para que el nombre del servicio apunte a la VIPA
    tomcat.miempresa.com -> 192.168.200

Por defecto, esa vipa la tiene levanta una de las máquinas (activa). 
Esa recibe todo el trafico y lo balancea entre las 4 máquinas tomcat, que tienen ip fija.

Lo que hacemos es configurar en el pasivo del balanceados (en el otro servidor): 192.168.202 un programa que monitorice la máquina activa (192.168.201). Hay usamos programas como keepalived o heartbeat.
Si detecta que la máquina activa ha caído, levanta la interfaz de red virtual (VIPA) en la máquina pasiva.
De esa forma, los clientes siguen accediendo al mismo DNS (misma IP = tomcat.miempresa.com -> 192.168.200) y no se enteran de nada.
Pero es el pasivo el que ahora atiende las peticiones y las balancea entre los tomcat.