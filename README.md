# Desarrollo Web Entorno Servidor

## Primer proyecto -> GalanGJuanmaInicial

### Estructura del proyecto

* **Web Pages**
  * **META-INF** (contiene el archivo `context.xml`)
  * **WEB-INF** (contiene el archivo `web.xml`)
  * **css** (hojas de estilo CSS)
    - `calculadora.css` (Estilos para `calculadora.jsp`)
    - `divisas.css` (Estilos para `divisas.jsp`)
    - `edad.css` (Estilos para `edad.jsp`)
    - `ejCalculadora.css` (Estilos para `ejCalculadora.jsp`)
    - `form.css` (Estilos para los formularios `datos1.html`, `datos2.html`, `datos3.html`...)
    - `formValidador.css` (Estilos para `Validador.java`)
    - `index.css` (Estilos para `index.html`)
    - `menuCookie.css` (Estilos para `menuCookie.jsp`)
    - `monedero.css` (Estilos para `monedero.jsp`)
    - `numSecreto.css` (Estilos para `numSecreto.jsp`)
    - `peticiones.css` (Estilos para `Peticiones.java`)
    - `respuesta.css` (Estilos para `EnumYmapa.java`, `Enumer.java`, `Mapa.java`...)
    - `resultDivisas.css` (Estilos para el resultado que diera `divisas.jsp`)
    - `resultEdad.css` (Estilos para el resultado que diera `edad.jsp`)
    - `resultMonedero.css` (Estilos para el resultado que diera `monedero.jsp`)
    - `resultNombre.css` (Estilos para el resultado que diera `nombre.jsp`)
    - `saludo.css` (Estilos para `saludo.jsp`)
    - `sesiones.css` (Estilos para `sesiones.jsp`)
    - `usuario.css` (Estilos para `usuario.jsp`)
    - `visitas.css` (Estilos para `visitas.jsp`)
  * **html** (archivos HTML)
    - `datos1.html` (Formulario de ingreso de datos, parte 1)
    - `datos2.html` (Formulario de ingreso de datos, parte 2)
    - `datos3.html` (Formulario de ingreso de datos, parte 3)
    - `divisas.html` (Formulario para una calculadora de divisas)
    - `edad.html` (Formulario para calcular edad de una persona)
    - `monedero.html` (Formulario para monedero)
    - `primerform.html` (Formulario con nombre y apellidos)
    - `saludo.html` (Formulario con nombre y género)
  * **img** (imágenes para el ejercicio `monedero.jsp`)
  * **jsp** (archivos JSP)
    - `calculadora.jsp` (Calculadora básica con las operaciones matemáticas (suma, resta, multiplicación y división) entre dos números ingresados por el usuario)
    - `divisas.jsp` (Conversión de divisas enviadas por el usuario y muestra el resultado)
    - `edad.jsp` (Procesamos la información mediante un formulario, enviando el nombre y la fecha de nacimiento, y este calcula la edad en función de la fecha actual)
    - `ejCalculadora.jsp` (Calculadora básica con la operación matemática de sumar)
    - `menuCookie.jsp` (Gestiono las cookies permitiendo a los usuarios crearlas, modificarlas, visualizarlas y eliminarlas mediante otro JSP -> `operacionCookie.jsp`)
    - `miNombre.jsp` (Almaceno y muestro un nombre de usuario mediante una cookie)
    - `monedero.jsp` (Calculo el cambio de moneda que se tiene que devolver al cliente después de ingresar el precio del producto y lo que entrega el mediante un formulario)
    - `numSecreto.jsp` (Juego en el cual el sistema genera un número aleatorio y el usuario tiene que adivinarlo en el menor número de intentos posibles)
    - `operacionCookie.jsp` (Operaciones para implementar la gestión de cookies en `menuCookies.jsp`)
    - `saludo.jsp` (Genera un mensaje de saludo con la hora actual y el género del usuario)
    - `sesiones.jsp` (Implemento un contador de sesiones y permite eliminar el contador mediante un checkbox)
    - `usuario.jsp` (Implemento un formulario para el inicio de sesión que recuerda al usuario a través de cookies)
    - `visitas.jsp` (Implemento un contador de visitas utilizando cookies)
  * `index.html`
* **Source Packages**
  * `es.albarregas.controladores`
    - `CicloDeVida.java` (Clase que maneja el ciclo de vida de un servlet)
    - `Controlador.java` (Clase que muestra los parámetros enviados desde un formulario y gestiona solicitudes HTTP)
    - `Datos.java` (Clase que maneja solicitudes HTTP y muestra esos parámetros)
    - `EnumYmapa.java` (Clase que maneja los datos con Enumeration y Mapa)
    - `Enumar.java` (Clase que maneja los datos del formulario a través de Enumeration)
    - `Mapa.java` (Clase que maneja los datos del formulario a través de un mapa)
    - `Peticiones.java` (Clase que gestiona las solicitudes HTTP)
    - `Recordador.java` (Clase que recuerda la información del usuario)
    - `Vali_Intermedio.java` (Clase que valida la entrada de usuario y muestra errores si es necesario)
    - `Validador.java` (Clase que valida los datos ingresados en el formulario)
* **Test Packages**
* **Dependencies**
* **Java Dependencies**
* **Project Files**

### Servidor
Este proyecto está desarrollado y desplegado utilizando **Apache Tomcat** o **TomEE**, que proporcionan el entorno necesario para ejecutar aplicaciones web basadas en Java.

### Funcionalidades
Este proyecto implementa múltiples formularios y cálculos interactivos mediante el uso de JSP y servlets. Los controladores gestionan las solicitudes del usuario, permitiendo:

1. **Cálculos Matemáticos**: `calculadora.jsp` permite realizar operaciones matemáticas básicas (suma, resta, multiplicación y división) entre dos números ingresados.
2. **Conversión de Divisas**: `divisas.jsp` convierte diferentes monedas según las tasas ingresadas por el usuario y muestra el resultado.
3. **Cálculo de Edad**: `edad.jsp` calcula la edad del usuario basado en la fecha de nacimiento proporcionada en el formulario.
4. **Gestión de Cookies**: `menuCookie.jsp` y `operacionCookie.jsp` permiten crear, modificar y eliminar cookies para mantener la información del usuario.
5. **Juego de Adivinanza**: `numSecreto.jsp` presenta un juego donde el usuario adivina un número aleatorio generado por el sistema.
6. **Contador de Sesiones y Visitas**: `sesiones.jsp` y `visitas.jsp` implementan contadores utilizando cookies para llevar un registro de las sesiones de usuario y las visitas a la página.

### Aprendizajes
He aprendido a gestionar formularios en el entorno web, a manejar solicitudes y a implementar servlets y controladores en Java, así como a aplicar estilos con CSS.
