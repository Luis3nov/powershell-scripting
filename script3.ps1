# script3.ps1
function New-FolderCreation {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$foldername
    )

    # Create absolute path for the folder relative to current location
    $logpath = Join-Path -Path (Get-Location).Path -ChildPath $foldername
    if (-not (Test-Path -Path $logpath)) {
        New-Item -Path $logpath -ItemType Directory -Force | Out-Null
    }

    return $logpath
}
# este codigo, crea uan funcion llamada (New-FolderCreation), con ([CmdletBinding()]) convierte esta funcion en un comando avanzado, en param se definen los parametros de entrada como: ([Parameter(Mandatory = $true)]) indica que este parámetro es obligatorio y luego indica que el parametro ($foldername) debe ser texto.
# en esta linea de codigo se obtiene la ruta actual le agrega el nombre de la carpeta y crea una ruta completa. luego con el if revisa si no existe esa carpeta y si no existe la crea. con el (Out Null) evita que se muestre texto en pantalla de ese proceso. luego se cierra el if y se devuelve la ruta completa de la carptea.
function Write-Log { #se crea una funcion
    [CmdletBinding()] #convierte la funcion en un comando avanzado
    param(
        # Create parameter set
        [Parameter(Mandatory = $true, ParameterSetName = 'Create')]
        [Alias('Names')]
        [object]$Name,                    # can be single string or array
#define ese parametro como obligatorio y lo define en el modo Create.
        [Parameter(Mandatory = $true, ParameterSetName = 'Create')]
        [string]$Ext,
#este parametro es la extencion del archivo
        [Parameter(Mandatory = $true, ParameterSetName = 'Create')]
        [string]$folder,
#este parametro es la carpeta donde se guardan los archivos
        [Parameter(ParameterSetName = 'Create', Position = 0)]
        [switch]$Create,

        # Message parameter set
        [Parameter(Mandatory = $true, ParameterSetName = 'Message')]
        [string]$message,
#($message) es el texto del mensaje.
        [Parameter(Mandatory = $true, ParameterSetName = 'Message')]
        [string]$path,
#($path) es la ruta del archivo donde se escribira
        [Parameter(Mandatory = $false, ParameterSetName = 'Message')]
        [ValidateSet('Information','Warning','Error')]
        [string]$Severity = 'Information',

        [Parameter(ParameterSetName = 'Message', Position = 0)]
        [switch]$MSG #activa el modo mensaje
    )

    switch ($PsCmdlet.ParameterSetName) { #detecta si estas usando create o message
        "Create" {
            $created = @()#crea un arreglo vacío para guardar rutas.

            # Normalize $Name to an array
            $namesArray = @()
            if ($null -ne $Name) {
                if ($Name -is [System.Array]) { $namesArray = $Name }
                else { $namesArray = @($Name) }
            }
# este if sirve para asegurarse que ($Name) siempre sea tratado como lista.
            # Date + time formatting (safe for filenames)
            $date1 = (Get-Date -Format "yyyy-MM-dd")
            $time  = (Get-Date -Format "HH-mm-ss")
#estas variables obtienen la fecha actual y la hora actual
            # Ensure folder exists and get absolute folder path
            $folderPath = New-FolderCreation -foldername $folder #este comando Lllama a la primera función y crea la carpeta si no existe.

            foreach ($n in $namesArray) {
                # sanitize name to string
                $baseName = [string]$n #este comando convierte el nombre en texto

                # Build filename
                $fileName = "${baseName}_${date1}_${time}.$Ext" #este crea el nombre del archivo

                # Full path for file
                $fullPath = Join-Path -Path $folderPath -ChildPath $fileName #este comando usa la carpeta y el nombre para obtener la ruta completa

                # Create the file (New-Item -Force will create or overwrite; use -ErrorAction Stop to catch errors)
                try {
                    # If you prefer to NOT overwrite existing file, use: if (-not (Test-Path $fullPath)) { New-Item ... }
                    New-Item -Path $fullPath -ItemType File -Force -ErrorAction Stop | Out-Null #este comando crea el archivo

                    # Optionally write a header line (uncomment if desired)
                    # "Log created: $(Get-Date)" | Out-File -FilePath $fullPath -Encoding UTF8 -Append

                    $created += $fullPath #y este guarda la ruta en el arreglo
                }
                catch {
                    Write-Warning "Failed to create file '$fullPath' - $_"
                }
            }

            return $created #y este devuelve todas las rutas creadas
        }

        "Message" {
            # Ensure directory for message file exists
            $parent = Split-Path -Path $path -Parent
            if ($parent -and -not (Test-Path -Path $parent)) {
                New-Item -Path $parent -ItemType Directory -Force | Out-Null
            }

            $date = Get-Date
            $concatmessage = "|$date| |$message| |$Severity|" #construye esta linea |fecha| |mensaje| |tipo|

            switch ($Severity) {
                "Information" { Write-Host $concatmessage -ForegroundColor Green }
                "Warning"     { Write-Host $concatmessage -ForegroundColor Yellow }
                "Error"       { Write-Host $concatmessage -ForegroundColor Red }
            }

            # Append message to the specified path (creates file if it does not exist)
            Add-Content -Path $path -Value $concatmessage -Force

            return $path
        }

        default {
            throw "Unknown parameter set: $($PsCmdlet.ParameterSetName)"
        }
    }
}

# ---------- Example usage ----------
# This will create the folder "logs" (if missing) and create a file Name-Log_YYYY-MM-DD_HH-mm-ss.log
$logPaths = Write-Log -Name "Name-Log" -folder "logs" -Ext "log" -Create
$logPaths