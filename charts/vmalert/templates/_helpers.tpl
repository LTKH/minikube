{{/*
Expand the name of the chart.
*/}}
{{- define "vmalert.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "vmalert.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "vmalert.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "vmalert.labels" -}}
helm.sh/chart: {{ include "vmalert.chart" . }}
{{ include "vmalert.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "vmalert.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vmalert.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/part-of: {{ .Values.applicationPartOf | default .Release.Namespace }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "vmalert.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "vmalert.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Defines the name of configuration map
*/}}
{{- define "vmalert.configname" -}}
{{- if .Values.configMap -}}
{{- .Values.configMap -}}
{{- else -}}
{{- include "vmalert.fullname" . -}}-config
{{- end -}}
{{- end -}}