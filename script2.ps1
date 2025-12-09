Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
#estos comando permite usar ventanas, botones, tamaños colores y posiciones.
# Create form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Input Form"
$form.Size = New-Object System.Drawing.Size(500,250)
$form.StartPosition = "CenterScreen"
#estos comandos crean una ventana, le ponen de título "Input Form", le dan tamaño 500 x 250 pixeles y aparece centrada en la pantalla
############# Define labels
$textLabel1 = New-Object System.Windows.Forms.Label
$textLabel1.Text = "Input 1:"
$textLabel1.Left = 20
$textLabel1.Top = 20
$textLabel1.Width = 120
#estos comandos se repiten para crear los 3 inputs. y los posiciona de la siguiente manera: .left izquierda, .top arriba, .width ancho.
$textLabel2 = New-Object System.Windows.Forms.Label
$textLabel2.Text = "Input 2:"
$textLabel2.Left = 20
$textLabel2.Top = 60
$textLabel2.Width = 120

$textLabel3 = New-Object System.Windows.Forms.Label
$textLabel3.Text = "Input 3:"
$textLabel3.Left = 20
$textLabel3.Top = 100
$textLabel3.Width = 120

############# Textbox 1
$textBox1 = New-Object System.Windows.Forms.TextBox
$textBox1.Left = 150
$textBox1.Top = 20
$textBox1.Width = 200
#estos comandos crean la caja para escribir el input, e igual tienen una posicion y ancho. se repite de igual forma en los 3.
############# Textbox 2
$textBox2 = New-Object System.Windows.Forms.TextBox
$textBox2.Left = 150
$textBox2.Top = 60
$textBox2.Width = 200

############# Textbox 3
$textBox3 = New-Object System.Windows.Forms.TextBox
$textBox3.Left = 150
$textBox3.Top = 100
$textBox3.Width = 200

############# Default values
$defaultValue = ""
$textBox1.Text = $defaultValue
$textBox2.Text = $defaultValue
$textBox3.Text = $defaultValue
#aquí se indica que las cajas de texto debes empezar vacias. dentro de las comillas no se ingresa nada.
############# OK Button
$button = New-Object System.Windows.Forms.Button
$button.Left = 360
$button.Top = 140
$button.Width = 100
$button.Text = "OK"
#crea un boton OK, ahorita solo funciona como un boton que no hace nada
############# Button click event
$button.Add_Click({
    $form.Tag = @{
        Box1 = $textBox1.Text
        Box2 = $textBox2.Text
        Box3 = $textBox3.Text
    }
    $form.Close()
})
#aqui configura para que al dar click al boton OK se guarden los 3 inputs dentro de ($form.Tag) y se cierra la ventana.
############# Add controls
$form.Controls.Add($button)
$form.Controls.Add($textLabel1)
$form.Controls.Add($textLabel2)
$form.Controls.Add($textLabel3)
$form.Controls.Add($textBox1)
$form.Controls.Add($textBox2)
$form.Controls.Add($textBox3)
# estos comandos sirven para añadir todos los botones y cajas de texto creados anteriormente a la ventana.
############# Show dialog
$form.ShowDialog() | Out-Null
#y este comando muestra la ventana, y (Out-Null) evita que se vean mensajes extra en la consola
############# Return values
return $form.Tag.Box1, $form.Tag.Box2, $form.Tag.Box3
#este comando devuelve los 3 inputs que escribió el usario. para entender mejor despues de este comando se puede implementar otros para sumar los vlaores,etc.