{{/* vim: set filetype=gohtmltmpl: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "kubefarm.name" -}}
{{- default "kubefarm" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "kubefarm.fullname" -}}
{{- $name := default "kubefarm" .Values.nameOverride -}}
{{- if eq (.Release.Name | upper) "RELEASE-NAME" -}}
{{- $name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}


{{- define "kubefarm.kubernetesLabels" -}}
{{- $local := dict "first" true -}}
{{- range $k, $v := . -}}
{{- if not $local.first -}},{{- end -}}
{{ $k }}={{ $v }}
{{- $_ := set $local "first" false -}}
{{- end -}}
{{- end -}}

{{- define "kubefarm.kubernetesTaints" -}}
{{- $local := dict "first" true -}}
{{- range $t := . -}}
{{- if not $local.first -}},{{- end -}}
{{ $t.key }}={{ $t.value | default "" }}:{{ $t.effect }}
{{- $_ := set $local "first" false -}}
{{- end -}}
{{- end -}}