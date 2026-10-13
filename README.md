# serverless-s390x

Caracterización del arranque en frío (*cold start*) de funciones serverless en **s390x (IBM Z / LinuxONE)** frente a **x86-64**, con un stack Kubernetes + Knative y funciones de la suite vSwarm.

Proyecto de Investigación en Pregrado (IPre) 2027-1, Escuela de Ingeniería UC — Departamento de Ciencia de la Computación.

## Pregunta de investigación

¿Cómo se comparan la latencia de arranque en frío, el rendimiento sostenido y la latencia p99 de un stack Knative sobre s390x frente a uno equivalente sobre x86-64, y qué parte de la diferencia se explica por la capa de sandbox?

## Hipótesis

- **H1.** A igualdad de recursos, el rendimiento sostenido por núcleo en s390x es competitivo (compresión y criptografía aceleradas por hardware).
- **H2.** Con sandbox `runc`, ambas arquitecturas son comparables; la diferencia aparece al introducir microVM (Firecracker en x86-64, Kata en s390x).
- **H3 (opcional).** Viabilidad de una estrategia de snapshot con precarga de páginas estilo REAP sobre s390x; solo se implementa si el cronograma lo permite.

## Brecha (estado del ecosistema, verificado en octubre 2026)

| Componente | ¿Soporta s390x? | Evidencia |
|---|---|---|
| [Firecracker](https://github.com/firecracker-microvm/firecracker) | No (solo x86_64, aarch64) | Releases oficiales v1.17.0 |
| [gVisor](https://github.com/google/gvisor) | No (x86_64, ARM64) | README upstream |
| [Kata Containers](https://github.com/kata-containers/kata-containers) | **Sí** | Matriz de soporte: IBM Z & LinuxONE (SIE) |
| [vHive](https://github.com/vhive-serverless/vhive) (sandboxes) | Firecracker / gVisor / contenedores, no Kata | README vHive |
| [vSwarm](https://github.com/vhive-serverless/vSwarm) (funciones) | x86 y arm64; s390x requiere compilar | README vSwarm |

No existe evidencia pública y reproducible del comportamiento del cold start serverless en mainframe moderno: la microVM de referencia no corre en s390x y la alternativa (Kata) no está integrada al ecosistema vHive. Este repo ataca esa brecha.

## Estado actual

**Fase 0** — propuesta lista, pendiente de mentoría y de acceso a hardware s390x (IBM Z Ambassador: IBM Academic Initiative / IBMZ Xplore, IBM LinuxONE Community Cloud, o apoyo institucional). Todavía no hay mediciones.

## Roadmap

| Fase | Contenido | Criterio de avance |
|---|---|---|
| F0 | Acceso a hardware s390x, clúster mínimo, primera función vSwarm en ambas arquitecturas | Primera medición de cold start en s390x |
| F1 | Baseline `runc` en ambas arquitecturas | Curvas de latencia comparables |
| F2 | Kata en s390x y Firecracker en x86-64 | H1 y H2 completas |
| F3 | Campaña de medición, análisis estadístico, informe | Informe IPre entregado |

## Estructura del repo

```
docs/        propuesta, notas de reunión y estado del arte
infra/       scripts de provisionamiento (x86/ y s390x/)
cluster/     manifiestos de Kubernetes y Knative, runtime classes
bench/       wrappers de vSwarm y perfiles de carga
analysis/    scripts de estadística y figuras
results/     datos crudos (CSV) y figuras derivadas
```

## Reproducibilidad

El objetivo es que cada medición sea repetible: versiones de kernel y de cada componente fijadas, recursos de CPU/memoria/red normalizados entre ambos clústeres, ≥30 repeticiones por condición y reporte de mediana, p99 e intervalos de confianza. Los scripts de despliegue y medición quedarán en `infra/` y `bench/`.

## Referencias

- D. Ustiugov et al. *Benchmarking, Analysis, and Optimization of Serverless Function Snapshots.* ASPLOS 2021 (vHive, REAP).
- A. Agache et al. *Firecracker: Lightweight Virtualization for Serverless Applications.* USENIX NSDI 2020.
- M. Shahrad et al. *Serverless in the Wild.* USENIX ATC 2020.

## Licencia

[MIT](LICENSE)
