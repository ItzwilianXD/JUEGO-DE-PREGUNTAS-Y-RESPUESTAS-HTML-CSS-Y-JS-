import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

export async function cargarPreguntas() {
    try {
        const { data, error } = await supabase
            .from('preguntas')
            .select(`
                *,
                categoria:categorias(nombre, descripcion)
            `)
            .order('created_at', { ascending: true });

        if (error) {
            console.error('Error cargando preguntas:', error);
            return [];
        }

        return data.map(p => ({
            pregunta: p.pregunta,
            opciones: p.opciones,
            correcta: p.correcta,
            dificultad: p.dificultad,
            categoria: p.categoria?.nombre || 'Sin categoría',
            explicacion: p.explicacion || ''
        }));
    } catch (error) {
        console.error('Error en cargarPreguntas:', error);
        return [];
    }
}

export async function cargarCategorias() {
    try {
        const { data, error } = await supabase
            .from('categorias')
            .select('*')
            .order('nombre');

        if (error) {
            console.error('Error cargando categorías:', error);
            return [];
        }

        return data;
    } catch (error) {
        console.error('Error en cargarCategorias:', error);
        return [];
    }
}

export async function guardarResultado(resultados) {
    try {
        const { data, error } = await supabase
            .from('resultados')
            .insert([{
                jugador1_nombre: resultados.jugador1.nombre,
                jugador1_puntos: resultados.jugador1.puntos,
                jugador1_correctas: resultados.jugador1.correctas,
                jugador1_incorrectas: resultados.jugador1.incorrectas,
                jugador2_nombre: resultados.jugador2.nombre,
                jugador2_puntos: resultados.jugador2.puntos,
                jugador2_correctas: resultados.jugador2.correctas,
                jugador2_incorrectas: resultados.jugador2.incorrectas,
                modo_juego: resultados.modo,
                dificultad: resultados.dificultad
            }])
            .select();

        if (error) {
            console.error('Error guardando resultado:', error);
            return null;
        }

        return data;
    } catch (error) {
        console.error('Error en guardarResultado:', error);
        return null;
    }
}

export async function obtenerEstadisticas() {
    try {
        const { data, error } = await supabase
            .from('resultados')
            .select('*')
            .order('created_at', { ascending: false })
            .limit(10);

        if (error) {
            console.error('Error obteniendo estadísticas:', error);
            return [];
        }

        return data;
    } catch (error) {
        console.error('Error en obtenerEstadisticas:', error);
        return [];
    }
}
