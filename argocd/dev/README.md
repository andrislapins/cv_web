# argocd-cv-web-dev

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![AppVersion: 0.0.1](https://img.shields.io/badge/AppVersion-0.0.1-informational?style=flat-square)

A Helm chart for DEV cv-web

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| general.appNamespace | string | `"cv-web-dev-ns"` |  |
| general.backendHelmChartVersion | string | `"0.1.6"` |  |
| general.backendImageTag | string | `"2025-04-28-2000-3cfae7a"` |  |
| general.backendIngressURL | string | `"cv-web-api-dev.andrefeuille.com"` |  |
| general.backendInnerUrl | string | `"http://cv-web-backend-dev-cv-web-backend:8080/"` |  |
| general.dbHost | string | `"postgresql.cv-web-dev-ns.svc.cluster.local"` |  |
| general.dbName | string | `"cv_web"` |  |
| general.dbReset | string | `"false"` |  |
| general.dbUsernameApp | string | `"app_user"` |  |
| general.dbUsernameFlyway | string | `"app_user_flyway"` |  |
| general.flywayCleanDisabled | string | `"false"` |  |
| general.frontendHelmChartVersion | string | `"0.1.17"` |  |
| general.frontendImageTag | string | `"2025-05-01-1500-d2f8818"` |  |
| general.frontendIngressURL | string | `"cv-web-dev.andrefeuille.com"` |  |
| general.temporalPort | int | `7233` |  |
| general.temporalUrl | string | `"temporal-frontend.cv-web-dev-ns.svc.cluster.local"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
