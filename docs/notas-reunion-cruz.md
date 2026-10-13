# Notas para la reunión con el Prof. Cristian Ruz

Oficina DCC · objetivos, guion de 5 minutos, preguntas probables y fechas.

## Los 3 objetivos de la reunión

1. **Que acepte ser mentor** de tu IPre 2027-1.
2. **Que publique la oportunidad en Gestión IPre** antes de la toma de ramos del semestre 2027-1 (sin eso no existe el NRC y no puedes inscribir el ramo).
3. **Que quede definido el alcance**: fases F0-F3, frecuencia de reuniones y formato del informe.

## Guion de 5 minutos

1. **Contexto (30 s).** "Vengo a proponerle una IPre para 2027-1. La idea es caracterizar el *cold start* serverless en s390x (IBM Z) comparado con x86-64, con Knative y funciones vSwarm. Está en el cruce entre sistemas distribuidos y benchmarking de plataformas."
2. **La brecha (1 min).** "Firecracker no publica binarios s390x (solo x86_64/aarch64) y gVisor tampoco corre ahí, pero Kata Containers sí soporta IBM Z. Nadie ha publicado evidencia reproducible de cómo arranca una función serverless en mainframe moderno. Eso es lo que quiero medir."
3. **Qué tan lejos quiero llegar (1 min).** H1 (rendimiento/núcleo), H2 (runc igual en ambas; la diferencia viene del sandbox), H3 (snapshot tipo REAP) como extensión opcional, no comprometida.
4. **Por qué es viable (1 min).** Soy IBM Z Ambassador de la UC y tengo vías de acceso a hardware s390x (Academic Initiative, LinuxONE Community Cloud). El plan por fases tiene criterio de avance en cada fase y es elástico si el hardware se atrasa.
5. **El pedido concreto (1 min).** Que publique la oportunidad en Gestión IPre, que postules tú, y quedar en reuniones [semanales/quincenales] de avance. Preguntarle si quiere recortar o enfocar el alcance.

## Preguntas que probablemente hará — y respuestas

**"¿Por qué s390x, qué nos importa a nosotros?"**
El mainframe moderno ya corre Linux, Kubernetes y contenedores (OpenShift Serverless existe para IBM Z), pero su caracterización serverless es escasa en la literatura. Es una ventana de publicación abierta y, además, tengo acceso real a la plataforma como IBM Z Ambassador.

**"¿Es realista en un semestre con 10 créditos?"**
Sí, por el diseño en fases. F0-F2 son infraestructura y medición incremental; F3 es la campaña seria. H3 no está comprometida: si no alcanza, se entrega como análisis de viabilidad. Hay un criterio de avance por fase para cortar a tiempo.

**"¿Y vHive, no lo usamos?"**
vHive es el punto de partida y el estado del arte, pero sus sandboxes (Firecracker, gVisor) no corren en s390x. Por eso el experimento se monta sobre Kubernetes + Knative estándar con runtime classes; dejaría documentado qué costaría integrar Kata al ecosistema vHive como posible trabajo futuro. También es una contribución posible del proyecto.

**"¿De dónde sale el hardware?"**
IBM Z Ambassador → Academic Initiative / IBMZ Xplore; IBM LinuxONE Community Cloud (VMs s390x gratuitas); o apoyo institucional de la UC. Si todo falla, QEMU s390x solo para validar funcionamiento, nunca para cifras de rendimiento, y eso se declara en el informe.

**"¿Qué pasa si no consigo publicar la oportunidad a tiempo?"**
Plan B: la IPre central de verano/invierno (VRIP) es otra vía, o se corre la IPre al semestre siguiente. Por eso conviene cerrar esto ahora.

**"¿Qué necesitas de mí?"**
Publicar la oportunidad en Gestión IPre (te guía la plataforma), revisar el diseño y el informe, reuniones de avance, y apoyo con firmas/gestiones si se requiere.

## Fechas y reglas del proceso IPre (Escuela de Ingeniería)

- Cursos IPre: nivel 2000, **5, 10 o 20 créditos** (10 créditos ≈ 10 h/semana), duración máxima de un semestre, **no retirables** una vez inscritos en Banner.
- Flujo: el profesor **publica la oportunidad en Gestión IPre** (puede hacerlo todo el año, pero debe estar publicada antes de la toma de ramos de 2027-1) → tú postulas → él tiene **14 días** para aceptar → tú tienes **14 días** para confirmar → se crea el curso y te dan el **NRC** → lo inscribes en Banner.
- Al cierre del semestre: informe final subido a Gestión IPre (si llega tarde: −1 punto; si pasa el semestre siguiente: −2; si nunca llega: se reprueba).
- Consultas de fechas exactas de postulación 2027-1: coordinación IPre, `ipre.ing@uc.cl`.

## Antes de ir

- [ ] Completar `[Tu nombre]` en la propuesta (Markdown y HTML).
- [ ] Revisar el avance curricular con DIPRE/orientador docente: dónde calzan los 10 créditos IPre en tu malla (OPI/OFG/optativo).
- [ ] Revisar Gestión IPre con tu usuario SIDING: ¿Ruz ya publicó oportunidades?
- [ ] Llevar impresa la propuesta (`propuesta-ipre-2027.html`, ~2 páginas A4) o abrirla en el notebook.
