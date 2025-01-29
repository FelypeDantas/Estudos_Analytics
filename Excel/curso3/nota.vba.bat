Sub Nota()
  Dim Nota As Double
    Nota = Range("C6").Value

    If Nota >= 6 Then
    Range("D6").Value = "Aprovado"
    Range("D6").Interior.ColorIndex = 4

    ElseIf Nota <= 3 Then
    Range("D6").Value = "Reprovado"
    Range("D6").Interior.ColorIndex = 3

    ElseIf Nota >= 4 And Nota < 6 Then
    Range("D6").Value = "Exame"
    Range("D6").Interior.ColorIndex = 44
    End If
 End Sub