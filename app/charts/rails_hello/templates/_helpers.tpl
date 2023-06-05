{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "everlyhealth_rails_hello.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "everlyhealth_rails_hello.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "everlyhealth_rails_hello.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Generate basic labels
*/}}
{{- define "everlyhealth_rails_hello.labels" }}
helm.sh/chart: {{ include "everlyhealth_rails_hello.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: {{ template "everlyhealth_rails_hello.name" . }}
{{- include "everlyhealth_rails_hello.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- if .Values.customLabels }}
{{ toYaml .Values.customLabels }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "everlyhealth_rails_hello.selectorLabels" }}
app.kubernetes.io/name: {{ include "everlyhealth_rails_hello.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/* Compile all validation warnings into a single message and call fail. */}}
{{- define "mychart.validateValues" -}}
{{- $messages := list -}}
{{- $messages = append $messages (include "mychart.validateValues.roleArn" .) -}}
{{- $messages = append $messages (include "mychart.validateValues.serviceAccountName" .) -}}
{{- $messages = without $messages "" -}}
{{- $message := join "\n" $messages -}}

{{- if $message -}}
{{- printf "\nVALUES VALIDATION:\n%s" $message | fail -}}
{{- end -}}
{{- end -}}

{{/* Validate value of roleArn */}}
{{- define "everlyhealth_rails_hello.validateValues.roleArn" -}}
{{- if not (and .Values.roleArn (kindIs "string" .Values.roleArn)) -}}
everlyhealth_rails_hello: roleArn
    `roleArn` is required and should be a valid IRSA role ARN.
{{- end -}}
{{- end -}}

{{/* Validate value of serviceAccountName */}}
{{- define "everlyhealth_rails_hello.validateValues.serviceAccountName" -}}
{{- if not (and .Values.roleArn (kindIs "string" .Values.serviceAccountName)) -}}
everlyhealth_rails_hello: serviceAccountName
    `serviceAccountName` is required.
{{- end -}}
{{- end -}}
