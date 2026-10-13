# Estado del arte: soporte de s390x en el stack serverless

Verificación directa sobre los repositorios oficiales, **octubre 2026**. Cada fila se puede re-verificar con el comando indicado; al actualizar, cambiar la fecha y el número de versión.

| Componente | ¿Soporta s390x? | Detalle | Fuente |
|---|---|---|---|
| Firecracker | **No** | Última release v1.17.0 con binarios solo para `x86_64` y `aarch64` | `gh api repos/firecracker-microvm/firecracker/releases/latest` |
| gVisor | **No** | "gVisor builds on x86_64 and ARM64" | README de google/gvisor |
| Kata Containers | **Sí** | Matriz: `s390x` → IBM Z & LinuxONE SIE | README de kata-containers/kata-containers |
| vHive | No directo | Sandboxes: Firecracker (default), gVisor, contenedores; sin Kata | README de vhive-serverless/vhive |
| vSwarm | Parcial | Funciones standalone para x86 y arm64; s390x requiere compilar imágenes | README de vhive-serverless/vSwarm |
| Knative Serving | Por verificar | Go multi-arquitectura; confirmar imágenes publicadas o compilar desde fuente | knative/serving |
| Kubernetes / containerd | Sí | Disponibles para s390x en las distribuciones principales | documentación upstream |

## Consecuencia para el diseño

1. En s390x **no corre el sandbox por defecto de vHive** (Firecracker) ni gVisor. El sandbox de referencia en s390x es **Kata Containers** vía *runtime class* de Kubernetes estándar.
2. El experimento se monta sobre **Kubernetes + Knative + containerd** en ambas arquitecturas, y no sobre vHive completo. vHive queda como marco de referencia metodológico (y como posible trabajo futuro: integrar Kata al ecosistema vHive).
3. Las funciones de vSwarm se compilan como imágenes multi-arquitectura con `docker buildx` (`linux/amd64`, `linux/s390x`).
4. **H3 (REAP)** depende de snapshots de microVM; en s390x habría que evaluar el mecanismo de snapshot de Kata/QEMU. Se trata como extensión opcional.

## Tareas de verificación pendientes

- [ ] Confirmar si Knative Serving publica imágenes `s390x` en la versión que usemos; si no, compilar desde fuente (Go cross-compile).
- [ ] Confirmar qué versión de Kata Containers soporta snapshots y si es utilizable en el entorno de hardware al que tengamos acceso.
- [ ] Revisar releases de vHive y vSwarm antes de fijar versiones en los experimentos.
- [ ] Evaluar `invitro` (load generator del ecosistema vHive) como generador de ráfagas en lugar de un generador propio.
