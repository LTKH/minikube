{{/*
Expand the name of the chart.
*/}}
{{- define "couchdb.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "couchdb.fullname" -}}
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
{{- define "couchdb.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "couchdb.labels" -}}
helm.sh/chart: {{ include "couchdb.chart" . }}
{{ include "couchdb.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "couchdb.selectorLabels" -}}
app.kubernetes.io/name: {{ include "couchdb.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "couchdb.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "couchdb.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Fail if couchdbConfig.couchdb.uuid is undefined
*/}}
{{- define "couchdb.uuid" -}}
{{- required "A value for couchdbConfig.couchdb.uuid must be set" (.Values.couchdbConfig.couchdb | default dict).uuid -}}
{{- end -}}

{{/*
Generates a comma delimited list of nodes in the cluster
*/}}
{{- define "couchdb.seedlist" -}}
{{- $nodeCount :=  min 5 .Values.clusterSize | int }}
  {{- range $index0 := until $nodeCount -}}
    {{- $index1 := $index0 | add1 -}}
    {{ $.Values.erlangFlags.name }}@{{ template "couchdb.fullname" $ }}-{{ $index0 }}.{{ template "couchdb.fullname" $ }}.{{ $.Release.Namespace }}.svc.{{ $.Values.dns.clusterDomainSuffix }}{{ if ne $index1 $nodeCount }},{{ end }}
  {{- end -}}
{{- end -}}
