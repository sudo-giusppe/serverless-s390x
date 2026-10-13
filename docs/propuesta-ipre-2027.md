# Caracterización del arranque en frío de funciones serverless en s390x (IBM Z/LinuxONE) frente a x86-64

**Propuesta IPre 2027-1 · 10 créditos · Escuela de Ingeniería UC**

| | |
|---|---|
| Estudiante | [Tu nombre] — Licenciatura en Ingeniería en Ciencia de la Computación (LICC), DCC |
| Mentor propuesto | Prof. Cristian Ruz — Departamento de Ciencia de la Computación |
| Duración | Un semestre (~10 h/semana, ≈ 150 h) |
| Fecha | Octubre 2026 |

## 1. Problema y brecha

En el modelo FaaS, cuando una invocación llega y no hay instancia activa, hay que crear el sandbox, cargar la imagen e inicializar el runtime. Ese **cold start** domina la cola de la distribución de latencias en muchas cargas reales (Shahrad et al., ATC 2020). Casi toda la evidencia pública sobre él proviene de nubes x86 cerradas, sin posibilidad de inspeccionar ni modificar la pila.

**vHive** (EASE Lab, U. de Edinburgh; ASPLOS 2021) es el banco de pruebas abierto de referencia para este tipo de estudios, pero está pensado para x86-64. Estado real del ecosistema (verificado en octubre 2026):

| Componente | ¿Soporta s390x? | Evidencia |
|---|---|---|
| Firecracker | No (solo x86_64, aarch64) | Releases oficiales v1.17.0 |
| gVisor | No (x86_64, ARM64) | README de gVisor |
| Kata Containers | **Sí** | Matriz de soporte: IBM Z & LinuxONE (SIE) |
| vHive (sandboxes) | Firecracker / gVisor / contenedores, **no Kata** | README vHive |
| vSwarm (funciones) | x86 y arm64; s390x requiere compilar | README vSwarm |

Existe, por tanto, una brecha concreta: **no hay evidencia pública y reproducible del comportamiento del cold start serverless en mainframe moderno**, precisamente porque la microVM de referencia no corre en esa arquitectura y la alternativa sí.

## 2. Pregunta e hipótesis

**Pregunta.** ¿Cómo se comparan la latencia de arranque en frío, el rendimiento sostenido y la latencia p99 de un stack Knative sobre s390x frente a uno equivalente sobre x86-64, y qué parte de la diferencia se explica por la capa de sandbox?

- **H1.** A igualdad de recursos, el rendimiento sostenido por núcleo en s390x es competitivo, apoyado en la compresión y criptografía aceleradas por hardware.
- **H2.** Con sandbox `runc`, ambas arquitecturas son comparables; la diferencia aparece al introducir microVM (Firecracker en x86-64, Kata en s390x).
- **H3 (extensión opcional).** Analizar la viabilidad de una estrategia de snapshot con precarga de páginas estilo REAP sobre s390x; solo se implementa si el cronograma lo permite.

## 3. Diseño experimental

- **Dos clústeres equivalentes** (x86-64 y s390x) con Kubernetes + Knative Serving sobre containerd; versión de kernel, recursos de CPU/memoria y de red fijados y normalizados en ambos.
- **Sandboxes comparados:** `runc` vs Kata (s390x) y `runc` vs Firecracker (x86-64), usando *runtime classes* de Kubernetes estándar.
- **Carga:** funciones de la suite vSwarm (AES, fibonacci, compresión, auth) en Go, Python y Node.js; imágenes multiarquitectura construidas con buildx.
- **Escenarios:** invocación en caliente, arranque en frío forzado (escalar a cero) y ráfagas con distribución de llegadas tipo [Shahrad et al. 2020].
- **Métricas y estadística:** latencia p50/p99, cold start, throughput, CPU y memoria; ≥30 repeticiones por condición, mediana e intervalos de confianza.

## 4. Alcance y cronograma (10 créditos)

| Fase | Semanas | Contenido | Criterio de avance |
|---|---|---|---|
| F0 | 1-2 | Acceso a hardware s390x, clúster mínimo, primera función vSwarm en ambas arquitecturas | Primera medición de cold start en s390x |
| F1 | 3-6 | Baseline `runc` en ambas arquitecturas | H2 (mitad): curvas de latencia comparables |
| F2 | 7-10 | Kata en s390x y Firecracker en x86-64 | H1 y H2 completas |
| F3 | 11-14 | Campaña de medición, análisis estadístico, informe | Informe IPre entregado |

**H3** se aborda solo si F3 termina con anticipación; en caso contrario se entrega como análisis de viabilidad (qué requeriría portar REAP a s390x). Esta fase es deliberadamente elástica: si el acceso a hardware se retrasa, el semestre se sostiene sobre el baseline x86-64 + una validación funcional en s390x.

## 5. Viabilidad y riesgos

- **Hardware.** Soy IBM Z Ambassador de la UC; rutas en evaluación: IBM Academic Initiative / IBMZ Xplore, IBM LinuxONE Community Cloud (VMs s390x gratuitas) o apoyo institucional. *Fallback:* emulación QEMU s390x **solo** para validar funcionamiento, nunca para cifras de rendimiento (se declararía explícitamente en el informe).
- **Software.** Verificado en octubre 2026: Kata corre en s390x, Firecracker y gVisor no. Por eso el experimento se monta sobre Kubernetes + Knative estándar con runtime classes, y la integración de Kata al ecosistema vHive queda como posible trabajo futuro, no como requisito.
- **Amenazas a la validez.** Diferencias de hardware, red y almacenamiento entre clústeres; disponibilidad de imágenes s390x. Mitigación: fijar versiones, normalizar recursos, publicar los scripts de medión y reportar la configuración completa.

## 6. Entregables

1. Informe IPre (formato DII-ING) con metodología, resultados, análisis y conclusiones.
2. Repositorio con scripts de despliegue y medición reproducibles, más los datos tabulados.
3. Posible divulgación: portal ING Divulga y/o un paper corto de workshop de sistemas, si los resultados lo ameritan.

## 7. Encaje con la línea del equipo

El estudio es un benchmark comparativo de plataformas de cómputo y sistemas distribuidos: medición de una pila completa (orquestación, sandbox, runtime) en dos arquitecturas distintas, con metodología experimental reproducible. Eso se alinea directamente con las líneas de sistemas distribuidos, HPC y caracterización de rendimiento del Prof. Ruz, y aprovecha el trabajo ya realizado en torno a vHive y Knative.

---

*Fuentes clave: Ustiugov et al., ASPLOS 2021 (vHive/REAP); Agache et al., NSDI 2020 (Firecracker); Shahrad et al., ATC 2020; documentación oficial de Firecracker, Kata Containers, gVisor, vHive y vSwarm consultada en octubre de 2026.*
