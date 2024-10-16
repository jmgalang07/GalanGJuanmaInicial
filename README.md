# Desarrollo Web Entorno Servidor
## Primer proyecto (formulario)

**Estamos usando cosas como:**
- Controladores
- Servlets

### Archivos Principales

- `index.html`: Página principal del proyecto.
- `img/`: Carpeta que contiene imágenes utilizadas en el proyecto.
- `jsp/`: Carpeta que contiene los archivos JSP que gestionan la lógica del formulario.

## Servidor

Este proyecto está desarrollado y desplegado utilizando **Apache Tomcat** o **TomEE**, que proporcionan el entorno necesario para ejecutar aplicaciones web basadas en Java.

## Funcionalidades

<u>El formulario está controlado por dos controladores que manejan las solicitudes y respuestas del usuario:</u>

1. **Método POST**: Utilizo `request.getParameterNames()` para obtener los nombres de los parámetros enviados en la solicitud y `request.getParameterValues()` para obtener los valores asociados a esos parámetros mediante un ~~BUCLE~~.
  
2. **Método GET**: Utilizo `getParameterMap()` para acceder a todos los parámetros y sus valores, facilitando el manejo de los datos a través de un ~~MAPA~~.

## Aprendizajes

He aprendido a gestionar formularios en el entorno web, a manejar solicitudes y a implementar servlets y controladores en Java, así como a aplicar estilos con CSS.
