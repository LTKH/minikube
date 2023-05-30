{{/*
Expand the name of the chart.
*/}}
{{- define "vminsert.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "vminsert.fullname" -}}
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
{{- define "vminsert.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "vminsert.labels" -}}
helm.sh/chart: {{ include "vminsert.chart" . }}
{{ include "vminsert.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "vminsert.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vminsert.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- if .Values.applicationPartOf }}
app.kubernetes.io/part-of: {{ .Values.applicationPartOf }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "vminsert.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "vminsert.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "victoria-metrics.vmstorage-pod-fqdn" -}}
{{- $pod := .Values.vmstorage.fullname -}}
{{- $svc := .Values.vmstorage.fullname -}}
{{- $namespace := .Release.Namespace -}}
{{- $dnsSuffix := .Values.clusterDomainSuffix -}}
{{- range $i := until (.Values.vmstorage.replicaCount | int) -}}
{{- printf "- --storageNode=%s-%d.%s.%s.svc.%s:8400\n" $pod $i $svc $namespace $dnsSuffix -}}
{{- end -}}
{{- end -}}
