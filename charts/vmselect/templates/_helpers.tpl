{{/*
Expand the name of the chart.
*/}}
{{- define "vmselect.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "vmselect.fullname" -}}
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
{{- define "vmselect.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "vmselect.labels" -}}
helm.sh/chart: {{ include "vmselect.chart" . }}
{{ include "vmselect.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "vmselect.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vmselect.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/part-of: {{ .Values.applicationPartOf | default .Release.Namespace }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "vmselect.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "vmselect.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "victoria-metrics.vmstorage-pod-fqdn" -}}
{{- $pod := .Values.vmstorage.fullname -}}
{{- $svc := .Values.vmstorage.fullname -}}
{{- $namespace := .Release.Namespace -}}
{{- $dnsSuffix := .Values.clusterDomainSuffix | default "cluster.local" -}}
{{- range $i := until (.Values.vmstorage.replicaCount | int) -}}
{{- printf "- --storageNode=%s-%d.%s.%s.svc.%s:8401\n" $pod $i $svc $namespace $dnsSuffix -}}
{{- end -}}
{{- end -}}
