# Wordpress CodeSpace

En este repositorio encontrarás un ejemplo de aplicación a desplegar, para utilizar los llamados codespaces de Github. En este ejemplo, se podrá desplegar las siguientes aplicaciones:

* Servidor de base de datos Mysql
* PhpMyAdmin
* Wordpress

En este repositorio, encontrarás un fichero ```compose.yaml``` que nos va a permitir desplegar las aplicaciones. Para ello, vamos a realizar los siguientes pasos:

1. Inicia sesión en Github, y dirigete a este repositorio: [https://github.com/zerasul/wordpresscodepasce](https://github.com/zerasul/wordpresscodepasce)
2. Una vez en él, vamos a realizar un "fork"; es decir una copia. Para ello, pulsaremos el botón Fork que encontrarás en la parte superior derecha.

![imagen](https://github.com/user-attachments/assets/a704aa3e-3c9f-4cce-94de-cfebd380ebac)

3. Tras acabar esto, tendrás una copia en tu usuario de este mismo repositorio; siendo la dirección: github.com/<usuario>/wordpresscodespace
4. Ahora, vamos a activar el codespace. Esto es una opción que nos permitirá tener un entorno de desarrollo completo en la web; pudiendo también ejecutar comandos en una máquina virtual en la nube.
5. Para activar el codespace, pulsamos en el botón verde "code" y buscamos la pestaña "codespace"; una vez allí creamos un nuevo codespace.

![imagen](https://github.com/user-attachments/assets/d9332acf-e92b-44fc-a25a-a1d17ba5124b)

6. Ya una vez hemos entrado en el codespace, puedes ver que se trata de un entorno Visual Studio Code completo. Puedes utilizar las mismas funcionalidades que la versión local.

7. Antes de proceder a levantar las aplicaciones, vamos a instalar algunas extensiones; para instalar una extensión pulsa el quinto icono de la izquierda y busca la extensión "Docker"; una vez encontrada, pulsa el botón instalar.

![imagen](https://github.com/user-attachments/assets/08f2871a-1846-404e-8913-3fae553e5cae)

8. Tras instalar las extensiones, ya puedes levantar las aplicaciones; haz click en el fichero del codespace "compose.yaml" y pulsa la opción "compose up"; esto leerá el fichero Docker Compose, y levantará las aplicaciones.

9. ![imagen](https://github.com/user-attachments/assets/c10c8e78-cb50-4f63-bbfb-275d4427350a)

10. Una vez ha acabado de configurar y levantar los contenedores, puedes ir a cualquier servicio en la pestaña de cotenedores docker (séptimo icono de la izquierda) y al pulsar el botón derecho en uno de los contenedores pulsar "open in web browser".

![imagen](https://github.com/user-attachments/assets/25a822d0-24af-4495-924a-015117e8bb33)
