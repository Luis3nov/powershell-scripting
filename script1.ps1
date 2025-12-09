function Start-ProgressBar { #aqui estoy creando una funcion
    [CmdletBinding()] #aqui le dice a powershell que la función se comporte como un comando avanzado
    param (
        [Parameter(Mandatory = $true)]
        $Title,
        
        [Parameter(Mandatory = $true)]
        [int]$Timer
    )
    #aqui se definen los parametros necesarios para que la funcion necesita, por ejemplo ($Title) es el título de la barra de progreso y ($Timer) es el tiempo total en segundos
    for ($i = 1; $i -le $Timer; $i++) {
        Start-Sleep -Seconds 1
        $percentComplete = ($i / $Timer) * 100
        Write-Progress -Activity $Title -Status "$i seconds elapsed" -PercentComplete $percentComplete
    }
} 
#finalmente ese es el bucle for que funciona como un temporizador, empieza en 1 Sigue mientras ($i) sea menor o igual a ($Timer) y aumenta de 1 en 1

Start-ProgressBar -Title "Test timeout" -Timer 30
#este comando llama a la funcion, dice el titulo que se mostrara, cuanto durará y muestra la barra de progreso.