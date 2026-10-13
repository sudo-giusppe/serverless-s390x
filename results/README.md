# results

Datos crudos de medición y figuras derivadas.

## Convención de nombres

```
results/<arquitectura>-<sandbox>-<funcion>-<escenario>-<fecha>.csv

ej: results/s390x-kata-aes-cold-2027-03-15.csv
    results/x86-firecracker-fibonacci-hot-2027-03-15.csv
```

Columnas mínimas esperadas por corrida:

| columna | descripción |
|---|---|
| `timestamp` | ISO-8601 del inicio de la invocación |
| `arch` | `x86_64` o `s390x` |
| `sandbox` | `runc`, `kata` o `firecracker` |
| `function` | nombre de la función vSwarm |
| `scenario` | `hot`, `cold` o `burst` |
| `latency_ms` | latencia extremo a extremo |
| `status` | código HTTP o estado de la invocación |
| `mem_mb`, `cpu_pct` | uso reportado del pod (si está disponible) |

## Política de versionado

- Los CSV crudos **no se commitean** (ver `.gitignore`); se publican junto al informe o en un release.
- Excepción: `results/sample/` puede contener un CSV pequeño de ejemplo para validar el pipeline de análisis.
- Cuando los datos crezcan, migrar a Git LFS o a un release de GitHub.
