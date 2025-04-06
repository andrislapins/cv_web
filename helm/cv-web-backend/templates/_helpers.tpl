{{- define "cv-web-backend.name" -}}
cv-web-backend
{{- end -}}

{{- define "cv-web-backend.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end -}}