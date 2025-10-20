param(
  [int]$Port = 8000,
  [string]$Root = "c:\Users\joaoj\Downloads\Aula Python"
)
Add-Type -AssemblyName System.Net
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$Port/")
$listener.Start()
Write-Host "Preview URL: http://localhost:$Port/"
Write-Host "Preview URL: http://localhost:$Port/arabuscador.html"
try {
  while ($true) {
    $context = $listener.GetContext()
    $req = $context.Request
    $path = $req.Url.LocalPath.TrimStart('/')
    if ([string]::IsNullOrEmpty($path)) { $path = 'arabuscador.html' }
    $full = Join-Path $Root $path
    if (-not (Test-Path $full)) {
      $context.Response.StatusCode = 404
      $bytes = [System.Text.Encoding]::UTF8.GetBytes("Not Found")
      $context.Response.OutputStream.Write($bytes, 0, $bytes.Length)
      $context.Response.Close()
      continue
    }
    if (Test-Path $full -PathType Container) {
      # Serve default file inside directories
      $candidates = @('index.html','arabuscador.html','arabulang.html')
      $found = $null
      foreach ($i in $candidates) {
        $candidate = Join-Path $full $i
        if (Test-Path $candidate -PathType Leaf) { $found = $candidate; break }
      }
      if ($found) {
        $full = $found
      } else {
        $context.Response.StatusCode = 403
        $bytes = [System.Text.Encoding]::UTF8.GetBytes("Forbidden")
        $context.Response.OutputStream.Write($bytes, 0, $bytes.Length)
        $context.Response.Close()
        continue
      }
    }
    $ext = [System.IO.Path]::GetExtension($full).ToLower()
    switch ($ext) {
      '.html' { $context.Response.ContentType = 'text/html; charset=utf-8' }
      '.js'   { $context.Response.ContentType = 'application/javascript; charset=utf-8' }
      '.css'  { $context.Response.ContentType = 'text/css; charset=utf-8' }
      '.arbl' { $context.Response.ContentType = 'text/plain; charset=utf-8' }
      '.gif'  { $context.Response.ContentType = 'image/gif' }
      '.png'  { $context.Response.ContentType = 'image/png' }
      '.jpg'  { $context.Response.ContentType = 'image/jpeg' }
      '.jpeg' { $context.Response.ContentType = 'image/jpeg' }
      '.ico'  { $context.Response.ContentType = 'image/x-icon' }
      default { $context.Response.ContentType = 'application/octet-stream' }
    }
    $bytes = [System.IO.File]::ReadAllBytes($full)
    $context.Response.ContentLength64 = $bytes.Length
    $context.Response.OutputStream.Write($bytes, 0, $bytes.Length)
    $context.Response.Close()
  }
}
finally {
  $listener.Stop()
}