/*
  # Crear tablas para sistema de preguntas educativas

  1. Nuevas Tablas
    - `categorias`
      - `id` (uuid, primary key)
      - `nombre` (text) - Nombre de la categoría (ej: "Apache Spark", "Machine Learning")
      - `descripcion` (text) - Descripción de la categoría
      - `created_at` (timestamptz)
    
    - `preguntas`
      - `id` (uuid, primary key)
      - `pregunta` (text) - Texto de la pregunta
      - `opciones` (jsonb) - Array de opciones de respuesta
      - `correcta` (integer) - Índice de la respuesta correcta (0-3)
      - `dificultad` (text) - Nivel: facil, medio, dificil
      - `categoria_id` (uuid) - Referencia a categorías
      - `explicacion` (text) - Explicación de la respuesta correcta
      - `created_at` (timestamptz)
      - `updated_at` (timestamptz)
    
    - `resultados`
      - `id` (uuid, primary key)
      - `jugador1_nombre` (text)
      - `jugador1_puntos` (integer)
      - `jugador1_correctas` (integer)
      - `jugador1_incorrectas` (integer)
      - `jugador2_nombre` (text)
      - `jugador2_puntos` (integer)
      - `jugador2_correctas` (integer)
      - `jugador2_incorrectas` (integer)
      - `modo_juego` (text)
      - `dificultad` (text)
      - `created_at` (timestamptz)

  2. Seguridad
    - Habilitar RLS en todas las tablas
    - Permitir lectura pública de categorías y preguntas
    - Permitir inserción pública de resultados (para guardar estadísticas)
*/

-- Crear tabla de categorías
CREATE TABLE IF NOT EXISTS categorias (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  nombre text NOT NULL,
  descripcion text DEFAULT '',
  created_at timestamptz DEFAULT now()
);

-- Crear tabla de preguntas
CREATE TABLE IF NOT EXISTS preguntas (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  pregunta text NOT NULL,
  opciones jsonb NOT NULL,
  correcta integer NOT NULL CHECK (correcta >= 0 AND correcta <= 3),
  dificultad text NOT NULL CHECK (dificultad IN ('facil', 'medio', 'dificil')),
  categoria_id uuid REFERENCES categorias(id) ON DELETE SET NULL,
  explicacion text DEFAULT '',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Crear tabla de resultados
CREATE TABLE IF NOT EXISTS resultados (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  jugador1_nombre text NOT NULL DEFAULT 'Jugador 1',
  jugador1_puntos integer DEFAULT 0,
  jugador1_correctas integer DEFAULT 0,
  jugador1_incorrectas integer DEFAULT 0,
  jugador2_nombre text NOT NULL DEFAULT 'Jugador 2',
  jugador2_puntos integer DEFAULT 0,
  jugador2_correctas integer DEFAULT 0,
  jugador2_incorrectas integer DEFAULT 0,
  modo_juego text DEFAULT 'clasico',
  dificultad text DEFAULT 'medio',
  created_at timestamptz DEFAULT now()
);

-- Habilitar RLS
ALTER TABLE categorias ENABLE ROW LEVEL SECURITY;
ALTER TABLE preguntas ENABLE ROW LEVEL SECURITY;
ALTER TABLE resultados ENABLE ROW LEVEL SECURITY;

-- Políticas para categorías (lectura pública)
CREATE POLICY "Permitir lectura pública de categorías"
  ON categorias FOR SELECT
  TO public
  USING (true);

-- Políticas para preguntas (lectura pública)
CREATE POLICY "Permitir lectura pública de preguntas"
  ON preguntas FOR SELECT
  TO public
  USING (true);

-- Políticas para resultados (lectura y escritura pública)
CREATE POLICY "Permitir lectura pública de resultados"
  ON resultados FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Permitir inserción pública de resultados"
  ON resultados FOR INSERT
  TO public
  WITH CHECK (true);

-- Índices para mejorar rendimiento
CREATE INDEX IF NOT EXISTS idx_preguntas_dificultad ON preguntas(dificultad);
CREATE INDEX IF NOT EXISTS idx_preguntas_categoria ON preguntas(categoria_id);
CREATE INDEX IF NOT EXISTS idx_resultados_created_at ON resultados(created_at DESC);