# ./foo.ps1 -stage 'io' `
# -io_url 'http://47e7-98-164-202-58.ngrok.io' `
# -io_token 'my---io_token' `
# -project_name 'akshayme-synp/insecure-bank' `
# -scm_type 'github' `
# -scm_owner 'akshayme-synp' `
# -scm_repo_name 'insecure-bank' `
# -scm_branch_name 'master' `
# -github_username 'akshayme-synp' `
# -github_access_token 'my---github_access_token' `
# -gitlab_url 'https://www.gitlab.com' `
# -gitlab_token 'my---gitlab_token' `
# -persona 'devsecops' `
# -release_type 'minor' `
# -polaris_project_name 'akshayme-synp/insecure-bank' `
# -polaris_server_url 'https://csprod.polaris.synopsys.com' `
# -polaris_access_token 'my---polaris_access_token' `
# -is_sast_enabled 'true'

param(
    [Parameter()]
    [string]$io_url,

    [Parameter()]
    [string]$ioiq_url="$io_url/api/ioiq",

    [Parameter()]
    [string]$workflow_url="$io_url/api/workflowengine",

    [Parameter()]
    [string]$io_token,

    [Parameter()]
    [string]$io_manifest_url,

    [Parameter()]
    [string]$stage,

    [Parameter()]
    [string]$workflow_version,

    [Parameter()]
    [string]$persona,

    [Parameter()]
    [string]$configFile="io-manifest.json",

    [Parameter()]
    [string]$project_name,

    [Parameter()]
    [string]$release_type,

    [Parameter()]
    [string]$slack_channel_id,

    [Parameter()]
    [string]$slack_token,

    [Parameter()]
    [string]$msteams_webhook_url,

    [Parameter()]
    [string]$enable_jira="false",

    [Parameter()]
    [string]$jira_project_name,

    [Parameter()]
    [string]$jira_assignee,

    [Parameter()]
    [string]$jira_api_url,

    [Parameter()]
    [string]$jira_issues_query,

    [Parameter()]
    [string]$jira_username,

    [Parameter()]
    [string]$jira_auth_token,

    [Parameter()]
    [string]$rally_project_name,

    [Parameter()]
    [string]$rally_assignee,

    [Parameter()]
    [string]$rally_api_url,

    [Parameter()]
    [string]$rally_auth_token,

    [Parameter()]
    [string]$bitbucket_commit_id,

    [Parameter()]
    [string]$bitbucket_username,

    [Parameter()]
    [string]$bitbucket_password,

    [Parameter()]
    [string]$github_owner_name,

    [Parameter()]
    [string]$github_repo_name,

    [Parameter()]
    [string]$github_ref,

    [Parameter()]
    [string]$github_commit_id,

    [Parameter()]
    [string]$github_username,

    [Parameter()]
    [string]$github_access_token,

    [Parameter()]
    [string]$gitlab_url,

    [Parameter()]
    [string]$gitlab_token,

    [Parameter()]
    [string]$polaris_project_name,

    [Parameter()]
    [string]$polaris_server_url,

    [Parameter()]
    [string]$polaris_access_token,

    [Parameter()]
    [string]$blackduck_project_name,

    [Parameter()]
    [string]$blackduck_server_url,

    [Parameter()]
    [string]$blackduck_access_token,

    [Parameter()]
    [string]$coverity_server_url,

    [Parameter()]
    [string]$coverity_stream,

    [Parameter()]
    [string]$coverity_username,

    [Parameter()]
    [string]$coverity_password,

    [Parameter()]
    [string]$seeker_project_name,

    [Parameter()]
    [string]$seeker_server_url,

    [Parameter()]
    [string]$seeker_access_token,

    [Parameter()]
    [string]$codedx_server_url,

    [Parameter()]
    [string]$codedx_api_key,

    [Parameter()]
    [string]$codedx_project_id,

    [Parameter()]
    [string]$codedx_min_risk_score,

    [Parameter()]
    [string]$is_sast_enabled="false",

    [Parameter()]
    [string]$is_sca_enabled="false",

    [Parameter()]
    [string]$is_dast_enabled="false",

    [Parameter()]
    [string]$scm_type,

    [Parameter()]
    [string]$scm_owner,

    [Parameter()]
    [string]$scm_repo_name,

    [Parameter()]
    [string]$scm_branch_name
)

Write-Host "Synopsys Intelligent Security Scan - Copyright 2020-2021 Synopsys, Inc. All rights reserved worldwide."

Write-Host "configFile value is $configFile"

$synopsys_io_manifest = get-content io-manifest.json -Raw
# Write-Host "synopsys_io_manifest value is $synopsys_io_manifest"

