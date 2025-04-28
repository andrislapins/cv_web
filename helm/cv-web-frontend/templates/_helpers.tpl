
{{- define "cv-web-frontend.name" -}}
cv-web-frontend
{{- end -}}

{{- define "cv-web-frontend.fullname" -}}
{{ .Release.Name }}-{{ .Chart.Name }}
{{- end -}}