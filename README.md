#  Duelo de Preguntas

##  Descripción del proyecto
**Duelo de Preguntas** es un juego web interactivo de preguntas y respuestas. El usuario responde preguntas de opción múltiple, recibe retroalimentación inmediata (**Correcto ✅ / Incorrecto ❌**), acumula puntaje y al finalizar observa un resumen en la pantalla de resultados.  
El proyecto está organizado en varias páginas (Inicio, Configuración, Juego, Resultados y Créditos) y puede registrar resultados usando **Supabase**.

---

##  Esquema general del funcionamiento
El juego sigue esta lógica general:

1. **El usuario inicia el juego** desde la pantalla de inicio.
2. **Configura la partida** (opciones previas como dificultad o modo, si existen).
3. **Se cargan las preguntas** (desde un archivo JavaScript o desde Supabase según configuración).
4. **Se muestra una pregunta** con alternativas.
5. **El usuario selecciona una alternativa**.
6. **Se valida la respuesta**:
   - Si es correcta: suma puntos.
   - Si es incorrecta: no suma (o resta, si el proyecto lo definió así).
7. **El juego avanza** a la siguiente pregunta hasta completar el total.
8. **Se muestran los resultados finales** y (si está configurado) se guardan en Supabase.

---

##  Flujo de navegación (pantallas)
El recorrido típico del usuario es:

- `index.html` → `configuracion.html` → `juego.html` → `resultados.html` → `creditos.html`

###  Inicio — `index.html`
- Presentación del proyecto.
- Botón para iniciar o continuar.

  <img width="1019" height="852" alt="image" src="https://github.com/user-attachments/assets/4ebbfe9e-6a10-4e33-9f33-c66cb0c8782e" />

###  Configuración — `configuracion.html`
- Selección de opciones antes de jugar.
- Botón para comenzar partida.

<img width="1021" height="937" alt="image" src="https://github.com/user-attachments/assets/429da4e5-f4b6-4436-9517-cc9104e878cd" />

###  Juego — `juego.html`
- Pantalla principal donde se muestran:
  - pregunta,
  - alternativas,
  - puntaje actual,
  - mensajes de validación (correcto/incorrecto),
  - avance de preguntas.

<img width="1035" height="897" alt="image" src="https://github.com/user-attachments/assets/ce360111-5f73-4282-9da1-c0960e904b74" />

###  Resultados — `resultados.html`
- Muestra:
  - puntaje final,
  - resumen de desempeño (si aplica),
  - opción de reiniciar o volver al inicio,
  - consulta/registro en Supabase (si aplica).

<img width="1019" height="921" alt="image" src="https://github.com/user-attachments/assets/66b7b0f2-b78d-46ef-b28a-a36ad72c6021" />

###  Créditos — `creditos.html`
- Información del curso y los integrantes del proyecto.

<img width="662" height="960" alt="image" src="https://github.com/user-attachments/assets/d1f3c4e5-7ead-49e1-b88b-8a2f7104231a" />

---

##  Componentes típicos de la pantalla de juego
En `juego.html` normalmente se trabajan estas partes:

- **Encabezado del juego**: título o información del modo.
- **Área de pregunta**: texto principal.
- **Área de opciones**: botones con alternativas.
- **Zona de feedback**: mensaje de correcto/incorrecto.
- **Panel de puntaje**: puntos acumulados.
- **Control de avance**: siguiente pregunta / finalizar (si existe).

---

##  Estructura del proyecto

mi-proyecto/
├─ public/
│  └─ preguntas.js
├─ supabase/
│  └─ migrations/
│     └─ 2026010813531_create_preguntas_table.sql
├─ css/
│  ├─ index.css
│  ├─ configuracion.css
│  ├─ juego.css
│  ├─ resultados.css
│  └─ creditos.css
├─ js/
│  ├─ preguntas.js
│  └─ supabaseClient.js
├─ index.html
├─ configuracion.html
├─ juego.html
├─ resultados.html
├─ creditos.html
├─ package.json
└─ package-lock.json

---

##  ¿Qué contiene cada carpeta/archivo?

### `public/`
- `preguntas.js`: archivo que puede contener el banco de preguntas o datos que se cargan para el juego.

### `supabase/`
- `migrations/2026010813531_create_preguntas_table.sql`: script SQL para crear la tabla de preguntas (y/o estructuras necesarias) en Supabase.

### `css/`
- `index.css`: estilos de la pantalla de inicio.
- `configuracion.css`: estilos de la pantalla de configuración.
- `juego.css`: estilos de la pantalla principal del juego.
- `resultados.css`: estilos de la pantalla de resultados.
- `creditos.css`: estilos de la pantalla de créditos.

### `js/`
- `preguntas.js`: lógica relacionada con preguntas (selección, renderizado, validación, etc.).
- `supabaseClient.js`: conexión y funciones para interactuar con Supabase (guardar/consultar resultados).

### HTML principales
- `index.html`: pantalla inicial.
- `configuracion.html`: pantalla de configuración.
- `juego.html`: pantalla de juego.
- `resultados.html`: pantalla de resultados.
- `creditos.html`: pantalla de créditos.

### Archivos de proyecto
- `package.json`: configuración del proyecto (dependencias, scripts).
- `package-lock.json`: bloqueo de versiones instaladas.

---

##  Supabase (qué se guarda y para qué)
Supabase se utiliza como base de datos en la nube para:

- **Guardar resultados**: puntaje final, fecha/hora, nombre del jugador (si existe), etc.
- **Consultar resultados**: historial o ranking (si el proyecto lo muestra).

> La conexión y las operaciones se gestionan desde `js/supabaseClient.js`.

---

##  Reglas de puntaje (esquema sugerido)
El sistema de puntaje puede funcionar así (ajustable según tu implementación):

- Respuesta correcta: **+10 puntos**
- Respuesta incorrecta: **0 puntos**
- (Opcional) Penalización: **-5 puntos** por error
- (Opcional) Bonus: **+5 puntos** por racha de correctas

---

##  Recomendaciones de uso
- Mantener el banco de preguntas organizado (tema/categoría/dificultad si aplica).
- Verificar que cada pregunta tenga:
  - enunciado,
  - opciones,
  - una respuesta correcta válida.
- Probar el flujo completo: inicio → configuración → juego → resultados.

---

## Menu de opciones

<img width="1426" height="672" alt="image" src="https://github.com/user-attachments/assets/f7e9cc0a-eca5-4e1e-8724-189b565fbce4" />

---

## Banco de preguntas (Con Sus Respuestas)

<img width="1081" height="869" alt="image" src="https://github.com/user-attachments/assets/f8660601-a7ca-485c-b2bc-161b57063ff6" />

---

##  Integrantes
- Integrante 1: Wilian Yuber Condori Ccama — 235887
- Integrante 2: Cristhian Andre Mestas Lipa — 240445
- Integrante 3: Aderly Josoe Avendaño Morales — 240364

Curso: **Desarrollo de Plataformas I**  
Semestre: **III**
