
# F2Paradise

## Descripción

F2Paradise es una aplicación móvil desarrollada con Flutter que permite a los usuarios explorar, buscar y gestionar su lista de deseos de videojuegos. La aplicación ofrece funcionalidades tanto *online* como *offline*, asegurando que los usuarios puedan acceder a la información de sus juegos favoritos en cualquier momento y lugar, siempre y cuando se tenga información almacenada localmente.

La aplicación fue desarrollada por Tomás Concha y Joel Díaz.

## Requerimientos

En la fase de análisis, se prestó atención a todos los detalles de las especificaciones del *software* solicitado. En base a esto, se elaboró la siguiente lista de requerimientos para la aplicación:

1.  El usuario puede ver la actividad reciente, es decir, los últimos juegos propios que ha revisado.
    
2.  El usuario puede ver las recomendaciones de juegos en base a sus preferencias, es decir, el género del que más videojuegos tiene.
    
3.  El usuario puede ver las sugerencias aleatorias que ofrece la aplicación como “Explora algo nuevo”.

4.  El usuario puede buscar juegos específicos usando una barra de búsqueda.
    
5.  El usuario puede explorar nuevos juegos, filtrando por nombre, categoría, plataforma, etc.
    
6.  El usuario puede agregar juegos a su lista de deseos, para agregarles información como jugados y por jugar, y puede decidir si darle o no una calificación con *like* o *dislike*.
    
7.  El usuario puede visualizar los juegos en su lista de deseos en base a las clasificaciones anteriores o filtrándolos por la información por defecto.
    
8.  El usuario puede quitar juegos de su lista de deseos.
    
9.  El usuario puede compartir la información de un juego mediante aplicaciones externas.
    
10.  La aplicación debe tener un ícono que la represente.
    
11.  La aplicación debe tener una *splash screen* que visibilice al ícono.
    
12.  La aplicación debe almacenar la lista de deseos del usuario mediante una base de datos local que le permita acceder a ella, incluso de manera *offline*.
    
13.  La aplicación debe distinguir si el estado de conexión es *online* u *offline*, y manejarlo para mostrar información acorde a esto.
    
14.  La aplicación debe realizar solicitudes a la API a través de Internet para recuperar la información que será mostrada.
    
15.  La aplicación debe mostrar al usuario un *feedback* según su estado de conectividad; si no está conectado, indicarle que no lo está, y que active sus datos móviles o se conecte a alguna red Wi-Fi; si está conectado, pero su red es débil, después de unos segundos de carga, hacerle saber la situación, y que por eso se está demorando en cargar la aplicación.

## Mockup

En la fase de diseño, se utilizó la herramienta y plataforma de diseño Figma para realizar un *mockup* de la aplicación, prestando especial atención a la interfaz del usuario para seguir los lineamientos establecidos por Material Design, el sistema de diseño desarrollado por Google, específicamente la versión 3.

Sobre esta base y considerando los conocimientos en el *framework* y el lenguaje de programación, el proyecto se centró más en la presentación, para presentar un Producto Mínimo Viable apto para su comercialización.

El siguiente *link* permite acceder al recurso mencionado: [F2Paradise - Mockup](https://www.figma.com/design/PagtdYaaoLmXKx44ZkEfQq/F2Paradise?node-id=15-149&node-type=frame&t=IuUVODN3CmQgjSDS-0). ***REVISAR EL LINK***

## APK

Por último, se llevó a cabo el desarrollo de la aplicación en Flutter, considerando todos el material creado durante las fases de análisis y diseño. Dado que se creó una aplicación *cross-platform*, esta puede ser exportada a diferentes sistemas operativos. Sin embargo, debido a los recursos para realizar el *testing*, F2Paradise se exportó solo para dispositivos móviles con sistema operativo Android.

El resultado de la fase de implementación se evidencia con el producto final, el cual se puede acceder mediante el siguiente link: [F2Paradise - APK](). ***REVISAR EL LINK***

## Presentación de la aplicación

Adicionalmente y para tener una idea más clara de la aplicación (contexto, funcionamiento, objetivo, etc.), se llevó a cabo una presentación por parte de los desarrolladores, la cual se puede encontrar en el siguiente link, junto con el material utilizado: [F2Paradise - Presentación](). ***REVISAR EL LINK***
