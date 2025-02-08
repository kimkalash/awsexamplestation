Import-Module AWS.Tools.S3

$region = "us-east-1"
$bucketName = Read-Host -prompt "Enter the s3 bucket name:"

Write-Host "AWS Region: $region"
Write-Host "AWS Bucket name : $bucketName"




function Bucketexists{
$bucket = Get-S3Bucket -BucketName $bucketName -ErrorAction SilentlyContinue  return $bucket -ne $null
}

# Check if the bucket exists
if (Get-S3Bucket -BucketName $bucketName -ErrorAction SilentlyContinue) {
    Write-Host "Bucket '$bucketName' already exists."
} else {
    Write-Host "Bucket '$bucketName' does not exist. Creating it now..."
    New-S3Bucket -BucketName $bucketName -Region $region
    Write-Host "Bucket '$bucketName' created successfully in region '$region'."
}

New-S3Bucket -BucketName $bucketName -Region $region

$filename = "myfile.text"
$filecontent = "Hello world"

Set-Content -Path $filename -Value $filecontent

Write-S3Object -BucketName $bucketName -File $filename -Key $filename