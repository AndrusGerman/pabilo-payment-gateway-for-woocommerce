$src = "C:\Users\andru\Local Sites\pabilo-demo\app\public\wp-content\plugins\pabilo-payment-gateway-for-woocommerce"
$svnDir = "C:\Users\andru\Local Sites\pabilo-demo\app\public\wp-content\plugins\.svn-pabilo-repo\pabilo-payment-gateway-for-woocommerce"

Write-Host "========================================="
Write-Host "Preparando archivos para el repositorio SVN"
Write-Host "========================================="

# 1. Copiar todo el código a la carpeta trunk, excluyendo lo innecesario
Write-Host "`n[1/3] Copiando código principal a /trunk..."
# /MIR copia subdirectorios y borra los que ya no existen en origen
# /XD excluye directorios: .git y assets (los assets van a la raíz de SVN)
# /XF excluye archivos: la guía y este mismo script
$robocopyOptions = @("/MIR", "/XD", ".git", "assets", "/XF", "GUIA_PUBLICACION_WPORG.md", "deploy-to-svn.ps1")
$roboArgs = @($src, "$svnDir\trunk") + $robocopyOptions
& robocopy @roboArgs | Out-Null

# 2. Copiar assets a la carpeta /assets del SVN
Write-Host "[2/3] Copiando imágenes y recursos a /assets..."
if (Test-Path "$src\assets") {
    $roboArgsAssets = @("$src\assets", "$svnDir\assets", "/MIR")
    & robocopy @roboArgsAssets | Out-Null
} else {
    Write-Host "  -> No se encontró carpeta 'assets' en el origen. Omitido."
}

# 3. Informar al usuario sobre los comandos de SVN siguientes
Write-Host "`n[3/3] ¡Archivos copiados con éxito al directorio SVN!"
Write-Host "========================================="
Write-Host "Para subir los cambios a WordPress.org, abre tu terminal y ejecuta:"
Write-Host ""
Write-Host "  cd `"$svnDir`""
Write-Host "  svn status                # Para revisar qué archivos han cambiado/agregado/eliminado"
Write-Host "  svn add --force *         # Para agregar cualquier archivo nuevo"
Write-Host "  svn commit -m `"Release 1.0.5`" --username pabilo --password <tu_contraseña>"
Write-Host "========================================="
Write-Host "Recuerda que también debes crear el tag para la versión (ej. 1.0.5):"
Write-Host "  svn cp https://plugins.svn.wordpress.org/pabilo-payment-gateway-for-woocommerce/trunk https://plugins.svn.wordpress.org/pabilo-payment-gateway-for-woocommerce/tags/1.0.5 -m `"Tagging version 1.0.5`" --username pabilo --password <tu_contraseña>"
