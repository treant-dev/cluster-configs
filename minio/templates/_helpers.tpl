{{/*
Expand the name of the chart
*/}}

{{- define "_helpers-minio.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}