$synopsys_io_manifest = $synopsys_io_manifest `
    -replace '<<PROJECT_NAME>>', $project_name `
    -replace '<<RELEASE_TYPE>>', $release_type `
    -replace '<<SLACK_CHANNEL_ID>>', $slack_channel_id `
    -replace '<<SLACK_TOKEN>>', $slack_token `
    -replace '<<MSTEAMS_WEBHOOK_URL>>', $msteams_webhook_url `
    -replace '<<ENABLE_JIRA>>', $enable_jira `
    -replace '<<JIRA_PROJECT_NAME>>', $jira_project_name `
    -replace '<<JIRA_ASSIGNEE>>', $jira_assignee `
    -replace '<<JIRA_API_URL>>', $jira_api_url `
    -replace '<<JIRA_ISSUES_QUERY>>', $jira_issues_query `
    -replace '<<JIRA_USERNAME>>', $jira_username `
    -replace '<<JIRA_AUTH_TOKEN>>', $jira_auth_token `
    -replace '<<RALLY_PROJECT_NAME>>', $rally_project_name `
    -replace '<<RALLY_ASSIGNEE>>', $rally_assignee `
    -replace '<<RALLY_API_URL>>', $rally_api_url `
    -replace '<<RALLY_AUTH_TOKEN>>', $rally_auth_token `
    -replace '<<BITBUCKET_COMMIT_ID>>', $bitbucket_commit_id `
    -replace '<<BITBUCKET_USERNAME>>', $bitbucket_username `
    -replace '<<BITBUCKET_PASSWORD>>', $bitbucket_password `
    -replace '<<GITHUB_OWNER_NAME>>', $github_owner_name `
    -replace '<<GITHUB_REPO_NAME>>', $github_repo_name `
    -replace '<<GITHUB_REF>>', $github_ref `
    -replace '<<GITHUB_COMMIT_ID>>', $github_commit_id `
    -replace '<<GITHUB_USERNAME>>', $github_username `
    -replace '<<GITHUB_ACCESS_TOKEN>>', $github_access_token `
    -replace '<<GITLAB_HOST_URL>>', $gitlab_url `
    -replace '<<GITLAB_TOKEN>>', $gitlab_token `
    -replace '<<POLARIS_PROJECT_NAME>>', $polaris_project_name `
    -replace '<<POLARIS_SERVER_URL>>', $polaris_server_url `
    -replace '<<POLARIS_ACCESS_TOKEN>>', $polaris_access_token `
    -replace '<<BLACKDUCK_PROJECT_NAME>>', $blackduck_project_name `
    -replace '<<BLACKDUCK_SERVER_URL>>', $blackduck_server_url `
    -replace '<<BLACKDUCK_ACCESS_TOKEN>>', $blackduck_access_token `
    -replace '<<COVERITY_SERVER_URL>>', $coverity_server_url `
    -replace '<<COVERITY_STREAM>>', $coverity_stream `
    -replace '<<COVERITY_USERNAME>>', $coverity_username `
    -replace '<<COVERITY_PASSWORD>>', $coverity_password `
    -replace '<<SEEKER_PROJECT_NAME>>', $seeker_project_name `
    -replace '<<SEEKER_SERVER_URL>>', $seeker_server_url `
    -replace '<<SEEKER_ACCESS_TOKEN>>', $seeker_access_token `
    -replace '<<CODEDX_SERVER_URL>>', $codedx_server_url `
    -replace '<<CODEDX_API_KEY>>', $codedx_api_key `
    -replace '<<CODEDX_PROJECT_ID>>', $codedx_project_id `
    -replace '<<CODEDX_MIN_RISK_SCORE>>', $codedx_min_risk_score `
    -replace '<<IS_SAST_ENABLED>>', $is_sast_enabled `
    -replace '<<IS_SCA_ENABLED>>', $is_sca_enabled `
    -replace '<<IS_DAST_ENABLED>>', $is_dast_enabled `
    -replace '<<SCM_TYPE>>', $scm_type `
    -replace '<<SCM_OWNER>>', $scm_owner `
    -replace '<<SCM_REPO_NAME>>', $scm_repo_name `
    -replace '<<SCM_BRANCH_NAME>>', $scm_branch_name

Write-Host "IO manifest file generated"

Write-Host $synopsys_io_manifest

$synopsys_io_manifest | Out-File -FilePath .\synopsys-io.json

function getIOPrescription {
    Write-Host "Getting IO Prescription"

    Write-Host "SCM TYPE: ${scm_type}"
    Write-Host "Using the repository ${scm_repo_name} and branch ${scm_branch_name}. Action triggered by ${scm_owner}"

    $API="update"
    if($persona -eq "developer") {
        $API="update/persona/$persona"
    }

    $url = "${ioiq_url}/io/api/manifest/${API}"
  
    $headers = @{
        "Authorization"="Bearer $io_token"
        "Content-Type"="application/json"
        "Accept"="application/json"
    }
    $postParams = $synopsys_io_manifest
    
    Write-Host "IO Prescription -->"
    $Response = Invoke-WebRequest -Uri $url -Method POST -Headers $headers -Body $postParams -SkipHttpErrorCheck -OutFile 'result.json' -PassThru
    
    $ResponseBody = $Response.Content    
    Write-Host $ResponseBody
    
    $StatusCode = $Response.StatusCode
    if($StatusCode -ne 200 -And $StatusCode -ne 201) {
        Write-Error "Error: API $url returned ${StatusCode}" -ErrorAction Stop
    }
    
    $ResponseBodyJSON = ConvertFrom-Json $ResponseBody
    $isSastEnabled = $ResponseBodyJSON.security.activities.sast.enabled
    Write-Host "isSastEnabled: ${isSastEnabled}"
    
    if($isSastEnabled -eq $true) {
        Write-Host "Run polaris"
    } else {
        Write-Host "Don't run polaris"
    }
}

if($stage -eq "IO") {
    getIOPrescription 
} elseif($stage -eq "WORKFLOW") {
    write-host("STAGE WORKFLOW")
} else {
    Write-Error "Invalid Stage" -ErrorAction Stop
}
